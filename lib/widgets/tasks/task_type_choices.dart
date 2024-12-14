import 'package:flutter/material.dart';
import '../../widgets/toggle_button.dart';
import '../../models/worksheet.dart';

class TaskTypeChoices extends StatefulWidget {
  final Question question;
  final String taskText;
  final List<TaskImage> images;

  const TaskTypeChoices({
    super.key,
    required this.question,
    required this.taskText,
    required this.images,
  });

  @override
  _TaskTypeChoicesState createState() => _TaskTypeChoicesState();
}

class _TaskTypeChoicesState extends State<TaskTypeChoices> {
  @override

  /// Returns a widget for the task 2, 3 and 4.
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.taskText,
          style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400),
        ),
        if (widget.images.isEmpty)
          Align(
            alignment: Alignment.center,
            child: Text(
              widget.question.text ?? '',
              style:
                  const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          )
        else
          Align(
            alignment: Alignment.center,
            child: Image.network(
              widget.images[0].image ?? '',
              fit: BoxFit.contain,
              width: double.infinity,
              height: 200,
            ),
          ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            if (widget.images.isNotEmpty && widget.question.text != null)
              Align(
                alignment: Alignment.center,
                child: Text(
                  '${widget.question.text ?? ''}.',
                  style: const TextStyle(
                      fontSize: 20.0, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            for (var option in widget.question.options)
              Padding(
                padding: const EdgeInsets.only(top: 14.0),
                child: ToggleButton(
                    option: option,
                    width: double.infinity),
              ),
          ],
        ),
      ],
    );
  }
}
