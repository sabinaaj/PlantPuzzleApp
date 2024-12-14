import 'package:flutter/material.dart';
import 'package:plant_puzzle_app/utilities/worksheets.dart';
import '../../widgets/continue_button.dart';

class ResultPage extends StatelessWidget {
    final WorksheetStateManager worksheetStateManager;

    const ResultPage({super.key, required this.worksheetStateManager});

  @override
  Widget build(BuildContext context) {
    final correctAnswers = worksheetStateManager.getCorrectAnswers();
    final totalPages = worksheetStateManager.totalPages;

    return Scaffold(
      appBar: AppBar(title: Text('Výsledky testu')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Správné odpovědi: $correctAnswers z $totalPages',
              style: TextStyle(fontSize: 24),
            ),
            Text(
              'Úspěšnost: ${(correctAnswers / totalPages * 100).toStringAsFixed(1)}%',
              style: TextStyle(fontSize: 20),
            ),
            ContinueButton(
              text: "Dokončit",
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/worksheet',
                  (Route<dynamic> route) => false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}