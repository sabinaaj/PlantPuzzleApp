import 'package:flutter/material.dart';
import 'dart:io';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../models/area.dart';
import '../../colors.dart';

class PlantCard extends StatefulWidget {
  final Plant plant;

  const PlantCard({super.key, required this.plant});

  @override
  State<PlantCard> createState() => _PlantCardState();
}

class _PlantCardState extends State<PlantCard> {
  final PageController pageController = PageController();
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final plant = widget.plant;

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
            if (plant.description != null && plant.description!.isNotEmpty)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  plant.description!,
                  maxLines: isExpanded ? null : 3,
                  overflow: isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 14.0, color: Colors.black87),
                ),
                const SizedBox(height: 4.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton.icon(
                      style: TextButton.styleFrom(
                        minimumSize: const Size(50, 30),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        visualDensity: VisualDensity.compact,
                      ),
                      onPressed: () {
                        setState(() {
                          isExpanded = !isExpanded;
                        });
                      },
                      icon: Icon(
                        isExpanded ? Icons.expand_less : Icons.expand_more,
                        size: 18,
                        color: AppColors.secondaryGreen,
                      ),
                      label: Text(
                        isExpanded ? 'Méně' : 'Více',
                        style: const TextStyle(fontSize: 14.0, color: AppColors.secondaryGreen),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            if (plant.images.isNotEmpty)
              Column(
                children: [
                  SizedBox(
                    height: 150,
                    child: PageView.builder(
                      controller: pageController,
                      itemCount: plant.images.length,
                      itemBuilder: (context, index) {
                        return Center(
                          child: Image.file(
                            File(plant.images[index].image),
                            height: 150,
                            fit: BoxFit.contain,
                          ),
                        );
                      },
                    ),
                  ),
                  if (plant.images.length > 1)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: SmoothPageIndicator(
                        controller: pageController,
                        count: plant.images.length,
                        effect: ExpandingDotsEffect(
                          dotHeight: 8,
                          dotWidth: 8,
                          activeDotColor: Colors.grey.shade400,
                          dotColor: Colors.grey.shade400,
                        ),
                      ),
                    ),
                ],
              )
            else
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Text(
                    "K této rostlině chybí obrázek.",
                    style: TextStyle(fontSize: 16.0, color: Colors.grey),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
