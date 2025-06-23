import 'package:flutter/material.dart';
import '../widgets/areas/area_list.dart';
import '../widgets/navigation_app_bar.dart';
import '../services/data_service.dart';
import '../utilities/achievements_manager.dart';

class AreaListPage extends StatefulWidget {
  const AreaListPage({super.key});

  @override
  State<AreaListPage> createState() => _AreaListPageState();
}

class _AreaListPageState extends State<AreaListPage> {
  final DataService dataService = DataService();
  late UniqueKey _areaListKey;

  @override
  void initState() {
    super.initState();
    _areaListKey = UniqueKey();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      AchievementManager().unlockAchievement('first_login', context);
    });
  }

  Future<void> _handleRefresh() async {
    final result = await dataService.fetchAndCacheData();

    setState(() {
      _areaListKey = UniqueKey(); // Force rebuild
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(result
            ? "Data úspěšně aktualizována."
            : "Není dostupné připojení k internetu. Aktualizace se nezdařila."),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavigationAppBar(
        leadingWidth: 130.0,
        leading: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Image.asset('assets/images/plant.png', height: 30),
            ),
            const Text(
              'Oblasti',
              style: TextStyle(fontSize: 22.0),
            ),
          ],
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child: Divider(
            height: 2.0,
            color: Colors.grey.shade300,
            thickness: 2.0,
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _handleRefresh,
        child: AreaList(key: _areaListKey),
      ),
    );
  }
}
