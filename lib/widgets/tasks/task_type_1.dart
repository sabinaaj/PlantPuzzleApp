import 'package:flutter/material.dart';
import '../../models/worksheet.dart';
import '../buttons/toggle_button.dart';

class TaskType1 extends StatefulWidget {
  final Question question;
  final String taskText;

  const TaskType1({
    super.key,
    required this.question,
    required this.taskText,
  });

  @override
  State<TaskType1> createState() => _TaskType1State();
}

class _TaskType1State extends State<TaskType1> {
  final GlobalKey _option1Key = GlobalKey();
  final GlobalKey _option2Key = GlobalKey();

  double _maxWidth = 0;

  @override
  void initState() {
    super.initState();
    _maxWidth = _calculateMaxTextWidth(
        widget.question.options.map((opt) => opt.text ?? '').toList());
  }

  double _calculateMaxTextWidth(List<String> optionTexts) {
    final textStyle = const TextStyle(fontSize: 16);
    var maxWidth = 0.0;

    for (final optionText in optionTexts) {
      final textPainter = TextPainter(
        text: TextSpan(text: optionText, style: textStyle),
        textDirection: TextDirection.ltr,
      )..layout();
      maxWidth = maxWidth > textPainter.width ? maxWidth : textPainter.width;
    }

    return maxWidth + 40; // Add padding
  }

  @override
  Widget build(BuildContext context) {

    final taskTextStyle = const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400);
    final questionTextStyle = const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold);

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.taskText, style: taskTextStyle),
        Column(
          children: [
            Text(widget.question.text ?? '',
                style: questionTextStyle, textAlign: TextAlign.center),
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ToggleButton(
                  key: _option1Key,
                  option: widget.question.options[0],
                  width: _maxWidth,
                ),
                ToggleButton(
                  key: _option2Key,
                  option: widget.question.options[1],
                  width: _maxWidth,
                ),
              ],
            ),
            const SizedBox(height: 100),
          ],
        ),
        const SizedBox(),
      ],
    );
  }
}
