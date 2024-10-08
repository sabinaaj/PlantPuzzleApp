import 'package:flutter/material.dart';
import '../services/api_service.dart'; // Import API služby
import '../models/area.dart';
import '../widgets/border_button.dart';

class AreaCard extends StatefulWidget {
  const AreaCard({super.key});

  @override
  _AreaCardState createState() => _AreaCardState();
}

class _AreaCardState extends State<AreaCard> {
  final ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
              const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        right: 20.0, left: 10.0), // Add padding around the icon
                    child: const Icon(Icons.favorite,
                        size: 85.0), // Icon with adjusted size
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Název oblasti',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        'Odemčeno',
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        'Úspěšnost: 75%',
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
