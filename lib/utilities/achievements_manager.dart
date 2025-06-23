import 'package:flutter/material.dart';
import '../models/visitors.dart';
import '../widgets/buttons/border_button.dart';
import '../services/data_service_visitors.dart';
import '../widgets/achievement_card.dart';

class AchievementManager {
  static final AchievementManager _instance = AchievementManager._internal();
  factory AchievementManager() => _instance;
  AchievementManager._internal();

  final DataServiceVisitors dataService = DataServiceVisitors();
  static List<Achievement> _achievements = [];

final List<Achievement> _defaultAchievements = [
  Achievement(
    id: 'first_login',
    title: 'První přihlášení',
    description: 'Gratuluju! Máš první trofej. Pokračuj dál a odemkni další trofeje!',
    imageUrl: 'plant_trophy',
    cardTitle: 'Průzkumník',
    cardDescription: 'Trofej získaná za první přihlášení.',
    level: 1
  ),

  Achievement(
    id: 'first_worksheet',
    title: 'První test',
    description: 'Paráda! Vyplnil jsi svůj první test. To byl jen začátek, zvládneš jich víc?',
    imageUrl: 'silver_trophy',
    cardTitle: 'Skleníkový nadšenec',
    cardDescription: 'Trofej získaná za první vyplněný pracovní list. Pro další úroveň vyplň všechny testy v jedné oblasti!',
    level: 1
  ),

  Achievement(
    id: 'area_worksheets',
    title: 'Oblast dokončena',
    description: 'Wow! Dokončil jsi všechny testy v jedné oblasti. Dokážeš projít všechny?',
    imageUrl: 'trophy',
    cardTitle: 'Objevitel oblastí',
    cardDescription: 'Trofej získaná za dokončení všech testů v jedné oblasti. Pro další úroveň dokonči testy ve všech oblastech!',
    level: 2
  ),

  Achievement(
    id: 'all_worksheets',
    title: 'Všechny testy hotové!',
    description: 'Jsi opravdu znalec! Dokončil jsi všechny testy. Jsi připraven na další výzvy?',
    imageUrl: 'diamond_trophy',
    cardTitle: 'Vědomostní mistr',
    cardDescription: 'Trofej získaná za dokončení všech testů. Teď už jsi opravdu expert!',
    level: 3
  ),

  Achievement(
    id: 'success_rate_50',
    title: 'Půlka správně!',
    description: 'Dobrá práce! Tvůj průměr úspěšnosti je nad 50 %. Jen tak dál!',
    imageUrl: 'silver_trophy',
    cardTitle: 'Rostoucí hvězda',
    cardDescription: 'Trofej získaná za průměrnou úspěšnost nad 50 %. Pro další úroveň dosáhni 75 %!',
    level: 1
  ),

  Achievement(
    id: 'success_rate_75',
    title: 'Skvělý výkon!',
    description: 'Úžasné! Máš průměrnou úspěšnost vyšší než 75 %. Dokážeš dosáhnout 100 %?',
    imageUrl: 'trophy',
    cardTitle: 'Šampion vědomostí',
    cardDescription: 'Trofej získaná za úspěšnost nad 75 %. Pro další úroveň dosáhni dokonalých 100 %!',
    level: 2
  ),

  Achievement(
    id: 'success_rate_100',
    title: 'Mistr testů!',
    description: 'Neuvěřitelné! Máš 100% úspěšnost. Jsi opravdu expert!',
    imageUrl: 'diamond_trophy',
    cardTitle: 'Nedostižný mistr',
    cardDescription: 'Trofej získaná za 100% úspěšnost. To je absolutní vrchol!',
    level: 3
  ),

  Achievement(
    id: 'better_than_25',
    title: 'Lepší než čtvrtina hráčů!',
    description: 'Už jsi překonal 25 % hráčů. Pokračuj a posuň se ještě výš!',
    imageUrl: 'silver_trophy',
    cardTitle: 'Slibný talent',
    cardDescription: 'Trofej získaná za překonání 25 % hráčů. Pro další úroveň buď lepší než 50 %!',
    level: 1
  ),

  Achievement(
    id: 'better_than_50',
    title: 'Lepší než polovina!',
    description: 'Skvělý výkon! Jsi lepší než 50 % hráčů. Dokážeš se dostat mezi top 25 %?',
    imageUrl: 'trophy',
    cardTitle: 'Šampion mezi hráči',
    cardDescription: 'Trofej získaná za překonání 50 % hráčů. Pro další úroveň buď lepší než 75 %!',
    level: 2
  ),

  Achievement(
    id: 'better_than_75',
    title: 'Mezi nejlepšími!',
    description: 'Wow! Jsi lepší než 75 % hráčů. Už jen kousek do absolutní špičky!',
    imageUrl: 'diamond_trophy',
    cardTitle: 'Elitní hráč',
    cardDescription: 'Trofej získaná za překonání 75 % hráčů.',
    level: 3
  ),

  Achievement(
    id: 'completion',
    title: 'Vše splněno!',
    description: 'Dokázal jsi to! Získal jsi všechny trofeje a splnil všechny výzvy.',
    imageUrl: 'diamond_trophy',
    cardTitle: 'Legenda',
    cardDescription: 'Trofej získaná za splnění všech výzev. Jsi absolutní šampion!',
    level: 1
  ),
];

