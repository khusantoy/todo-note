import 'package:json_annotation/json_annotation.dart';

part 'note.g.dart';

@JsonSerializable()
class Note {
  String id;
  String title;

  Note({
    required this.id,
    required this.title,
  });

  factory Note.fromJson(Map<String, dynamic> json) {
    return _$NoteFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$NoteToJson(this);
  }
}
