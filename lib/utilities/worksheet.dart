import 'package:rxdart/subjects.dart';
import 'package:flutter/material.dart';
import '../models/worksheet.dart';
import '../models/visitors.dart';
import '../widgets/tasks/task_type_1.dart';
import '../widgets/tasks/task_type_choices.dart';
import '../widgets/tasks/task_type_5.dart';
import '../widgets/buttons/toggle_button.dart';
import '../widgets/buttons/continue_button.dart';
import '../screens/result_page.dart';
import '../services/api_service_visitors.dart';


/// Enum representing the state of the current page (answering or evaluation)
enum PageState { answer, evaluate }

/// Manages the state of the page, including toggle buttons and page transitions
class StateManager {
  final _pageStateController =
      BehaviorSubject<PageState>.seeded(PageState.answer);
  Stream<PageState> get pageStateStream => _pageStateController.stream;
  PageState get currentPageState => _pageStateController.value;

  final _buttonsController =
      BehaviorSubject<List<ToggleButtonState>>.seeded([]);
  Stream<List<ToggleButtonState>> get buttonsStream =>
      _buttonsController.stream;
  List<ToggleButtonState> get buttons => _buttonsController.value;

  /// Updates the current page state
  void setPageState(PageState state) => _pageStateController.add(state);

  /// Resets all registered toggle buttons
  void resetButtons() {
    for (final button in _buttonsController.value) {
      button.resetButton();
    }
  }

  /// Registers a new toggle button
  void registerButton(ToggleButtonState button) {
    final updatedButtons = List<ToggleButtonState>.from(buttons)..add(button);
    _buttonsController.add(updatedButtons);
  }

  /// Unregisters an existing toggle button
  void unregisterButton(ToggleButtonState button) {
    final updatedButtons = List<ToggleButtonState>.from(buttons)
      ..remove(button);
    _buttonsController.add(updatedButtons);
  }

  /// Disposes the state controllers
  void dispose() {
    _pageStateController.close();
    _buttonsController.close();
  }
}

/// Provides access to the [StateManager] instance in the widget tree
class StateManagerProvider extends InheritedWidget {
  final StateManager stateManager;

  const StateManagerProvider({
    super.key,
    required this.stateManager,
    required super.child,
  });

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

/// Manages the state of the worksheet, including tasks, questions, and pages
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
  int calculateTotalPages() {
    totalPages = worksheet.tasks.fold<int>(
      0,
      (total, task) => total + (task.type == 1 || task.type == 4 ? task.questions.length : 1),
    );
    return totalPages;
  }

  /// Advances to the next page or navigates to the result page if completed
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
          builder: (context) => ResultPage(
            worksheetStateManager: this,
          ),
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
          worksheetStateManager: this,
        );
      default:
        return Container();
    }
  }

  /// Saves the answers for the current task
  String saveAnswers(StateManager stateManager) {
    final task = worksheet.tasks[currentTaskIndex];
    final question = task.questions[currentQuestionIndex];

    List<Option> options = [];
    bool isCorrect = true;
    String correctAnswer = '';

    for (final button in stateManager.buttons) {
      if (task.type == 5) {
        continue;
      }

      final Option? option = button.getOption();

      if (option == null) {
        continue;
      }

      if (option.isCorrect) {
        correctAnswer = option.text ?? '';
      }

      if (button.isSelected) {
        options.add(option);

        if (!option.isCorrect) {
          isCorrect = false;
        }
      }
    }

    responses.add(VisitorResponse(
      questionId: question.id,
      optionsIds: options.map((opt) => opt.id).toList(),
      isCorrect: isCorrect,
    ));

    return isCorrect ? '' : correctAnswer;
  }

  /// Saves answers for Task Type 5
  void saveTask5Answers(bool isCorrect) {
    final question = worksheet.tasks[currentTaskIndex].questions[currentQuestionIndex];

    responses.add(VisitorResponse(
      questionId: question.id,
      optionsIds: [],
      isCorrect: isCorrect,
    ));
  }

  /// Displays a feedback modal with the result of the current answer
  void showFeedbackModal(
    BuildContext context, String correctAnswer, VoidCallback onNext,{bool task5 = false}) {
    final isCorrect = correctAnswer.isEmpty;

    final modalText = isCorrect
        ? "Správná odpověď!"
        : task5
            ? "Špatná odpověď!"
            : "Bohužel! Správná odpověď je $correctAnswer.";

    showModalBottomSheet(
      context: context,
      isDismissible: false, // Prevent dismissing by tapping outside
      enableDrag: false, // Prevent dragging
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0, bottom: 6.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                isCorrect ? Icons.check_circle : Icons.error,
                color: isCorrect ? Colors.green : Colors.red,
                size: 48,
              ),
              const SizedBox(height: 16.0),
              Text(
                modalText,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 6.0),
              ContinueButton(
                text: 'Další',
                onPressed: () {
                  Navigator.pop(context);
                  onNext();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  /// Counts the total number of correct answers
  int getCorrectAnswers() {
    return responses.where((response) => response.isCorrect).length;
  }

  SuccessRate getSuccessRate() {
    final correctAnswersCnt = getCorrectAnswers();
    final int rate = ((correctAnswersCnt / totalPages) * 100).toInt();

    SuccessRate successRate =
        SuccessRate(rate: rate, worksheetId: worksheet.id);

    return successRate;
  }

  void submitResponses() async {
    final ApiService apiService = ApiService();
    await apiService.submitResponses(responses);
    await apiService.submitSuccessRate(getSuccessRate());
  }

  /// Disposes all the state controllers
  void dispose() {
    _currentTaskIndex.close();
    _currentQuestionIndex.close();
    _currentPageIndex.close();
  }
}