  void loadAchievements() {
    List<Achievement> fetchedAchievements = dataService.getAchievements();

    if (fetchedAchievements.isNotEmpty) {
      _achievements = fetchedAchievements;
    } else {
      _achievements = _defaultAchievements;
    }
  }

  Widget getCardContent(int index) {
    final achievements = dataService.getAchievements();

    switch (index) {
      case 0:
        final firstLogin = achievements.firstWhere((achievement) => achievement.id == 'first_login');

        if (firstLogin.unlocked) {
          return AchievementCard(
            imageUrl: 'assets/images/${firstLogin.imageUrl}.png',
            cardTitle: firstLogin.cardTitle,
            cardDescription: firstLogin.cardDescription,
            levelText: 'Získáno');

        } else {
          return AchievementCard(
            imageUrl: 'assets/images/locked_trophy.png',
            cardTitle: firstLogin.cardTitle,
            cardDescription: 'Pro získání trofeje je potřeba se přihlásit.',
            levelText: 'Zamčeno');}
        
      case 1:
        Achievement testAchievement = achievements.firstWhere((achievement) => achievement.id == 'all_worksheets');

        if (!testAchievement.unlocked) {
          testAchievement = achievements.firstWhere((achievement) => achievement.id == 'area_worksheets'); 
        }

        if (!testAchievement.unlocked) {
          testAchievement = achievements.firstWhere((achievement) => achievement.id == 'first_worksheet'); 
        }

        if (!testAchievement.unlocked) {
          return AchievementCard(
            imageUrl: 'assets/images/locked_trophy.png',
            cardTitle: 'Skleníkový nadšenec',
            cardDescription: 'Pro získání trofeje je potřeba vyplnit pracovní list.',
            levelText: 'Zamčeno');
        }

        return AchievementCard(
          imageUrl: 'assets/images/${testAchievement.imageUrl}.png',
          cardTitle: testAchievement.cardTitle,
          cardDescription: testAchievement.cardDescription,
          levelText: '${testAchievement.level} ze 3 trofejí');

      case 2:
        Achievement successRateAchievement = achievements.firstWhere((achievement) => achievement.id == 'success_rate_100');

        if (!successRateAchievement.unlocked) {
          successRateAchievement = achievements.firstWhere((achievement) => achievement.id == 'success_rate_75'); 
        }

        if (!successRateAchievement.unlocked) {
          successRateAchievement = achievements.firstWhere((achievement) => achievement.id == 'success_rate_50'); 
        }

        if (!successRateAchievement.unlocked) {
          return AchievementCard(
            imageUrl: 'assets/images/locked_trophy.png',
            cardTitle: 'Rostoucí hvězda',
            cardDescription: 'Pro získání trofeje je potřeba mít úspěšnost alespoň 50% a alespoň polovinu testů.',
            levelText: 'Zamčeno');
        }

        return AchievementCard(
          imageUrl: 'assets/images/${successRateAchievement.imageUrl}.png',
          cardTitle: successRateAchievement.cardTitle,
          cardDescription: successRateAchievement.cardDescription,
          levelText: '${successRateAchievement.level} ze 3 trofejí');

      case 3:
        Achievement betterThanAchievement = achievements.firstWhere((achievement) => achievement.id == 'better_than_75');

          if (!betterThanAchievement.unlocked) {
            betterThanAchievement = achievements.firstWhere((achievement) => achievement.id == 'better_than_50'); 
          }

          if (!betterThanAchievement.unlocked) {
            betterThanAchievement = achievements.firstWhere((achievement) => achievement.id == 'better_than_25'); 
          }

          if (!betterThanAchievement.unlocked) {
            return AchievementCard(
              imageUrl: 'assets/images/locked_trophy.png',
              cardTitle: 'Slibný talent',
              cardDescription: 'Pro získání trofeje je potřeba být lepší než 25% hráčů.',
              levelText: 'Zamčeno');
          }

          return AchievementCard(
            imageUrl: 'assets/images/${betterThanAchievement.imageUrl}.png',
            cardTitle: betterThanAchievement.cardTitle,
            cardDescription: betterThanAchievement.cardDescription,
            levelText: '${betterThanAchievement.level} ze 3 trofejí');
          
      case 4:
        final completion = achievements.firstWhere((achievement) => achievement.id == 'completion');

        if (completion.unlocked) {
          return AchievementCard(
            imageUrl: 'assets/images/${completion.imageUrl}.png',
            cardTitle: completion.cardTitle,
            cardDescription: completion.cardDescription,
            levelText: 'Získáno');

        } else {
          return AchievementCard(
            imageUrl: 'assets/images/locked_trophy.png',
            cardTitle: completion.cardTitle,
            cardDescription: 'Pro získání trofeje je potřeba získat všechny předchozí trofeje.',
            levelText: 'Zamčeno');}
        
      default:
        return Container();
    }
  }

