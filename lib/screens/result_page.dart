// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import '../utilities/worksheet_state_manager.dart';
import '../utilities/achievements_manager.dart';
import '../widgets/buttons/continue_button.dart';

class ResultPage extends StatelessWidget {
  final WorksheetStateManager worksheetStateManager;

  const ResultPage({super.key, required this.worksheetStateManager});

  Widget _buildResultImage(int rate) {
    String imagePath;

    if (rate > 75) {
      imagePath = 'assets/images/happy_flower.png'; // Happy image for high success rate
    } else if (rate < 50) {
      imagePath = 'assets/images/sad_flower.png'; // Sad image for low success rate
    } else {
      imagePath = 'assets/images/meh_flower.png'; // Neutral image for average success rate
    }

    return Image.asset(
      imagePath,
      height: 200,
    );
  }

  Widget _buildResultMessage(int rate) {
    String message;

    if (rate > 75) {
      message = 'Skvělá práce! Jen tak dál!';
    } else if (rate < 50) {
      message = 'Nevadí, příště to bude lepší!';
    } else {
      message = 'Dobrá práce, ale je co zlepšovat.';
    }

    return Text(
      message,
      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
      textAlign: TextAlign.center,
    );
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (ModalRoute.of(context)?.isCurrent == true) {
        AchievementManager().unlockAchievementsAfterWorksheet(context);
      };
    });

    // Calculate success rate and other stats from the worksheet state
    final successRate = worksheetStateManager.getSuccessRate();
    final correctAnswers = worksheetStateManager.getCorrectAnswers();
    final totalPages = worksheetStateManager.totalPages;

    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Display an image based on success rate
                  _buildResultImage(successRate.rate),
                  const SizedBox(height: 20),

                  // Display a message based on success rate
                  _buildResultMessage(successRate.rate),
                  const SizedBox(height: 10),

                  // Display correct answers
                  Text(
                    'Správné odpovědi:',
                    style: const TextStyle(fontSize: 16),
                  ),
                  Text(
                    '$correctAnswers z $totalPages',
                    style: const TextStyle(
                        fontSize: 30, fontWeight: FontWeight.bold),
                  ),

                  // Display success rate
                  const SizedBox(height: 10),
                  Text(
                    'Úspěšnost:',
                    style: const TextStyle(fontSize: 18),
                  ),
                  Text(
                    '${successRate.rate.toString()} %',
                    style: const TextStyle(
                        fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),

            // Continue button
            ContinueButton(
              text: "Dokončit",
              onPressed: () async {
                // Submit responses and navigate back to the main screen
                await worksheetStateManager.submitResponses();
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
            ),
          ],
        ),
      ),
    );
  }
}
