import 'package:flutter/material.dart';

class ToggleButton extends StatefulWidget {
  final String text;
  final double? width;
  final double? height;
  final Function(bool)? onToggle;

  const ToggleButton({
    super.key,
    this.text = 'Tlačítko',
    this.height = 45.0,
    this.width,
    this.onToggle,
  });

  @override
  State<ToggleButton> createState() => _ToggleButtonState();
}

class _ToggleButtonState extends State<ToggleButton> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          border: Border(
            top: BorderSide(width: 2.0, color: Colors.grey.shade300),
            left: BorderSide(width: 2.0, color: Colors.grey.shade300),
            right: BorderSide(width: 2.0, color: Colors.grey.shade300),
            bottom: BorderSide(width: 4.0, color: Colors.grey.shade300), // Thicker bottom border
          ),
          color: _isSelected ? Colors.grey.shade300 : null,
        ),
        child: TextButton(
          style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          onPressed: () {
            setState(() {
              _isSelected = !_isSelected;
            });
          },
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Text(
              widget.text,
              style: const TextStyle(fontSize: 16.0),
              overflow: TextOverflow.visible, 
            ),
          ),
        ),
      ),
    );
  }
}