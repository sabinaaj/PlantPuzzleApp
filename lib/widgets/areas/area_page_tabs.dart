import 'package:flutter/material.dart';
import 'package:plant_puzzle_app/widgets/plants/plant_list.dart';
import '../../widgets/areas/area_header.dart';
import '../../widgets/worksheets/worksheet_list.dart';
import '../../models/area.dart';
import '../../colors.dart';
import '../../services/data_service.dart';

class AreaTabs extends StatefulWidget {
  final Area area;

  const AreaTabs({super.key, required this.area});

  @override
  State<AreaTabs> createState() => _AreaTabsState();
}

class _AreaTabsState extends State<AreaTabs> {
  final DataService dataService = DataService();
  Key worksheetKey = UniqueKey();
  Key plantKey = UniqueKey();

  Future<void> _refreshData() async {
    final result = await dataService.fetchAndCacheData();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          result
              ? "Data úspěšně aktualizována."
              : "Není dostupné připojení k internetu. Aktualizace se nezdařila.",
        ),
      ),
    );

    // Vynutíme rebuildování potomků
    setState(() {
      worksheetKey = UniqueKey();
      plantKey = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        top: true,
        child: Column(
          children: [
            AreaHeader(area: widget.area),
            TabBar(
              dividerHeight: 2.0,
              dividerColor: Colors.grey.shade400,
              indicatorColor: AppColors.secondaryGreen,
              labelStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              unselectedLabelStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
              tabs: const [
                Tab(text: "Pracovní listy"),
                Tab(text: "Rostliny"),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  RefreshIndicator(
                    onRefresh: _refreshData,
                    child: WorksheetList(
                      key: worksheetKey,
                      areaId: widget.area.id,
                    ),
                  ),
                  RefreshIndicator(
                    onRefresh: _refreshData,
                    child: PlantList(
                      key: plantKey,
                      areaId: widget.area.id,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
