// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Quiz _$QuizFromJson(Map<String, dynamic> json) {
  return Quiz(
    id: json['id'],
    question: json['question'] as String,
    answers: json['answers'] as List<dynamic>,
    correctAnswer: json['correctAnswer'],
  );
}

Map<String, dynamic> _$QuizToJson(Quiz instance) => <String, dynamic>{
      'id': instance.id,
      'question': instance.question,
      'options': instance.answers,
      'correctAnswer': instance.correctAnswer,
    };
