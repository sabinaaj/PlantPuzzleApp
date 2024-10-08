import 'package:flutter/material.dart';
import 'screens/worksheets/task_type_1_page.dart';
import 'themes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: lightTheme,
      darkTheme: darkTheme,
      home: const TaskType1Page(),
    );
  }
}