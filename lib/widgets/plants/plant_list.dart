import 'package:flutter/material.dart';
import 'plant_card.dart';
import '../../services/data_service_areas.dart';

class PlantList extends StatelessWidget {
  final DataServiceAreas dataService = DataServiceAreas();
  final int areaId;

  PlantList({super.key, required this.areaId});

  @override
  Widget build(BuildContext context) {
    final plants = dataService.getPlants(areaId);

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