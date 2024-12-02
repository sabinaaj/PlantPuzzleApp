import 'package:flutter/material.dart';
import '../../widgets/border_button.dart';
import '../../models/worksheet.dart';

class TaskType5 extends StatelessWidget {
  final Task task;
  final List<String> questions;

  TaskType5({
    super.key,
    required this.task,
  }) : questions = task.questions.map((question) => question.text ?? '').toList();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Nadpis nebo text úkolu
        Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Text(
            task.text,
            style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400),
          ),
        ),
        // Tlačítka zaberou celou výšku stránky
        Expanded(
          child: Row(
            children: [
              // První sloupec
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Column(
                    children: [
                      for (var i = 0; i < questions.length; i++) ...[
                        Expanded(
                          child: BorderButton(
                            text: questions[i],
                            width: double.infinity,
                            height: double.infinity, 
                          ),
                        ),
                        if (i < questions.length - 1)
                          const SizedBox(height: 14), 
                      ],
                    ],
                  ),
                ),
              ),
              // Druhý sloupec
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Column(
                    children: [
                      for (var i = 0; i < task.questions[0].options.length; i++) ...[
                        Expanded(
                          child: BorderButton(
                            text: task.questions[0].options[i].text ?? '',
                            width: double.infinity,
                            height: double.infinity, 
                          ),
                        ),
                        if (i < task.questions[0].options.length - 1)
                          const SizedBox(height: 14), 
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
