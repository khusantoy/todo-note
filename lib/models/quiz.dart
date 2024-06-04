class Quiz {
  int id;
  String question;
  List options;

  Quiz({required this.id, required this.question, required this.options});

  factory Quiz.fromJson(Map<String, dynamic> json) {
    return Quiz(
      id: json['id'],
      question: json['question'],
      options: json['options'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'question': question,
      'options': options,
    };
  }
}
