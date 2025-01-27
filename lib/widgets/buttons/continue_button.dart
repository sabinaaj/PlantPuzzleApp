import 'package:flutter/material.dart';
import '../../colors.dart';

class ContinueButton extends StatelessWidget {
  final String text;
  final double? width;
  final double height;
  final double vPadding;
  final VoidCallback? onPressed;
  

  const ContinueButton({
    super.key,
    this.text = 'Pokračovat',
    this.height = 50.0,
    this.width = double.infinity, // Default width
    this.vPadding = 14.0,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: vPadding),
        child: SizedBox(
          width: width,
          height: height,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 2.0,
              backgroundColor: AppColors.primaryGreen,
              shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
              ),
            ),
            onPressed: onPressed,
            child: Text(
              text,
              style: const TextStyle(fontSize: 16.0, color: Colors.white),
            ),
          ),
        ),
      )
    );
  }
}
