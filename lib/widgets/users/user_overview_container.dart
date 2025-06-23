import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../../services/data_service_visitors.dart';
import '../../services/api_service_visitors.dart';
import '../../utilities/achievements_manager.dart';
import '../border_container.dart';

class UserOverviewContainer extends StatefulWidget {
  
  const UserOverviewContainer({
    super.key,
  });

  @override
  State<UserOverviewContainer> createState() => _UserOverviewContainerState();
}

class _UserOverviewContainerState extends State<UserOverviewContainer> {
  final DataServiceVisitors dataService = DataServiceVisitors();
  final ApiService apiService = ApiService();
  Future<int?>? futureBetterThan;
  bool isConnected = false;

  @override
  void initState() {
    super.initState();
    _initializeBetterThan();
  }

  /// Fetch 'better than' from the API
  void _initializeBetterThan() async {
    await _checkConnectivity();

    if (!mounted) return;

    setState(() {
      futureBetterThan = isConnected ? apiService.getBetterThan() : Future.value(null);
    });
  }

  /// Check connectivity
  Future<void> _checkConnectivity() async {
    final List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());

    setState(() {
      isConnected = connectivityResult.contains(ConnectivityResult.mobile) ||
          connectivityResult.contains(ConnectivityResult.wifi);
    });
  }

  List<Widget> _getCardContent(int index) {
    final visitorStats = dataService.getVisitorStats();
    final worksheetCount = visitorStats['worksheet_count'] ?? 0;
    final doneWorksheetCount = visitorStats['done_worksheet_count'] ?? 0;
    final avgSuccessRate = visitorStats['average_success_rate'].toInt() ?? 0;
    final achievementsCount = visitorStats['achievements_count'] ?? 0;
    final achievementsUnlocked = visitorStats['achievements_unlocked'] ?? 0;

    switch (index){
      case 0:
        return [
          Text(
            '$doneWorksheetCount/$worksheetCount',
            style: const TextStyle(
                fontSize: 22, fontWeight: FontWeight.bold),
          ),
          Text(
            'Hotových \ntestů',
            style: const TextStyle(fontSize: 14, height: 1.1),
          ),
        ];

      case 1:
        return [
          Text(
            avgSuccessRate > 0 ? '$avgSuccessRate %' : '- %',
            style: const TextStyle(
                fontSize: 22, fontWeight: FontWeight.bold),
          ),
          Text(
            'Průměrná \núspěšnost',
            style: const TextStyle(fontSize: 14, height: 1.1),
          )
        ];

      case 2:
        return [
          Text(
            '$achievementsUnlocked/$achievementsCount',
            style: const TextStyle(
                fontSize: 22, fontWeight: FontWeight.bold),
          ),
          Text(
            'Získaných \npohárů',
            style: const TextStyle(fontSize: 14, height: 1.1),
          )
        ];

      case 3:
        return [
          const Text(
            'Jsi lepší než',
            style: TextStyle(fontSize: 14, height: 1.1),
          ),
          FutureBuilder<int?>(
            future: futureBetterThan ?? Future.value(null),
            builder: (context, snapshot) {
          
              if (snapshot.hasError || snapshot.data == null || snapshot.connectionState == ConnectionState.waiting) {
                return const Text(
                  '- %',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                );
              } else {
                final betterThan = snapshot.data; 

                AchievementManager().unlockBetterThanAchievements(betterThan ?? 0, context);

                return Text(
                  '$betterThan %',
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                );
              }
            },
          ),
          const Text(
            'hráčů',
            style: TextStyle(fontSize: 14, height: 1.1),
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
          padding: const EdgeInsets.only(left: 4.0, bottom: 6.0),
          child: 
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/graph.png',
                width: 28.0,
                height: 28.0,
              ),
              const SizedBox(width: 8.0),
              Text(
            'Přehled',
            style: const TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.w500,
            ),
          ),
            ],
          )
        ),

        GridView.builder(
          shrinkWrap: true, 
          physics:
              NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
            childAspectRatio: 1.5,
          ),
          itemCount: 4, 
          itemBuilder: (context, index) {
            return BorderContainer(padding: 16, children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _getCardContent(index)
                ),
              ]);
          },
        ),
      ],
    );
  }
}
