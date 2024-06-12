import 'package:todo_and_note/models/note.dart';
import 'package:todo_and_note/services/notes_database.dart';
import 'package:todo_and_note/services/notes_http_services.dart';

class NotesRepository {
  // FROM FIREBASE

  final notesHttpServices = NotesHttpServices();
  final notesDatabase = NotesDatabase();

  Future<List<Note>> getNotes() async {
    return await notesDatabase.getNotes();
  }

  Future<void> addNote({required String title}) async {
    await notesDatabase.addNote(title: title);
    //   final newNote = await notesHttpServices.addNote(title);
    //   return newNote;
  }

  Future<void> editNote(int id, String title) async {
    // await notesHttpServices.editNote(id, title);
    await notesDatabase.editNote(id, {'title': title});
  }

  Future<void> deleteNote(int id) async {
    await notesDatabase.deleteNote(id);
  }
}
