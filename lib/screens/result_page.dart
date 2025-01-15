import 'package:flutter/material.dart';
import 'package:plant_puzzle_app/utilities/worksheet.dart';
import '../widgets/buttons/continue_button.dart';

class ResultPage extends StatelessWidget {
  final WorksheetStateManager worksheetStateManager;

  const ResultPage({Key? key, required this.worksheetStateManager})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final correctAnswers = worksheetStateManager.getCorrectAnswers();
    final totalPages = worksheetStateManager.totalPages;
    final double successRate = (correctAnswers / totalPages) * 100;

    return Scaffold(
      appBar: AppBar(),
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
                  _buildResultImage(successRate),
                  const SizedBox(height: 20),

                    _buildResultMessage(successRate),
                    const SizedBox(height: 10),
                    Text(
                      'Správné odpovědi:',
                      style: const TextStyle(
                          fontSize: 16),
                    ),
                    Text(
                      '$correctAnswers z $totalPages',
                      style: const TextStyle(
                          fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Úspěšnost:',
                      style: const TextStyle(fontSize: 18),
                    ),
                    Text(
                      '${successRate.toStringAsFixed(1)} %',
                      style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                ],
              ),
            ),
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
      ),
    );
  }

  Widget _buildResultImage(double successRate) {
    String imagePath;
    double imageHeight;

    if (successRate > 75) {
      imagePath = 'assets/images/happy_flower.png';
      imageHeight = 200;
    } else if (successRate < 50) {
      imagePath = 'assets/images/sad_flower.png';
      imageHeight = 200;
    } else {
      imagePath = 'assets/images/meh_flower.png';
      imageHeight = 200;
    }

    return Image.asset(
      imagePath,
      height: imageHeight,
    );
  }

  Widget _buildResultMessage(double successRate) {
    String message;

    if (successRate > 75) {
      message = 'Skvělá práce! Jen tak dál!';
    } else if (successRate < 50) {
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
}
