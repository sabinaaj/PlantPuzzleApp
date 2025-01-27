import 'package:flutter/material.dart';
import '../../services/api_service_areas.dart';  
import '../../models/area.dart';       
import "../../screens/area_page.dart";   

class AreaList extends StatefulWidget {
  const AreaList({super.key});

  @override
  State<AreaList> createState() => _AreaListState();
}

class _AreaListState extends State<AreaList> {
  final ApiService _apiService = ApiService();
  late Future<List<dynamic>> _areasFuture;

  @override
  void initState() {
    super.initState();
    _areasFuture = _apiService.getAreas();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: FutureBuilder<List<dynamic>>(
        future: _areasFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Chyba: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Žádné oblasti nenalezeny'));
          }

          List<Area> areas = snapshot.data!.map((area) => Area.fromJson(area)).toList();

          return ListView.builder(
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
                    bottom: BorderSide(width: 4.0, color: Colors.grey.shade300)),
                  ),
                child:  ListTile(
                  
                  leading: area.iconUrl != null
                    ? Image.network(
                        area.iconUrl!,
                        height: 75,
                        width: 60,
                      )
                    : Image.asset(
                      'assets/images/area_placeholder.png',
                      height: 75,
                      width: 60,
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
          );
        },
      ),
    );
  }
}
