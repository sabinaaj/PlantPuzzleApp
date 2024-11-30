
import 'package:flutter/material.dart';
import '../services/api_service_worksheets.dart';
import '../models/worksheet.dart';
import '../widgets/tasks/task_type_1.dart';
import '../widgets/tasks/task_type_2.dart';

Future<Worksheet> loadWorksheet(int worksheetId) async {
    final ApiService apiService = ApiService();
    final data = await apiService.getWorksheet(worksheetId);
    return Worksheet.fromJson(data);
}


Widget getWidgetForTask(Task task, Question question) {
  switch (task.type) {
    case 1:
      return TaskType1(taskText: task.text, question: question);
    case 2:
      return TaskType2(taskText: task.text, question: question);
    /* case 3:
      return TaskType2Page(task: task);
    case 4:
      return TaskType4Page(task: task, question: question);
    case 5:
      return TaskType5Page(task: task); */
    default:
      return Container();
      //throw Exception("Unknown task type");
  }
}
