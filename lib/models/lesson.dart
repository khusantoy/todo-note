import 'package:todo_and_note/models/quiz.dart';

class Lesson {
  int id;
  int courseId;
  String title;
  String description;
  String videoUrl;
  List<Quiz> quizes;

  Lesson({
    required this.id,
    required this.courseId,
    required this.title,
    required this.description,
    required this.videoUrl,
    required this.quizes,
  });

  factory Lesson.fromJson(Map<String, dynamic> json) {
    return Lesson(
      id: json['id'],
      courseId: json['courseId'],
      title: json['title'],
      description: json['description'],
      videoUrl: json['videoUrl'],
      quizes: (json['quizes'] as List)
          .map((quizJson) => Quiz.fromJson(quizJson))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'courseId': courseId,
      'title': title,
      'description': description,
      'videoUrl': videoUrl,
      'quizes': quizes.map((quiz) => quiz.toJson()).toList()
    };
  }
}
