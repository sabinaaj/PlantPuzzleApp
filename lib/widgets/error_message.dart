import 'package:flutter/material.dart';

class ErrorMessage extends StatelessWidget {
  final String message;
  final bool visibility;

  const ErrorMessage({
    required this.message,
    required this.visibility,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Visibility(
        maintainSize: true,
        maintainAnimation: true,
        maintainState: true,
        visible: visibility,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 20.0,
            ),
            const SizedBox(width: 5.0),
            Text(
              message,
              style: const TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
