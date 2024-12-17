import 'package:flutter/material.dart';
import 'package:plant_puzzle_app/utilities/worksheet.dart';
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(),

            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                'Správné odpovědi: $correctAnswers z $totalPages',
                style: TextStyle(fontSize: 24),
              ),
              const SizedBox(height: 15),
              Text(
                'Úspěšnost: ${(correctAnswers / totalPages * 100).toStringAsFixed(1)}%',
                style: TextStyle(fontSize: 20),
              )
            ]),
            ContinueButton(
              text: "Dokončit",
              onPressed: () {
                int count = 0;
                Navigator.popUntil(
                  context,
                  (route) {
                    count++;
                    return count > 2;
                  },
                );
              },
            ),
          ],
        ),
      )
    );
  }
}
