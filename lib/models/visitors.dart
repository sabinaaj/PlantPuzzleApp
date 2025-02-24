class Visitor {
  final int? id;
  List<int>? schoolGroupIds;
  List<int>? achievementIds;

  Visitor({
    this.id,
    this.schoolGroupIds,
    this.achievementIds,
  });

  factory Visitor.fromJson(Map<String, dynamic> json) {
    return Visitor(
      id: json['id'] ?? 0,
      schoolGroupIds: List<int>.from(json['school_group'] ?? []),
      achievementIds: List<int>.from(json['achievements'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id ?? 0,
      'school_group': schoolGroupIds,
      'achievements': achievementIds,
    };
  }
}

class VisitorResponse {
  final int questionId;
  final List<int> optionsIds;
  final bool isCorrect;

  VisitorResponse({
    required this.questionId,
    required this.optionsIds,
    required this.isCorrect,
  });

  factory VisitorResponse.fromJson(Map<String, dynamic> json) {
    return VisitorResponse(
      questionId: json['question'],
      optionsIds: List<int>.from(json['options']),
      isCorrect: json['is_correct'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'question': questionId,
      'options': optionsIds,
      'is_correct': isCorrect,
    };
  }
}

class SuccessRate {
  final int rate;
  final int worksheetId;

  SuccessRate({
    required this.rate,
    required this.worksheetId,
  });

  factory SuccessRate.fromJson(Map<String, dynamic> json) {
    return SuccessRate(
      rate: json['rate'],
      worksheetId: json['worksheet'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'rate': rate,
      'worksheet': worksheetId,
    };
  }
}


class SchoolGroup {
  final int id;
  final String name;

  SchoolGroup({
    required this.id,
    required this.name,
  });  

  factory SchoolGroup.fromJson(Map<String, dynamic> json) {
    return SchoolGroup(
      id: json['id'],
      name: json['group'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'group': name,
    };
  }
}


class Achievement {
  final String id;
  final String title;
  final String description;
  bool unlocked;

  Achievement({
    required this.id,
    required this.title,
    required this.description,
    this.unlocked = false,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'unlocked': unlocked,
      };

  static Achievement fromJson(Map<String, dynamic> json) => Achievement(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        unlocked: json['unlocked'],
      );
}
