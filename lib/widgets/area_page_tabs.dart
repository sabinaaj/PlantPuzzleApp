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
      length: 2, // Počet záložek
      child: SafeArea(
        top: true,
        child: Column(
          
          children: [
            AreaHeader(area: area),
            // TabBar (záložky)
            const TabBar(
              dividerHeight: 2.0,
              dividerColor: Color.fromARGB(255, 224, 224, 224),
              indicatorColor: Color.fromARGB(255, 169, 169, 169),
              labelStyle: TextStyle(
                fontSize: 16, // Velikost textu nastavena na 16
                fontWeight: FontWeight.bold,
              ),
              unselectedLabelStyle: TextStyle(
                fontSize: 16, // Velikost textu i pro nezvolené záložky
                fontWeight: FontWeight.normal,
              ),
              tabs: [
                Tab(text: "Pracovní listy"),
                Tab(text: "Rostliny"),
              ],
            ),
            // Obsah stránky podle vybrané záložky
            Expanded(
              child: TabBarView(
                children: [
                  // Obsah první záložky
                  WorksheetList(areaId: area.id),
                  // Obsah druhé záložky
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
