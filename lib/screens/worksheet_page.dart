import 'package:flutter/material.dart';
import '../widgets/buttons/continue_button.dart';
import '../../models/worksheet.dart';
import '../services/api_service_worksheets.dart';
import '../utilities/worksheet.dart';

class WorksheetPage extends StatefulWidget {
  final int worksheetId;

  const WorksheetPage({super.key, required this.worksheetId});

  @override
  State<WorksheetPage> createState() => _WorksheetPageState();
}

class _WorksheetPageState extends State<WorksheetPage> {
  late Future<Worksheet> _worksheetFuture;
  final StateManager stateManager = StateManager();

  @override
  void initState() {
    super.initState();
    _worksheetFuture = _loadWorksheet(widget.worksheetId);
  }

  /// Loads a worksheet from the API using the provided worksheet ID.
  Future<Worksheet> _loadWorksheet(int worksheetId) async {
    final ApiService apiService = ApiService();
    final data = await apiService.getWorksheet(worksheetId);
    return Worksheet.fromJson(data);
  }

  @override

  /// Builds the main page for a worksheet.
  Widget build(BuildContext context) {
    return FutureBuilder<Worksheet>(
      future: _worksheetFuture,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final worksheet = snapshot.data!;
        final WorksheetStateManager worksheetStateManager =
            WorksheetStateManager(worksheet: worksheet);
        final totalPages = worksheetStateManager.calculateTotalPages();

        return StreamBuilder<int>(
          stream: worksheetStateManager.currentPageIndexStream,
          builder: (context, currentPageIndexSnapshot) {
            final currentPageIndex = currentPageIndexSnapshot.data ?? 0;

            return Scaffold(
              appBar: AppBar(
                title: const Text('Test'),
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(4.0),
                  child: LinearProgressIndicator(
                    value: currentPageIndex / totalPages,
                    backgroundColor: Colors.grey[300],
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(Color(0xFF93C572)),
                  ),
                ),
              ),
              body: StateManagerProvider(
                stateManager: stateManager,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 6.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: worksheetStateManager.getWidgetForTask(),
                      ),
                      ContinueButton(
                        text: 'Vyhodnotit',
                        onPressed: () {
                          stateManager.setPageState(PageState.evaluate);
                          final correctAnswer =
                              worksheetStateManager.saveAnswers(stateManager);

                          worksheetStateManager.showFeedbackModal(
                            context,
                            correctAnswer,
                            () {
                              stateManager.resetButtons();
                              worksheetStateManager.nextPage(context);
                              stateManager.setPageState(PageState.answer);
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
