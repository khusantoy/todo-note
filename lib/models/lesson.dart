import 'package:json_annotation/json_annotation.dart';
import 'package:todo_and_note/models/quiz.dart';
part 'lesson.g.dart';

@JsonSerializable()
class Lesson {
  String id;
  String courseId;
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
    return _$LessonFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$LessonToJson(this);
  }
}
