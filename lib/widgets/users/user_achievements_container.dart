import 'package:flutter/material.dart';
import '../../services/data_service_visitors.dart';
import '../border_container.dart';
import '../../../models/visitors.dart';

class UserAchievementsContainer extends StatelessWidget {
  final DataServiceVisitors dataService = DataServiceVisitors();
  final Visitor visitor;

  UserAchievementsContainer({
    super.key,
    required this.visitor,
  });

  final PageController _pageController = PageController(viewportFraction: 0.90);

  List<Widget> _getCardContent(int index) {
    switch (index) {
      case 0:
        return [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/trophy.png',
                height: 100.0,
              ),
              const SizedBox(width: 8.0),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Průzkumník',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 16, height: 1.1, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Získáno',
                    style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
                  ),
                  Text(
                    'Trofej získaná za první přihlášení.',
                    softWrap: true,
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
                  ),
                ],
              ),
            ],
          ),
        ];
      case 1:
        return [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/locked_trophy.png',
                height: 100.0,
              ),
              const SizedBox(width: 8.0),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Splněné testy',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 16, height: 1.1, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '1 ze 3 trofejí',
                    style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
                  ),
                  Text(
                    'Trofej získaná za první vyplněný pracovní list. Pro další úroveň vyplň všechny testy v oblasti.',
                    softWrap: true,
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
                  ),
                ],
              ),
            ],
          ),
        ];
      case 2:
        return [
          Text(
            'Mistr úspěšnosti',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 14, height: 1.1),
          ),
          Text(
            '1 z 3 úrovní',
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey.shade700),
          ),
        ];
      case 3:
        return [
          Text(
            'Překonávač rekordů',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 14, height: 1.1),
          ),
          Text(
            '1 z 3 úrovní',
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey.shade700),
          ),
        ];
      case 4:
        return [
          Text(
            'Vše splněno!',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 14, height: 1.1),
          ),
          Text(
            'Dokončeno!',
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey.shade700),
          ),
        ];
      default:
        return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 6.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/trophy_icon.png',
                height: 25.0,
              ),
              const SizedBox(width: 8.0),
              const Text(
                'Trofeje',
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8.0),
        SizedBox(
          height: 150,
          child: PageView.builder(
            controller: _pageController,
            itemCount: 5,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: SizedBox(
                    width: 220, 
                    child: BorderContainer(
                      padding: 16,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: _getCardContent(index),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
