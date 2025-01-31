import 'package:flutter/material.dart';
import '../widgets/buttons/continue_button.dart';
import '../widgets/worksheets/worksheet_app_bar.dart';
import '../services/api_service_worksheets.dart';
import '../utilities/worksheet.dart';
import '../models/worksheet.dart';

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

  /// Fetches a worksheet from the API based on the provided worksheet ID.
  Future<Worksheet> _loadWorksheet(int worksheetId) async {
    final ApiService apiService = ApiService();
    final data = await apiService.getWorksheet(worksheetId);
    return Worksheet.fromJson(data);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Worksheet>(
      future: _worksheetFuture,
      builder: (context, snapshot) {
        // Handle API errors.
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        // Display a loading indicator while waiting for data.
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        // Data has been successfully fetched.
        final worksheet = snapshot.data!;
        final WorksheetStateManager worksheetStateManager =
            WorksheetStateManager(worksheet: worksheet);
        final totalPages = worksheetStateManager.calculateTotalPages();

        return StreamBuilder<int>(
          stream: worksheetStateManager.currentPageIndexStream,
          builder: (context, currentPageIndexSnapshot) {
            final currentPageIndex = currentPageIndexSnapshot.data ?? 0;

            return Scaffold(
              appBar: WorksheetAppBar(
                title: worksheet.title,
                progressValue: currentPageIndex / totalPages,
                onClose: () {
                  Navigator.of(context).pop(); // Close dialog
                },),
              body: StateManagerProvider(
                stateManager: stateManager,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 6.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Render the widget for the current task.
                      Expanded(
                        child: worksheetStateManager.getWidgetForTask(),
                      ),
                      // Add a "Continue" button to evaluate answers.
                      ContinueButton(
                        text: 'Vyhodnotit',
                        onPressed: () {
                          stateManager.setPageState(PageState.evaluate);
                          final correctAnswer =
                              worksheetStateManager.saveAnswers(stateManager);

                          // Show feedback modal with the results.
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
