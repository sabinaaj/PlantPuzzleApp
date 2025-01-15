import 'package:flutter/material.dart';
import 'package:plant_puzzle_app/widgets/area_header.dart';
import 'package:plant_puzzle_app/widgets/worksheet_list.dart';
import '../models/area.dart';

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
              color: Colors.grey.shade300, 
              child: TabBar(
                dividerHeight: 2.0,
                dividerColor: Colors.grey.shade500,
                indicatorColor: Colors.grey.shade500,
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
