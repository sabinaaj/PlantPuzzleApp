import 'package:flutter/material.dart';
import '../../widgets/continue_button.dart';
import '../../models/worksheet.dart';
import '../utilities/worksheet.dart';

class WorksheetPage extends StatefulWidget {
  final int worksheetId;

  const WorksheetPage({super.key, required this.worksheetId});

  @override
  State<WorksheetPage> createState() => _WorksheetPageState();
}

class _WorksheetPageState extends State<WorksheetPage> {
  late Future<Worksheet> _worksheetFuture;
  int currentTaskIndex = 0;
  int currentQuestionIndex = 0;

  @override
  void initState() {
    super.initState();
    _worksheetFuture = loadWorksheet(widget.worksheetId);
  }

  void _nextTask(Worksheet worksheet) {
    final task = worksheet.tasks[currentTaskIndex];

    if ((currentQuestionIndex < task.questions.length - 1) && (task.type == 1 || task.type == 4)) {
      setState(() {
        currentQuestionIndex++; // Switch to next question
      });
    } else if (currentTaskIndex < worksheet.tasks.length - 1) {
      setState(() {
        currentTaskIndex++; // Switch to next task
        currentQuestionIndex = 0; // Reset question index
      });
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test'),
      ),
      body: FutureBuilder<Worksheet>(
        future: _worksheetFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
                child: Text("Chyba při načítání dat: ${snapshot.error}"));     
          } else if (snapshot.hasData) {
            final worksheet = snapshot.data!;
            final task = worksheet.tasks[currentTaskIndex];
            final question = task.questions[currentQuestionIndex];


            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: getWidgetForTask(task, question)),
                  ContinueButton(
                    text: 'Vyhodnotit',
                    onPressed: () => _nextTask(worksheet),
                  ),
                ],
              ),
            );
          } else {
            return const Center(child: Text('Pracovní list nenalezen.'));
          }
        },
      ),
    );
  }
}
