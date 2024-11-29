
/* import 'package:flutter/material.dart';
import '../screens/multiple_choice_task_page.dart';
import '../screens/text_input_task_page.dart';
import '../screens/true_false_task_page.dart';
import '../screens/test_completed_screen.dart';
import '../models/task.dart';

void navigateToTask(BuildContext context, List<Task> tasks, int currentIndex) {
  final task = tasks[currentIndex];
  Widget page;

  switch (task.type) {
    case 'multiple_choice':
      page = MultipleChoiceTaskPage(task: task, tasks: tasks, currentIndex: currentIndex);
      break;
    case 'text_input':
      page = TextInputTaskPage(task: task, tasks: tasks, currentIndex: currentIndex);
      break;
    case 'true_false':
      page = TrueFalseTaskPage(task: task, tasks: tasks, currentIndex: currentIndex);
      break;
    default:
      throw Exception('Unknown task type: ${task.type}');
  }

  Navigator.push(context, MaterialPageRoute(builder: (context) => page));
}
 */