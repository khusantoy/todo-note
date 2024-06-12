import 'package:json_annotation/json_annotation.dart';

part 'note.g.dart';

@JsonSerializable()
class Note {
  final int id;
  String title;

  Note({
    required this.id,
    required this.title,
  });

  factory Note.fromJson(Map<String, dynamic> json) {
    return _$NoteFromJson(json);
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(id: map['id'], title: map['title']);
  }

  Map<String, dynamic> toJson() {
    return _$NoteToJson(this);
  }
}
