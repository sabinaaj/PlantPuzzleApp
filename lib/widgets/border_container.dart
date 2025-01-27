import 'package:flutter/material.dart';

class BorderContainer extends StatelessWidget {
  final List<Widget> children;
  final double padding;

  const BorderContainer({
    super.key,
    required this.children,
    this.padding = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: 400,
      ),
      child: Container(
        padding: EdgeInsets.all(padding),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          border: Border(
            top: BorderSide(width: 2.0, color: Colors.grey.shade300),
            left: BorderSide(width: 2.0, color: Colors.grey.shade300),
            right: BorderSide(width: 2.0, color: Colors.grey.shade300),
            bottom: BorderSide(width: 5.0, color: Colors.grey.shade300), // Thicker bottom border
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...children,
          ],
        ),
      ),
    );
  }
}
