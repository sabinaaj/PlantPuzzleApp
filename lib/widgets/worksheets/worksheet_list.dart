import 'package:flutter/material.dart';
import '../../widgets/worksheets/worksheet_card.dart';
import '../../services/api_service_worksheets.dart';
import '../../screens/worksheet_page.dart';
import '../../models/worksheet.dart';

class WorksheetList extends StatefulWidget {
  final int areaId;

  const WorksheetList({super.key, required this.areaId});

  @override
  State<WorksheetList> createState() => _WorksheetListState();
}

class _WorksheetListState extends State<WorksheetList> {
  final ApiService _apiService = ApiService();
  late Future<List<WorksheetSummary>> _worksheetsFuture;

  @override
  void initState() {
    super.initState();
    _worksheetsFuture = _loadWorksheets();
  }

  Future<List<WorksheetSummary>> _loadWorksheets() async {
    final data = await _apiService.getWorksheetsByArea(widget.areaId);
    return data.map<WorksheetSummary>((json) => WorksheetSummary.fromJson(json)).toList();
  }

  void reloadData() {
    setState(() {
      _worksheetsFuture = _loadWorksheets();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<WorksheetSummary>>(
      future: _worksheetsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Žádné pracovní listy nenalezeny.'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('Žádné pracovní listy nenalezeny.'));
        }

        final worksheets = snapshot.data!;
        return Container(
          color: Colors.grey.shade100,
          child: ListView.builder(
          itemCount: worksheets.length + 1, 
          itemBuilder: (context, index) {
            if (index < worksheets.length) {
              final worksheet = worksheets[index];
              return WorksheetCard(
                worksheet: worksheet,
                onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WorksheetPage(worksheetId: worksheet.id),
                      ),
                    ).then((value) => reloadData()),
                    );
            } else {
              return const SizedBox(height: 8);
            }
          },
        )
        ) ;
        
      },
    );
  }
}