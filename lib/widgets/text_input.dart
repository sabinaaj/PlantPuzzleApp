import 'package:flutter/material.dart';

class TextInput extends StatefulWidget {
  final TextEditingController textController;
  final String hintText;
  final Icon? icon;

  const TextInput({
    super.key,
    required this.textController,
    required this.hintText,
    this.icon,
  });

  @override
  State<TextInput> createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }
  
  @override
  Widget build(BuildContext context) {
    Color borderColor = _isFocused
              ? Colors.grey.shade400 
              : Colors.grey.shade300;

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: 400,
      ),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(width: 2.0, color: borderColor),
            left: BorderSide(width: 2.0, color: borderColor),
            right: BorderSide(width: 2.0, color: borderColor),
            bottom: BorderSide(width: 4.0, color: borderColor)
          ),
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: TextField(
          controller: widget.textController,
          maxLength: 50,
          focusNode: _focusNode,
          decoration: InputDecoration(
            counterText: '',
            prefixIcon: widget.icon,
            hintText: widget.hintText,
            hintStyle: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.grey.shade800,
            ),
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            contentPadding: EdgeInsets.all(16.0),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }
}
