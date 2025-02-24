import 'package:flutter/material.dart';
import '../models/visitors.dart';
import '../widgets/buttons/border_button.dart';
import '../services/data_service_visitors.dart';

class AchievementManager {
  static final AchievementManager _instance = AchievementManager._internal();
  factory AchievementManager() => _instance;
  AchievementManager._internal();

  final DataServiceVisitors dataService = DataServiceVisitors();

  final List<Achievement> _achievements = [
  Achievement(
    id: 'first_login',
    title: 'První přihlášení',
    description: 'Gratuluju! Udělal jsi první krok na své cestě za poznáním. Pokračuj dál a odemkni další trofeje!',
  ),
  
  Achievement(
    id: 'first_worksheet',
    title: 'První test',
    description: 'Paráda! Vyplnil jsi svůj první test. To byl jen začátek, zvládneš jich víc?',
  ),
  
  Achievement(
    id: 'area_worksheet',
    title: 'Oblast dokončena',
    description: 'Wow! Dokončil jsi všechny testy v jedné oblasti. Dokážeš projít všechny?',
  ),
  
  Achievement(
    id: 'all_worksheet',
    title: 'Všechny testy hotové!',
    description: 'Jsi opravdu znalec! Dokončil jsi všechny testy. Jsi připraven na další výzvy?',
  ),
  
  Achievement(
    id: 'success_rate_50',
    title: 'Půlka správně!',
    description: 'Dobrá práce! Tvůj průměr úspěšnosti je nad 50 %. Jen tak dál!',
  ),
  
  Achievement(
    id: 'success_rate_75',
    title: 'Skvělý výkon!',
    description: 'Úžasné! Máš průměrnou úspěšnost vyšší než 75 %. Dokážeš dosáhnout 100 %?',
  ),
  
  Achievement(
    id: 'success_rate_100',
    title: 'Mistr testů!',
    description: 'Neuvěřitelné! Máš 100% úspěšnost. Jsi opravdu expert!',
  ),
  
  Achievement(
    id: 'better_than_25',
    title: 'Lepší než čtvrtina hráčů!',
    description: 'Už jsi překonal 25 % hráčů. Pokračuj a posuň se ještě výš!',
  ),
  
  Achievement(
    id: 'better_than_50',
    title: 'Lepší než polovina!',
    description: 'Skvělý výkon! Jsi lepší než 50 % hráčů. Dokážeš se dostat mezi top 25 %?',
  ),
  
  Achievement(
    id: 'better_than_75',
    title: 'Mezi nejlepšími!',
    description: 'Wow! Jsi lepší než 75 % hráčů. Už jen kousek do absolutní špičky!',
  ),
  
  Achievement(
    id: 'completion',
    title: 'Všechno splněno!',
    description: 'Dokázal jsi to! Získal jsi všechny trofeje a splnil všechny výzvy. Jsi nejlepší!',
  ),
];

  List<Achievement> get achievements => _achievements;

  void unlockAchievement(String id, BuildContext context) {
    final achievement = _achievements.firstWhere((ach) => ach.id == id, orElse: () => Achievement(id: '', title: '', description: ''));
    if (achievement.id.isNotEmpty && !achievement.unlocked) {
      achievement.unlocked = true;
      _showAchievementDialog(context, achievement.title, achievement.description);
    }
  }

  void _showAchievementDialog(BuildContext context, String title, String description) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: Colors.grey.shade300, width: 2)),
          title: Column(
            children: [
              Image.asset(
                'assets/images/trophy.png',
                height: 100.0,
              ),
              const SizedBox(height: 10.0),
              Text(title),
            ],
          ),
          content: Text(
            description,
            textAlign: TextAlign.center,
          ),
          actions: [
            BorderButton(
              text: 'OK, díky',
              width: MediaQuery.of(context).size.width * 0.85,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
