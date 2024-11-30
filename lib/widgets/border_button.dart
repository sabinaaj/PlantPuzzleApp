import 'package:flutter/material.dart';

class BorderButton extends StatelessWidget {
  final String text;
  final double? width; 
  final double? height;
  final VoidCallback? onPressed;

  const BorderButton({
    super.key,
    this.text = 'Tlačítko', // Default text
    this.height = 45.0,
    this.width, // Default width
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          border: Border(
            top: BorderSide(width: 2.0, color: Colors.grey.shade300),
            left: BorderSide(width: 2.0, color: Colors.grey.shade300),
            right: BorderSide(width: 2.0, color: Colors.grey.shade300),
            bottom: BorderSide(width: 4.0, color: Colors.grey.shade300), // Thicker bottom border
          ),
        ),
        child: TextButton(
          style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          onPressed: onPressed,
          child: Text(
            text, // Use the provided text
            style: const TextStyle(fontSize: 16.0),
          ),
        ),
      ),
    );
  }
}
