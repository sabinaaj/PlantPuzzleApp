import 'package:flutter/material.dart';
import '../../widgets/areas/area_header.dart';
import '../../widgets/worksheets/worksheet_list.dart';
import '../../models/area.dart';
import '../../colors.dart';

class AreaTabs extends StatelessWidget {
  final Area area;

  const AreaTabs({super.key, required this.area});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        top: true,
        child: Column(
          children: [
            AreaHeader(area: area),

            Container(
              child: TabBar(
                dividerHeight: 2.0,
                dividerColor: Colors.grey.shade400,
                indicatorColor: AppColors.secondaryGreen,
                labelStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                unselectedLabelStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
                tabs: [
                  Tab(text: "Pracovní listy"),
                  Tab(text: "Rostliny"),
                ],
              ),
            ),

            Expanded(
              child: TabBarView(
                children: [
                  WorksheetList(areaId: area.id),

                  const Center(child: Text("Obsah pro záložku Rostliny")),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
