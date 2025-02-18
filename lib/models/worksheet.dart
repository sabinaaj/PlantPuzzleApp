class WorksheetSummary {
  final int id;
  final String title;

  WorksheetSummary({required this.id, required this.title});

  factory WorksheetSummary.fromJson(Map<dynamic, dynamic> json) {
    return WorksheetSummary(
      id: json['id'],
      title: json['title'],
    );
  }
}

class Worksheet {
  final int id;
  final String title;
  final List<Task> tasks;

  Worksheet({
    required this.id,
    required this.title,
    required this.tasks,
  });

  factory Worksheet.fromJson(Map<dynamic, dynamic> json) {
    return Worksheet(
      id: json['id'],
      title: json['title'],
      tasks: (json['tasks'] as List)
          .map((taskJson) => Task.fromJson(taskJson))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'tasks': tasks.map((task) => task.toJson()).toList(),
    };
  }

  factory Worksheet.empty() {
    return Worksheet(
      id: 0,
      title: '',
      tasks: [],
    );
  }
}

class Task {
  final int id;
  final String text;
  final int? type;
  final List<Question> questions;
  final List<TaskImage> images;

  Task({
    required this.id,
    required this.text,
    this.type,
    required this.questions,
    required this.images,
  });

  factory Task.fromJson(Map<dynamic, dynamic> json) {
    return Task(
      id: json['id'],
      text: json['text'],
      type: json['type'],
      questions: (json['questions'] as List)
          .map((questionJson) => Question.fromJson(questionJson))
          .toList(),
      images: (json['images'] as List)
          .map((imageJson) => TaskImage.fromJson(imageJson))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
      'type': type,
      'questions': questions.map((q) => q.toJson()).toList(),
      'images': images.map((img) => img.toJson()).toList(),
    };
  }
}

class Question {
  final int id;
  final String? text;
  final List<Option> options;

  Question({
    required this.id,
    this.text,
    required this.options,
  });

  factory Question.fromJson(Map<dynamic, dynamic> json) {
    return Question(
      id: json['id'],
      text: json['text'],
      options: (json['options'] as List)
          .map((optionJson) => Option.fromJson(optionJson))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
      'options': options.map((opt) => opt.toJson()).toList(),
    };
  }
}

class Option {
  final int id;
  final String? text;
  final bool isCorrect;

  Option({
    required this.id,
    this.text,
    required this.isCorrect,
  });

  factory Option.fromJson(Map<dynamic, dynamic> json) {
    return Option(
      id: json['id'],
      text: json['text'],
      isCorrect: json['is_correct'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
      'is_correct': isCorrect,
    };
  }
}

class TaskImage {
  final int id;
  final String? image;

  TaskImage({
    required this.id,
    required this.image,
  });

  factory TaskImage.fromJson(Map<dynamic, dynamic> json) {
    return TaskImage(
      id: json['id'],
      image: json['image_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image_url': image,
    };
  }
}
