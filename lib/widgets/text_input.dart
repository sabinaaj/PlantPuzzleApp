import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  final String hintText;

  const TextInput({
    super.key,
    this.hintText = 'Text', // Default text
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController textController = TextEditingController();

    return SizedBox(
      child: TextField(
        controller: textController,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
              fontWeight: FontWeight.w500, color: Colors.grey.shade800),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade400, width: 2.0),
            borderRadius: BorderRadius.circular(12.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade300, width: 2.0),
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
      ),
    );
  }
}
