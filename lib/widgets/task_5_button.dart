import 'package:flutter/material.dart';

class Task5Button extends StatelessWidget {
  final String? text;
  final VoidCallback? onPressed;
  final bool isSelected;
  final bool isVisible;

  const Task5Button({
    super.key,
    this.text,
    this.onPressed,
    required this.isSelected,
    required this.isVisible
  });

  @override
  Widget build(BuildContext context) {
    // Styling tlačítka podle stavu
    final backgroundColor = isSelected ? Colors.grey.shade300 : Colors.white;
    final textColor = Colors.black;
    final borderColor = isSelected ? Colors.grey.shade400 : Colors.grey.shade300;

    return Visibility(
      maintainSize: true, 
      maintainAnimation: true,
      maintainState: true,
      visible: isVisible, 
      child: Align(
        alignment: Alignment.center,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            border: Border(
              top: BorderSide(width: 2.0, color: borderColor),
              left: BorderSide(width: 2.0, color: borderColor),
              right: BorderSide(width: 2.0, color: borderColor),
              bottom: BorderSide(width: 4.0, color: borderColor),
            ),
            color: backgroundColor,
          ),
          child: TextButton(
            style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            onPressed: onPressed, // Předává akci na rodiče
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Text(
                text ?? '',
                style: TextStyle(fontSize: 16.0, color: textColor),
                overflow: TextOverflow.visible,
              ),
            ),
          ),
        ),
      )
    );
  }
}