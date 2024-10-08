import 'package:flutter/material.dart';
import '../widgets/area_card.dart';


class AreaPage extends StatelessWidget {
  const AreaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Oblast'),
        centerTitle: true,
      ),
      body: AreaCard(),  // Načítá dynamický seznam z widgetu
    );
  }
}