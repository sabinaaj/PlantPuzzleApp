import 'package:flutter/material.dart';
import '../../widgets/border_button.dart';
import '../../widgets/continue_button.dart';
import '../../models/worksheet.dart';

class TaskType2 extends StatelessWidget {
  final Question question;
  final String taskText;

  const TaskType2({super.key, required this.question, required this.taskText});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          taskText,
          style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400),
        ),
        // Question text
        Align(
          alignment: Alignment.center,
          child: Text(
            question.text ?? '',
            style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),

        // Options
        Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: question.options.map((option) {
              return Padding(
                padding: const EdgeInsets.only(top: 14.0),
                child: BorderButton(
                    text: option.text ?? '',
                    height: 50,
                    width: double.infinity),
              );
            }).toList()),

        const SizedBox(),
      ],
    );
  }
}
