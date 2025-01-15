import 'package:flutter/material.dart';
import '../widgets/area_list.dart';
import '../widgets/navigation_app_bar.dart';

class AreaListPage extends StatelessWidget {
  const AreaListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavigationAppBar(),
      body: const AreaList(),
    );
  }
}
