import 'package:flutter/material.dart';

class AchievementCard extends StatelessWidget {
  final String imageUrl;
  final String cardTitle;
  final String cardDescription;
  final String levelText;

  const AchievementCard({
    super.key,
    required this.imageUrl,
    required this.cardTitle,
    required this.cardDescription,
    required this.levelText,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              flex: 3,
              child: Image.asset(
                imageUrl,
                height: 95.0,
              ),
            ),
            const SizedBox(width: 20.0),
            Expanded(
              flex: 7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cardTitle,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 2.0),
                  Text(
                    levelText,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade900,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    cardDescription,
                    softWrap: true,
                    overflow: TextOverflow.visible,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade800,
                    ),
                  ),
                ],
              ),
            ),
          ],
    );
  }
}
