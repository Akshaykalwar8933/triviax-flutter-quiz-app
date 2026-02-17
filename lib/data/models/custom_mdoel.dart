class CustomQuestionModel {
  final String question;
  final List<String> options;
  final int correctIndex;
  final String difficulty;

  CustomQuestionModel({
    required this.question,
    required this.options,
    required this.correctIndex,
    required this.difficulty,
  });

  Map<String, dynamic> toMap() {
    return {
      'question': question,
      'options': options,
      'correctIndex': correctIndex,
      'difficulty': difficulty,
    };
  }

  factory CustomQuestionModel.fromMap(
      Map<String, dynamic> map) {
    return CustomQuestionModel(
      question: map['question'],
      options:
      List<String>.from(map['options']),
      correctIndex:
      map['correctIndex'],
      difficulty:
      map['difficulty'] ?? "easy",
    );
  }
}
