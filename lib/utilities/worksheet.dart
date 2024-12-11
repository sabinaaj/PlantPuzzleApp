
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
