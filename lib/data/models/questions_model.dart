class QuestionModel {
  QuestionModel({
    required this.category,
    required this.id,
    required this.correctAnswer,
    required this.incorrectAnswers,
    required this.question,
    required this.tags,
    required this.type,
    required this.difficulty,
    required this.regions,
    required this.isNiche,
  });

  final String category;
  final String id;
  final String correctAnswer;
  final List<String> incorrectAnswers;
  final String question;
  final List<String> tags;
  final String type;
  final String difficulty;
  final List<dynamic> regions;
  final bool isNiche;

  ///  Combine + Shuffle options (Very Important)
  List<String> get options {
    final allOptions = [...incorrectAnswers, correctAnswer];
    allOptions.shuffle();
    return allOptions;
  }

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      category: json["category"] ?? "",
      id: json["id"] ?? "",
      correctAnswer: json["correctAnswer"] ?? "",
      incorrectAnswers: json["incorrectAnswers"] == null
          ? []
          : List<String>.from(json["incorrectAnswers"]),
      question: json["question"] ?? "",
      tags: json["tags"] == null
          ? []
          : List<String>.from(json["tags"]),
      type: json["type"] ?? "",
      difficulty: json["difficulty"] ?? "",
      regions: json["regions"] == null
          ? []
          : List<dynamic>.from(json["regions"]),
      isNiche: json["isNiche"] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
    "category": category,
    "id": id,
    "correctAnswer": correctAnswer,
    "incorrectAnswers": incorrectAnswers,
    "question": question,
    "tags": tags,
    "type": type,
    "difficulty": difficulty,
    "regions": regions,
    "isNiche": isNiche,
  };
}
