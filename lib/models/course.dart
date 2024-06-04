import 'package:json_annotation/json_annotation.dart';
import 'package:todo_and_note/models/lesson.dart';
part 'course.g.dart';

@JsonSerializable()
class Course {
  String id;
  String title;
  String description;
  String imageUrl;
  List<Lesson> lessons;
  double price;

  Course({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.lessons,
    required this.price,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return _$CourseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$CourseToJson(this);
  }
}
