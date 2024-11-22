import 'package:flutter/material.dart';
import '../models/area.dart';

class AreaHeader extends StatelessWidget {
  final Area area;

  const AreaHeader({super.key, required this.area});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
          child: area.iconUrl != null
              ? Image.network(
                  area.iconUrl!,
                  height: 115,
                  fit: BoxFit.cover,
                )
              : const Icon(Icons.image_not_supported),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 15.0),
          child: SizedBox(
            width: 200.0,
            child: Center(
              child: Text(
                area.title,
                maxLines: 4,
                style: const TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
