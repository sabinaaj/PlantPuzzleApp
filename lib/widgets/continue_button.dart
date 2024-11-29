import 'package:flutter/material.dart';

class ContinueButton extends StatelessWidget {
  final String text;
  final double? width;
  final double height;

  const ContinueButton({
    Key? key,
    this.text = 'Tlačítko', // Default text
    this.height = 50.0,
    this.width = double.infinity, // Default width
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center, // Center align the button
      child: SizedBox(
        width: width,
        height: height,
        child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: Color(0xFF93C572),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
          onPressed: () {
            // Add your onPressed functionality here
          },
          child: Text(
            text, // Use the provided text
            style: const TextStyle(fontSize: 16.0, color: Colors.white),
          ),
        ),
      ),
    );
  }

}