  void unlockAchievement(String id, BuildContext context) {
    final achievement = _achievements.firstWhere((ach) => ach.id == id,
        orElse: () => Achievement(
            id: '',
            title: '',
            description: '',
            cardTitle: '',
            cardDescription: '',
            imageUrl: '',
            level: 0));
            
    if (achievement.id.isNotEmpty && !achievement.unlocked) {
      achievement.unlocked = true;
      dataService.saveAchievements(_achievements);
      WidgetsBinding.instance.addPostFrameCallback((_) {
      _showAchievementDialog(context, achievement.title, achievement.description, achievement.imageUrl);
    });
    }
  }

  void unlockAchievementsAfterWorksheet(BuildContext context) {
    final lockedAchievements = _achievements.where((ach) => !ach.unlocked);

    if (lockedAchievements.isEmpty) return;
  
    for (var ach in lockedAchievements) {
      
      if (ach.id == 'first_worksheet') {
        unlockAchievement('first_worksheet', context);
      }

      if (ach.id == 'area_worksheets') {
        if (dataService.isAnyAreaDone()) {
          unlockAchievement('area_worksheets', context);
        }
      }

      if (ach.id == 'all_worksheets') {
        if (dataService.areAllWorksheetsDone()) {
          unlockAchievement('all_worksheets', context);
        }
      }

      if (ach.id == 'success_rate_50') {
        if (dataService.isHalfOfWorksheetsDone()){
          var successRate = dataService.getSuccessRate();

          if (successRate >= 50) {
            unlockAchievement('success_rate_50', context);
          }
        }
      }
      
      if (ach.id == 'success_rate_75') {
        if (dataService.isHalfOfWorksheetsDone()){
          var successRate = dataService.getSuccessRate();

          if (successRate >= 75) {
            unlockAchievement('success_rate_75', context);
          }
        }
      }

      if (ach.id == 'success_rate_100') {
        if (dataService.isHalfOfWorksheetsDone()){
          var successRate = dataService.getSuccessRate();

          if (successRate >= 100) {
            unlockAchievement('success_rate_100', context);
          }
        }
      }

      if (ach.id == 'completion') {
        if (_achievements.where((ach) => !ach.unlocked).length == 1) {
          unlockAchievement('completion', context);
        }
      }
      
    }
  }

  void unlockBetterThanAchievements(int betterThan, BuildContext context) {

    if (betterThan < 25) return;

    final betterThan25 = _achievements.firstWhere((ach) => ach.id == 'better_than_25');
    if (!betterThan25.unlocked) {
      unlockAchievement('better_than_25', context);
    }

    if (betterThan < 50) return;

    final betterThan50 = _achievements.firstWhere((ach) => ach.id == 'better_than_50');
    if (!betterThan50.unlocked) {
      unlockAchievement('better_than_50', context);
    }

    if (betterThan < 75) return;

    final betterThan75 = _achievements.firstWhere((ach) => ach.id == 'better_than_75');
    if (!betterThan75.unlocked) {
      unlockAchievement('better_than_75', context);
    }

    if (_achievements.where((ach) => !ach.unlocked).length == 1) {
      unlockAchievement('completion', context);
    }
  }


  void _showAchievementDialog(BuildContext context, String title, String description, String imageUrl) {
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
                'assets/images/$imageUrl.png',
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
              height: 50.0,
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
