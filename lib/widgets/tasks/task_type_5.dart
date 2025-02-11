import 'package:flutter/material.dart';
import '../buttons/task_5_button.dart';
import '../../models/worksheet.dart';
import '../../utilities/worksheet_state_manager.dart';

class TaskType5 extends StatefulWidget{
  final Task task;
  final List<String> questions;
  final WorksheetStateManager worksheetStateManager;

  TaskType5({
    super.key,
    required this.task,
    required this.worksheetStateManager,
  }) : questions =
            task.questions.map((question) => question.text ?? '').toList();

  @override
  State<TaskType5> createState() => _TaskType5State();
}

class _TaskType5State extends State<TaskType5> {
  late final StateManager stateManager;
  int? selectedQuestionIndex;
  int? selectedOptionIndex;

  List<bool> questionVisibility = [];
  List<bool> optionVisibility = [];

  bool isCorrect = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    stateManager = StateManagerProvider.of(context);
  }

  @override
  void initState() {
    super.initState();

    questionVisibility = List<bool>.filled(widget.questions.length, true);
    optionVisibility = List<bool>.filled(widget.task.questions[0].options.length, true);
  }

  void evaluateAnswer() {
    if (selectedQuestionIndex != null && selectedOptionIndex != null) {
      
      final question = widget.task.questions[selectedQuestionIndex!];
      final option = question.options[selectedOptionIndex!];
      
      if (option.isCorrect) {
        setState(() {
          questionVisibility[selectedQuestionIndex!] = false;
          optionVisibility[selectedOptionIndex!] = false;

          selectedQuestionIndex = null;
          selectedOptionIndex = null;
        });
      } else {
        setState(() {
          isCorrect = false;
          selectedQuestionIndex = null;
          selectedOptionIndex = null;
        });
      }
    }

    checkAllAnswersHidden();
  }

  void checkAllAnswersHidden() {
    final allQuestionsHidden =
        questionVisibility.every((visibility) => visibility == false);
    final allOptionsHidden =
        optionVisibility.every((visibility) => visibility == false);

    if (allQuestionsHidden && allOptionsHidden) {
      widget.worksheetStateManager.saveTask5Answers(isCorrect);

      widget.worksheetStateManager.showFeedbackModal(
        context,
        isCorrect ? '' : 'false',
        () {
          stateManager.resetButtons();
          widget.worksheetStateManager.nextPage(context);
          stateManager.setPageState(PageState.answer);
        },
        task5: true
      );
    }
}

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<PageState>(
      stream: stateManager.pageStateStream,
      builder: (context, pageStateSnapshot) {
        final pageState = pageStateSnapshot.data ?? PageState.answer;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Nadpis nebo text úkolu
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Text(
                widget.task.text,
                style: const TextStyle(
                    fontSize: 16.0, fontWeight: FontWeight.w400),
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
                                isSelected: selectedQuestionIndex == i,
                                isVisible: questionVisibility[i],
                                onPressed: () {
                                  pageState == PageState.answer
                                  ? setState(() {
                                    selectedQuestionIndex = i;
                                    evaluateAnswer();
                                  }): null;
                                },
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
                          for (var i = 0;
                              i < widget.task.questions[0].options.length;
                              i++) ...[
                            Expanded(
                              child: Task5Button(
                                text:
                                    widget.task.questions[0].options[i].text ?? '',
                                isSelected: selectedOptionIndex == i,
                                isVisible: optionVisibility[i],
                                onPressed: () {
                                  pageState == PageState.answer
                                  ? setState(() {
                                    selectedOptionIndex = i;
                                    evaluateAnswer();
                                  }): null;
                                },
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
      },
    );
  }
}
