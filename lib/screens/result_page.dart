import 'package:flutter/material.dart';
import '../../models/worksheet.dart';

class ResultPage extends StatelessWidget {
  final Worksheet worksheet;
  final List<Option?> userAnswers;

  ResultPage({required this.worksheet, required this.userAnswers});

  @override
  Widget build(BuildContext context) {
    int correctAnswers = 0;
    int totalQuestions = 0;

    // Spočítání správných odpovědí
    for (var task in worksheet.tasks) {
      for (var question in task.questions) {
        totalQuestions++;
        if (userAnswers[totalQuestions - 1]?.isCorrect ?? false) {
          correctAnswers++;
        }
      }
    }

    return Scaffold(
      appBar: AppBar(title: Text('Výsledky testu')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Správné odpovědi: $correctAnswers z $totalQuestions',
              style: TextStyle(fontSize: 24),
            ),
            Text(
              'Úspěšnost: ${(correctAnswers / totalQuestions * 100).toStringAsFixed(1)}%',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}