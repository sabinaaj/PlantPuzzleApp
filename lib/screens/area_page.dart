import 'package:flutter/material.dart';
import '../widgets/navigation_app_bar.dart';
import '../widgets/areas/area_page_tabs.dart';
import '../models/area.dart';

class AreaPage extends StatelessWidget {
  final Area area;

  const AreaPage({super.key, required this.area});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavigationAppBar(
        backgroundColor: Colors.white,
      ),
      body: AreaTabs(area: area));
  }
}
