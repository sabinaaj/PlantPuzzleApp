import 'package:flutter/material.dart';

class ContinueButton extends StatelessWidget {
  final String text;
  final double? width;
  final double height;
  final VoidCallback? onPressed;

  const ContinueButton({
    super.key,
    this.text = 'Tlačítko', // Default text
    this.height = 50.0,
    this.width = double.infinity, // Default width
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center, // Center align the button
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14.0),
        child: SizedBox(
          width: width,
          height: height,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 2.0,
              backgroundColor: const Color(0xFF93C572),
              shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
              ),
            ),
            onPressed: onPressed,
            child: Text(
              text, // Use the provided text
              style: const TextStyle(fontSize: 16.0, color: Colors.white),
            ),
          ),
        ),
      )
    );
  }
}
