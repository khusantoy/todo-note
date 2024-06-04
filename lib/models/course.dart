import 'package:todo_and_note/models/lesson.dart';

class Course {
  int id;
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
    return Course(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      lessons: (json['lessons'] as List)
          .map((lessonJson) => Lesson.fromJson(lessonJson))
          .toList(),
      price: json['price'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'lesson': lessons.map((lesson) => lesson.toJson()).toList(),
      'price': price,
    };
  }
}
