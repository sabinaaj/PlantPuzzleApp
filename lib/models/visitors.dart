class Visitor {
  final String username;
  final String firstName;
  final String lastName;
  final int? schoolId;
  final List<int>? schoolGroupIds;
  final List<int>? achievementIds;

  Visitor({
    required this.username,
    required this.firstName,
    required this.lastName,
    this.schoolId,
    this.schoolGroupIds,
    this.achievementIds,
  });

  factory Visitor.fromJson(Map<String, dynamic> json) {
    return Visitor(
      username: json['username'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      schoolId: json['school'],
      schoolGroupIds: List<int>.from(json['school_group'] ?? []),
      achievementIds: List<int>.from(json['achievements'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'first_name': firstName,
      'last_name': lastName,
      'school': schoolId,
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
