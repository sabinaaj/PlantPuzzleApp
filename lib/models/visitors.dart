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
