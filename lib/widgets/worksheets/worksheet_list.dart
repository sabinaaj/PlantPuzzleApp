import 'package:flutter/material.dart';
import 'worksheet_card.dart';
import '../../services/data_service_worksheets.dart';
import '../../models/worksheet.dart';

class WorksheetList extends StatefulWidget {
  final int areaId;

  const WorksheetList({super.key, required this.areaId});

  @override
  State<WorksheetList> createState() => _WorksheetListState();
}

class _WorksheetListState extends State<WorksheetList> {
  final DataServiceWorksheets dataService = DataServiceWorksheets();
  late List<WorksheetSummary> worksheets;

  @override
  void initState() {
    super.initState();
    _loadWorksheets();
  }

  void _loadWorksheets() {
    setState(() {
      worksheets = dataService.getWorksheets(widget.areaId);
    });
  }

  @override
  void didUpdateWidget(covariant WorksheetList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.areaId != widget.areaId) {
      _loadWorksheets();
    }
  }

  @override
  Widget build(BuildContext context) {
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
      ),
    );
  }
}
