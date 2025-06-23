import 'package:flutter/material.dart';
import 'dart:io';
import '../../services/data_service_areas.dart';
import '../../models/area.dart';
import "../../screens/area_page.dart";

class AreaList extends StatefulWidget {
  const AreaList({super.key});

  @override
  State<AreaList> createState() => _AreaListState();
}

class _AreaListState extends State<AreaList> {
  final DataServiceAreas dataService = DataServiceAreas();
  late List<Area> areas;

  @override
  void initState() {
    super.initState();
    _loadAreas();
  }

  void _loadAreas() {
    setState(() {
      areas = dataService.getAreas();
    });
  }

  @override
  void didUpdateWidget(covariant AreaList oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Pokud došlo k rebuildu (např. klíč se změnil), znovu načti data
    _loadAreas();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: ListView.builder(
        itemCount: areas.length,
        itemBuilder: (context, index) {
          final area = areas[index];
          return Container(
            padding: const EdgeInsets.symmetric(vertical: 14.0),
            margin: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 16.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              border: Border(
                top: BorderSide(width: 2.0, color: Colors.grey.shade300),
                left: BorderSide(width: 2.0, color: Colors.grey.shade300),
                right: BorderSide(width: 2.0, color: Colors.grey.shade300),
                bottom: BorderSide(width: 4.0, color: Colors.grey.shade300),
              ),
            ),
            child: ListTile(
              leading: SizedBox(
                height: 75,
                width: 60,
                child: area.iconUrl != null
                  ? Image.file(
                      File(area.iconUrl!),
                      height: 75,
                      width: 60,
                    )
                  : Image.asset(
                      'assets/images/area_placeholder.png',
                      height: 75,
                      width: 60,
                    ),
              ), 
              title: Text(area.title),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AreaPage(area: area),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
