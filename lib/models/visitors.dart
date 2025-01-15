import 'worksheet.dart';


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
  final Question question;
  final List<Option> options;
  final bool isCorrect;

  VisitorResponse({
    required this.question,
    required this.options,
    required this.isCorrect,
  });

  factory VisitorResponse.fromJson(Map<String, dynamic> json) {
    return VisitorResponse(
      question: Question.fromJson(json['question']),
      options: (json['options'] as List)
          .map((optionJson) => Option.fromJson(optionJson))
          .toList(),
      isCorrect: json['is_correct'],
    );
  }
    Map<String, dynamic> toJson() {
    return {
      'question': question.toJson(),
      'options': options.map((opt) => opt.toJson()).toList(),
      'is_correct': isCorrect,
    };
  }   
}

class SuccessRate {
  final int rate;
  final Visitor visitor;
  final Worksheet worksheet;

  SuccessRate({
    required this.rate,
    required this.visitor,
    required this.worksheet,
  });

  factory SuccessRate.fromJson(Map<String, dynamic> json) {
    return SuccessRate(
      rate: json['rate'],
      visitor: json['visitor'],
      worksheet: json['worksheet'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'rate': rate,
      'visitor': visitor,
      'worksheet': worksheet,
    };
  }
}