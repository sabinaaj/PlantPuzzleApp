
import 'package:flutter/material.dart';
import '../services/api_service_worksheets.dart';
import '../models/worksheet.dart';
import '../widgets/tasks/task_type_1.dart';
import '../widgets/tasks/task_type_choices.dart';
import '../widgets/tasks/task_type_5.dart';

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
    case 3:
    case 4:
      return TaskTypeChoices(taskText: task.text, question: question, images: task.images);
    case 5:
      return TaskType5(task: task);
    default:
      return Container();
      //throw Exception("Unknown task type");
  }
}
