import 'package:flutter/material.dart';
import '../../widgets/border_button.dart';
import '../../models/worksheet.dart';

class TaskType5 extends StatelessWidget {
  final Task task;
  final List<String> questions;

  TaskType5({
    super.key,
    required this.task,
  })  : questions = task.questions.map((question) => question.text ?? '').toList();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          task.text,
          style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400),
        ),
        Expanded(
          child: Row(
            children: [
              // First column
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Column(
                    mainAxisAlignment:
                        MainAxisAlignment.start, // Align to the top
                    children: questions.map(
                      (question) {
                        return Flexible(
                        fit: FlexFit.tight,
                        child: BorderButton(
                          text: question,
                          width: double.infinity,
                          height: 100,
                        ),
                      );
                      }
                    ).toList()
                    
                  ),
                ),
              ),
              // Second column
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Column(
                    mainAxisAlignment:
                        MainAxisAlignment.start, 
                    children: task.questions[0].options.map(
                      (option) {
                        return Flexible(
                        fit: FlexFit.tight,
                        child: BorderButton(
                          text: option.text ?? '',
                          width: double.infinity,
                          height: 100,
                        ),
                      );
                      }
                    ).toList()
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(),
      ],
    );
  }
}
