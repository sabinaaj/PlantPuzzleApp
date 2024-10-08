import 'package:flutter/material.dart';
import '../services/api_service.dart';  // Import API služby
import '../models/area.dart';          // Import modelu Area

class ItemList extends StatefulWidget {
  const ItemList({super.key});

  @override
  _ItemListState createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  final ApiService _apiService = ApiService();
  late Future<List<dynamic>> _areasFuture;

  @override
  void initState() {
    super.initState();
    _areasFuture = _apiService.getAreas();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,  
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
                margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0),
                  border: Border(
                    top: BorderSide(width: 2.0, color: Colors.grey.shade300),
                    left: BorderSide(width: 2.0, color: Colors.grey.shade300),
                    right: BorderSide(width: 2.0, color: Colors.grey.shade300),
                    bottom: BorderSide(width: 4.0, color: Colors.grey.shade300)),
                  ),
                child: ListTile(
                  title: Text(area.title),
                  onTap: () {
                    // Zde můžete přidat akci pro kliknutí na jednotlivé oblasti
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
