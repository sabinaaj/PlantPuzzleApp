import 'package:flutter/material.dart';
import '../widgets/navigation_app_bar.dart';
import '../widgets/areas/area_page_tabs.dart';
import '../models/area.dart';
import '../services/api_service_areas.dart';

class AreaPage extends StatefulWidget {
  final Area area;

  const AreaPage({super.key, required this.area});

  @override
  State<AreaPage> createState() => _AreaPageState();
}

class _AreaPageState extends State<AreaPage> {
  late Future<Map<String, dynamic>> _areaDetailsFuture;
  final ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _areaDetailsFuture = _apiService.getAreaDetails(widget.area.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavigationAppBar(
        backgroundColor: Colors.grey.shade300,
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _areaDetailsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Vyskytla se chyba.'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('Něco se nepovedlo. Zkuste to znovu.'));
          }

          return AreaTabs(area: widget.area);
        },
      ),
    );
  }
}
