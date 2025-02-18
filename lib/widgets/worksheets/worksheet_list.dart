import 'package:flutter/material.dart';
import 'worksheet_card.dart';
import '../../services/data_service_worksheets.dart';

class WorksheetList extends StatelessWidget {
  final DataServiceWorksheets dataService = DataServiceWorksheets();
  final int areaId;

  WorksheetList({super.key, required this.areaId});

  @override
  Widget build(BuildContext context) {
    final worksheets = dataService.getWorksheets(areaId);

    return Container(
        color: Colors.grey.shade100,
        child: ListView.builder(
          itemCount: worksheets.length + 1,
          itemBuilder: (context, index) {
            if (index < worksheets.length) {
              final worksheet = worksheets[index];
              return WorksheetCard(worksheet: worksheet);
            } else {
              return const SizedBox(height: 8);
            }
          },
        ));
  }
}
