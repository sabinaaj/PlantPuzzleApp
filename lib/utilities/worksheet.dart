import 'package:plant_puzzle_app/models/worksheet.dart';
import 'package:rxdart/subjects.dart';
import 'package:flutter/material.dart';
import '../widgets/tasks/task_type_1.dart';
import '../widgets/tasks/task_type_choices.dart';
import '../widgets/tasks/task_type_5.dart';
import '../widgets/toggle_button.dart';
import '../screens/result_page.dart';

enum PageState { answer, evaluate }

class StateManager {
  final _pageStateController = BehaviorSubject<PageState>.seeded(PageState.answer);
  Stream<PageState> get pageStateStream => _pageStateController.stream;
  PageState get currentPageState => _pageStateController.value;

  final _buttonsController = BehaviorSubject<List<ToggleButtonState>>.seeded([]);
  Stream<List<ToggleButtonState>> get buttonsStream => _buttonsController.stream;
  List<ToggleButtonState> get buttons => _buttonsController.value;

  void setPageState(PageState state) => _pageStateController.add(state);

  void resetButtons() {
    for (final button in _buttonsController.value) {
      button.resetButton();
    }
  }

  void registerButton(ToggleButtonState button) {
    final updatedButtons = List<ToggleButtonState>.from(buttons)..add(button);
    _buttonsController.add(updatedButtons);
  }

  void unregisterButton(ToggleButtonState button) {
    final updatedButtons = List<ToggleButtonState>.from(buttons)..remove(button);
    _buttonsController.add(updatedButtons);
  }

  void dispose() {
    _pageStateController.close();
    _buttonsController.close();
  }
}

class StateManagerProvider extends InheritedWidget {
  final StateManager stateManager;

  const StateManagerProvider({
    Key? key,
    required this.stateManager,
    required Widget child,
  }) : super(key: key, child: child);

  static StateManager of(BuildContext context) {
    final StateManagerProvider? result =
        context.dependOnInheritedWidgetOfExactType<StateManagerProvider>();
    assert(result != null, 'No StateManagerProvider found in context');
    return result!.stateManager;
  }

  @override
  bool updateShouldNotify(StateManagerProvider oldWidget) {
    return stateManager != oldWidget.stateManager;
  }
}

class WorksheetStateManager {
  final _currentTaskIndex = BehaviorSubject<int>.seeded(0);
  Stream<int> get currentTaskIndexStream => _currentTaskIndex.stream;
  int get currentTaskIndex => _currentTaskIndex.value;

  final _currentQuestionIndex = BehaviorSubject<int>.seeded(0);
  Stream<int> get currentQuestionIndexStream => _currentQuestionIndex.stream;
  int get currentQuestionIndex => _currentQuestionIndex.value;

  final _currentPageIndex = BehaviorSubject<int>.seeded(0);
  Stream<int> get currentPageIndexStream => _currentPageIndex.stream;
  int get currentPageIndex => _currentPageIndex.value;

  final Worksheet worksheet;
  late final int totalPages;

  List<VisitorResponse> responses = []; 

  WorksheetStateManager({required this.worksheet});

  /// Calculates the total number of pages based on the given worksheet.
  ///
  /// If the task type is 1 or 4, the number of questions in the task is added to
  /// the total. Otherwise, 1 is added to the total.
  int calculateTotalPages() {
    totalPages = worksheet.tasks.fold<int>(
      0,
      (total, task) => total + (task.type == 1 || task.type == 4 ? task.questions.length : 1),
    );
    return totalPages;
  }

  /// Advances to the next page, which may be a question in the same task or the
  /// first question in the next task. It changes counters.
  void nextPage(BuildContext context) {
    final task = worksheet.tasks[currentTaskIndex];
    _currentPageIndex.add(_currentPageIndex.value + 1);

    if ((currentQuestionIndex < task.questions.length - 1) &&
        (task.type == 1 || task.type == 4)) {
      _currentQuestionIndex.add(_currentQuestionIndex.value + 1);
    } else if (currentTaskIndex < worksheet.tasks.length - 1) {
      _currentTaskIndex.add(_currentTaskIndex.value + 1);

      if (_currentQuestionIndex.value > 0) {
        _currentQuestionIndex.add(0);
      }
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResultPage(worksheetStateManager: this,),
        ),
      );
    }
  }

  /// Returns a widget based on the given task and question.
  ///
  /// The widget depends on the task type:
  /// - Type 1: [TaskType1]
  /// - Type 2, 3, 4: [TaskTypeChoices]
  /// - Type 5: [TaskType5]
  /// - Otherwise: empty [Container]
  Widget getWidgetForTask() {
    final task = worksheet.tasks[currentTaskIndex];

    switch (task.type) {
      case 1:
        return TaskType1(
          taskText: task.text,
          question: task.questions[currentQuestionIndex],
        );
      case 2:
      case 3:
      case 4:
        return TaskTypeChoices(
          taskText: task.text,
          question: task.questions[currentQuestionIndex],
          images: task.images,
        );
      case 5:
        return TaskType5(
          task: task,
        );
      default:
        return Container();
    }
  }

  void saveAnswers(StateManager stateManager) {
    
    final task = worksheet.tasks[currentTaskIndex];
    final question = task.questions[currentQuestionIndex];
    print(question.text);

    List<Option> options = [];
    bool isCorrect = true;

    for (final button in stateManager._buttonsController.value) {
      final Option? option = button.getOption();

      if (option == null) {
        continue;
      }

      print('Option: ${option.text}');
      if (button.isSelected) {
        print('Option is selected');
        options.add(option);

        if (!option.isCorrect) {
          print('Option is not correct');
          isCorrect = false;
        }
      } else {
        print('Option is not selected');
      }

      print('----');
    }

    print(options);
    print(isCorrect);

    responses.add(VisitorResponse(
      question: question,
      options: options,
      isCorrect: isCorrect,
    ));
  }

  int getCorrectAnswers() {
    int correctAnswers = 0;
    for (var response in responses) {
      if (response.isCorrect) {
        correctAnswers++;
      }
    }
    return correctAnswers;
  }

  void dispose() {
    _currentTaskIndex.close();
    _currentQuestionIndex.close();
    _currentPageIndex.close();
  }
}
