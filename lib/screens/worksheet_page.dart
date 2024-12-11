import 'package:flutter/material.dart';
import '../../widgets/continue_button.dart';
import '../../models/worksheet.dart';
import '../widgets/tasks/task_type_1.dart';
import '../widgets/tasks/task_type_choices.dart';
import '../widgets/tasks/task_type_5.dart';
import '../services/api_service_worksheets.dart';
import '../screens/result_page.dart';

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
  Option? selectedOption;
  List<Option?> userAnswers = [];

  @override
  void initState() {
    super.initState();
    _worksheetFuture = _loadWorksheet(widget.worksheetId);
  }

  Future<Worksheet> _loadWorksheet(int worksheetId) async {
    final ApiService apiService = ApiService();
    final data = await apiService.getWorksheet(worksheetId);
    return Worksheet.fromJson(data);
}

  void _selectOption(Option option) {
    setState(() {
      selectedOption = option;
    });
  }

  bool _checkAnswer(Question question, Option selectedOption) {
    return selectedOption.isCorrect;
  }

  void _sendAnswerToBackend(Worksheet worksheet, Option? selectedOption) {
    // Zde implementujete volání API pro odeslání odpovědi
    final task = worksheet.tasks[currentTaskIndex];
    final question = task.questions[currentQuestionIndex];
    
    // Příklad volání API
/*     ApiService().sendAnswer({
      'worksheet_id': worksheet.id,
      'task_id': task.id,
      'question_id': question.id,
      'selected_option_id': selectedOption?.id,
      'is_correct': selectedOption?.isCorrect ?? false
    }); */
  }

  Widget _getWidgetForTask(Task task, Question question) {
  switch (task.type) {
    case 1:
      return TaskType1(
        taskText: task.text, 
        question: question, 
        onOptionSelected: _selectOption // Přidejte tuto metodu
      );
    case 2:
    case 3:
    case 4:
      return TaskTypeChoices(
        taskText: task.text, 
        question: question, 
        images: task.images,
        onOptionSelected: _selectOption // Přidejte tuto metodu
      );
    case 5:
      return TaskType5(
        task: task,
        onOptionSelected: _selectOption // Přidejte tuto metodu
      );
    default:
      return Container();
  }
}

  void _nextTask(Worksheet worksheet) {
    userAnswers.add(selectedOption);
    _sendAnswerToBackend(worksheet, selectedOption);

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
      Navigator.push(
        context, 
        MaterialPageRoute(
          builder: (context) => ResultPage(
            worksheet: worksheet, 
            userAnswers: userAnswers
          )
        )
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    return FutureBuilder<Worksheet>(
      future: _worksheetFuture,
      builder: (context, snapshot) {
        if (!snapshot.hasData) return CircularProgressIndicator();
        
        final worksheet = snapshot.data!;
        final totalTasks = worksheet.tasks.length;
        
        return Scaffold(
          appBar: AppBar(
            title: Text('Test'),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(4.0),
              child: LinearProgressIndicator(
                value: (currentTaskIndex + 1) / totalTasks,
                backgroundColor: Colors.grey[300],
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              ),
            ),
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
                  Expanded(child: _getWidgetForTask(task, question)),
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
      },
    );
  }
}
