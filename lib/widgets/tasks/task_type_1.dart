import 'package:flutter/material.dart';
import 'package:plant_puzzle_app/models/worksheet.dart';
import '../../widgets/border_button.dart';

class TaskType1 extends StatefulWidget {
  final Question question;
  final String taskText;
  final Function(Option) onOptionSelected;

  const TaskType1(
      {super.key,
       required this.question,
       required this.taskText,
       required this.onOptionSelected
      });

  @override
  State<TaskType1> createState() => _TaskType1State();
}

class _TaskType1State extends State<TaskType1> {
  final GlobalKey _button1Key = GlobalKey();
  final GlobalKey _button2Key = GlobalKey();

  double _maxWidth = 0;

  @override
  void initState() {
    super.initState();
    _maxWidth = _calculateMaxTextWidth(
        widget.question.options.map((opt) => opt.text ?? '').toList());
  }

  double _calculateMaxTextWidth(List<String> texts) {
    const textStyle = TextStyle(fontSize: 16.0);
    double maxWidth = 0;

    for (final text in texts) {
      final textPainter = TextPainter(
        text: TextSpan(text: text, style: textStyle),
        textDirection: TextDirection.ltr,
      )..layout();
      maxWidth = maxWidth > textPainter.width ? maxWidth : textPainter.width;
    }

    return maxWidth + 40.0; // Add padding
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.taskText,
          style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400),
        ),
        Column(
          children: [
            Text(
              widget.question.text ?? '',
              style:
                  const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                BorderButton(
                  key: _button1Key,
                  text: widget.question.options[0].text ?? '',
                  height: 50,
                  width: _maxWidth,
                  onPressed: () => widget.onOptionSelected(widget.question.options[0]),
                ),
                BorderButton(
                  key: _button2Key,
                  text: widget.question.options[1].text ?? '',
                  height: 50,
                  width: _maxWidth,
                  onPressed: () => widget.onOptionSelected(widget.question.options[1]),
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
