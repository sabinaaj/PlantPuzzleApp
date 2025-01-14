import 'package:flutter/material.dart';
import 'package:plant_puzzle_app/screens/worksheet_page.dart';
import '../models/worksheet.dart';
import 'buttons/border_button.dart';

class WorksheetCard extends StatelessWidget {
  final WorksheetSummary worksheet;

  const WorksheetCard({super.key, required this.worksheet});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        border: Border.all(
          color: Colors.grey.shade300,
          width: 2.0,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      child: Text(
                        worksheet.title,
                        maxLines: 4,
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    const Text(
                      'Další info',
                      style: TextStyle(
                        fontSize: 14.0,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            BorderButton(
              text: 'Spustit test',
              width: MediaQuery.of(context).size.width * 0.85,
              onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WorksheetPage(worksheetId: worksheet.id),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
