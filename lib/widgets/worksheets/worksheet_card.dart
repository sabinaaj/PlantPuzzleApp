import 'package:flutter/material.dart';
import '../buttons/border_button.dart';
import '../../models/worksheet.dart';
import '../../colors.dart';
class WorksheetCard extends StatelessWidget {
  final WorksheetSummary worksheet;
  final VoidCallback? onPressed;

  const WorksheetCard({
    super.key,
    required this.worksheet,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
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
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4.0),

                    worksheet.successRate != null
                    ? RichText(
                        text: TextSpan(
                          style: const TextStyle(
                            color: Colors.black, // Barva textu
                          ),
                          children: [
                            TextSpan(
                              text: '${worksheet.successRate}%', // Tučné zobrazení rate
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const TextSpan(
                              text: ' úspěšnost', // Normální text
                            ),
                          ],
                        ),
                      )
                    : const Text(
                        'Tento test ještě nebyl dokončen.',
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            BorderButton(
              text: 'Spustit test',
              width: MediaQuery.of(context).size.width * 0.85,
              backgroundColor: AppColors.primaryGreen,
              borderColor: AppColors.secondaryGreen,
              onPressed: onPressed,
            ),
          ],
        ),
      ),
    );
  }
}
