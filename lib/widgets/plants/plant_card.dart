import 'package:flutter/material.dart';
import 'dart:io';
import '../buttons/border_button.dart';
import '../../models/area.dart';
import '../../colors.dart';


class PlantCard extends StatelessWidget {
  final Plant plant;

  const PlantCard({super.key, required this.plant});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
        border: Border.all(
          color: Colors.grey.shade300,
          width: 2.0,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              plant.name,
              maxLines: 2,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 8.0),
            if (plant.images.isNotEmpty)
              SizedBox(
                height: 150,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: plant.images.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Image.file(
                        File(plant.images[index].image),
                        width: 150,
                        height: 150,
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                ),
              ),
            const SizedBox(height: 8.0),
            BorderButton(
              text: 'Zobrazit detaily',
              width: MediaQuery.of(context).size.width * 0.85,
              backgroundColor: AppColors.primaryGreen,
              borderColor: AppColors.secondaryGreen,
              onPressed: () => {}
            )
          ],
        ),
      ),
    );
  }
}