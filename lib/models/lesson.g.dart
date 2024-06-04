// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lesson.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Lesson _$LessonFromJson(Map<String, dynamic> json) {
  List<Quiz> quizes = [];
  if (json['quizes'] != null) {
    (json['quizes'] as Map<String, dynamic>).forEach((key, value) {
      value['id'] = key;
      quizes.add(Quiz.fromJson(value));
    });
  }

  return Lesson(
    id: json['id'],
    courseId: json['courseId'],
    title: json['title'] as String,
    description: json['description'] as String,
    videoUrl: json['videoUrl'] as String,
    quizes: quizes,
  );
}

Map<String, dynamic> _$LessonToJson(Lesson instance) => <String, dynamic>{
      'id': instance.id,
      'courseId': instance.courseId,
      'title': instance.title,
      'description': instance.description,
      'videoUrl': instance.videoUrl,
      'quizes': instance.quizes.map((quiz) => quiz.toJson()),
    };
