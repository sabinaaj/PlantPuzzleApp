import 'package:flutter/material.dart';
import 'plant_card.dart';
import '../../services/data_service_areas.dart';
import '../../models/area.dart';

class PlantList extends StatefulWidget {
  final int areaId;

  const PlantList({super.key, required this.areaId});

  @override
  State<PlantList> createState() => _PlantListState();
}

class _PlantListState extends State<PlantList> {
  final DataServiceAreas dataService = DataServiceAreas();
  late List<Plant> plants;

  @override
  void initState() {
    super.initState();
    _loadPlants();
  }

  void _loadPlants() {
    setState(() {
      plants = dataService.getPlants(widget.areaId);
    });
  }

  @override
  void didUpdateWidget(covariant PlantList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.areaId != widget.areaId) {
      _loadPlants();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade100,
      child: ListView.builder(
        itemCount: plants.length + 1,
        itemBuilder: (context, index) {
          if (index < plants.length) {
            final plant = plants[index];
            return PlantCard(plant: plant);
          } else {
            return const SizedBox(height: 8);
          }
        },
      ),
    );
  }
}
