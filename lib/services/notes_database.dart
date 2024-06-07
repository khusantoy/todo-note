import 'package:flutter/foundation.dart';
import 'package:todo_and_note/models/note.dart';
import 'package:todo_and_note/services/local_database.dart';

class NotesDatabase {
  final _localDatabase = LocalDatabase();
  final _tableName = "notes";

  Future<List<Note>> getNotes() async {
    final db = await _localDatabase.database;
    final rows = await db.query(_tableName);

    List<Note> notes = [];

    for (var row in rows) {
      notes.add(
        Note.fromMap(row),
      );
    }

    return notes;
  }

  Future<void> addNote({required String title}) async {
    try {
      final db = await _localDatabase.database;
      await db.insert(_tableName, {'title': title});
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> editNote(int id, Map<String, dynamic> note) async {
    final db = await _localDatabase.database;
    await db.update(_tableName, note, where: "id = $id");
  }

  Future<void> deleteNote(int id) async {
    final db = await _localDatabase.database;
    await db.delete(_tableName, where: "id = ?", whereArgs: [id]);
  }
}
