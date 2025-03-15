import 'package:flutter/material.dart';
import '../services/data_service_worksheets.dart';
import '../widgets/buttons/continue_button.dart';
import '../widgets/worksheets/worksheet_app_bar.dart';
import '../utilities/worksheet_state_manager.dart';
import '../models/worksheet.dart';

class WorksheetPage extends StatelessWidget {
  final DataServiceWorksheets dataService = DataServiceWorksheets();
  final StateManager stateManager = StateManager();
  final int worksheetId;

  WorksheetPage({super.key, required this.worksheetId});

  @override
  Widget build(BuildContext context) {
    final Worksheet worksheet = dataService.getWorksheet(worksheetId);
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
            },
          ),

          body: StateManagerProvider(
            stateManager: stateManager,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 12.0,
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
  }
}
