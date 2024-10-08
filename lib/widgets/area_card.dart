import 'package:flutter/material.dart';
import '../models/area.dart';
import '../widgets/border_button.dart';

class AreaCard extends StatelessWidget {
  final Area area;

  const AreaCard({super.key, required this.area});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        decoration: BoxDecoration(
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
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: const EdgeInsets.only(
                        right: 20.0, left: 10.0),
                    child: const Icon(Icons.favorite,
                        size: 85.0),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                          width: 200.0,
                          child: Text(
                          area.title,
                          maxLines: 4,
                          style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),

                      const SizedBox(height: 4.0),
                      const Text(
                        'Další info',
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),


                      const SizedBox(height: 4.0),
                      const Text(
                        'Nevim, co ještě',
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              BorderButton(
                text: 'Spustit test',
                width: MediaQuery.of(context).size.width * 0.75,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
