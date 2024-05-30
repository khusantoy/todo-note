import 'package:json_annotation/json_annotation.dart';

part 'todo.g.dart';

@JsonSerializable()
class Todo {
  String id;
  String title;
  bool isCompleted;

  Todo({
    required this.id,
    required this.title,
    required this.isCompleted,
  });

  factory Todo.fromJson(Map<String, dynamic> json) {
    return _$TodoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$TodoToJson(this);
  }
}
