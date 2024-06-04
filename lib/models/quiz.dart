import 'package:json_annotation/json_annotation.dart';
part 'quiz.g.dart';

@JsonSerializable()
class Quiz {
  String id;
  String question;
  List answers;
  int correctAnswer;

  Quiz({
    required this.id,
    required this.question,
    required this.answers,
    required this.correctAnswer,
  });

  factory Quiz.fromJson(Map<String, dynamic> json) {
    return _$QuizFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$QuizToJson(this);
  }
}
