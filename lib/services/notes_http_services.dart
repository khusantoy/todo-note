import 'dart:convert';

import 'package:todo_and_note/models/note.dart';
import 'package:http/http.dart' as http;

class NotesHttpServices {
  Future<List<Note>> getNotes() async {
    Uri url = Uri.parse(
      "https://lesson47-bcb67-default-rtdb.firebaseio.com/notes.json",
    );
    final response = await http.get(url);
    final data = jsonDecode(response.body);
    List<Note> loadedNotes = [];

    if (data != null) {
      (data as Map).forEach((key, value) {
        value['id'] = key;
        loadedNotes.add(Note.fromJson(value));
      });
    }

    return loadedNotes;
  }

  Future<Note> addNote(
    String id,
    String title,
  ) async {
    Uri url = Uri.parse(
      "https://lesson47-bcb67-default-rtdb.firebaseio.com/notes.json",
    );

    Map<String, dynamic> noteData = {
      "id": id,
      "title": title,
    };

    final response = await http.post(
      url,
      body: jsonEncode(noteData),
    );

    final data = jsonDecode(response.body);
    noteData['id'] = data['name'];
    Note newNote = Note.fromJson(noteData);
    return newNote;
  }

  Future<void> editNote(
    String id,
    String title,
  ) async {
    Uri url = Uri.parse(
      "https://lesson47-bcb67-default-rtdb.firebaseio.com/notes/$id.json",
    );

    Map<String, dynamic> noteData = {
      "id": id,
      "title": title,
    };
    await http.patch(
      url,
      body: jsonEncode(noteData),
    );
  }

  Future<void> deleteNote(String id) async {
    Uri url = Uri.parse(
      "https://lesson47-bcb67-default-rtdb.firebaseio.com/notes/$id.json",
    );

    await http.delete(url);
  }
}
