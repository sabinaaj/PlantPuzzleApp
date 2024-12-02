import 'package:flutter/material.dart';
import '../../widgets/border_button.dart';
import '../../models/worksheet.dart';

class TaskTypeChoices extends StatelessWidget {
  final Question question;
  final String taskText;
  final List<TaskImage> images;

  const TaskTypeChoices({super.key, required this.question, required this.taskText, required this.images});

  @override
  Widget build(BuildContext context) {
    if (images.isNotEmpty) {
      print(images[0].image);
    }
    
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          taskText,
          style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400),
        ),
        // Question text

      if (images.isEmpty)
        Align(
          alignment: Alignment.center,
          child: Text(
            question.text ?? '',
            style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        )
      else
        Align(
          alignment: Alignment.center,
          child: Image.network(
            images[0].image ?? '',
            fit: BoxFit.contain,
            width: double.infinity,
            height: 200,
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
