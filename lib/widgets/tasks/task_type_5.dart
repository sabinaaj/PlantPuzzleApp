import 'package:flutter/material.dart';
import '../../widgets/task_5_button.dart';
import '../../models/worksheet.dart';
import '../../utilities/worksheet.dart';

class TaskType5 extends StatefulWidget {
  final Task task;
  final List<String> questions;
  final Task5StateManager task5StateManager = Task5StateManager();

  TaskType5({
    super.key,
    required this.task,
  }) : questions = task.questions.map((question) => question.text ?? '').toList();

  @override
  State<TaskType5> createState() => _TaskType5State();
}

class _TaskType5State extends State<TaskType5> {
  int? selectedQuestionIndex;
  int? selectedOptionIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Nadpis nebo text úkolu
        Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Text(
            widget.task.text,
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
                      for (var i = 0; i < widget.questions.length; i++) ...[
                        Expanded(
                          child: Task5Button(
                            text: widget.questions[i],
                            onPressed: () {
                              if (selectedQuestionIndex == null) {
                                setState(() {
                                  print('selectedQuestionIndex: $selectedQuestionIndex');
                                  selectedQuestionIndex = i;
                                });
                              } else if (selectedQuestionIndex == i) {
                                setState(() {
                                  print('selectedQuestionIndex: $selectedQuestionIndex');
                                  selectedQuestionIndex = null;
                                });
                              }
                              print('selectedQuestionIndex: $selectedQuestionIndex');
                            },
                            canBeSelected: () => selectedQuestionIndex == null || selectedQuestionIndex == i,
                          ),
                        ),
                        if (i < widget.questions.length - 1)
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
                      for (var i = 0; i < widget.task.questions[0].options.length; i++) ...[
                        Expanded(
                          child: Task5Button(
                            text: widget.task.questions[0].options[i].text ?? '',
                            onPressed: () {
                              if (selectedOptionIndex == null) {
                                setState(() {
                                  selectedOptionIndex = selectedOptionIndex == i ? null : i;
                                });
                              } else if (selectedOptionIndex == i) {
                                setState(() {
                                  selectedOptionIndex = null;
                                });
                              }
                            },
                            canBeSelected: () => selectedOptionIndex == null || selectedOptionIndex == i,
                          ),
                        ),
                        if (i < widget.task.questions[0].options.length - 1)
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
