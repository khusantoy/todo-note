import 'package:todo_and_note/models/note.dart';
import 'package:todo_and_note/services/notes_http_services.dart';

class NotesRepository {
  final notesHttpServices = NotesHttpServices();

  Future<List<Note>> getNotes() async {
    return notesHttpServices.getNotes();
  }

  Future<Note> addNote(
    String id,
    String title,
  ) async {
    final newNote = await notesHttpServices.addNote(
      id,
      title,
    );
    return newNote;
  }

  Future<void> editNote(
    String id,
    String title,
  ) async {
    await notesHttpServices.editNote(id, title);
  }

  Future<void> deleteNote(String id) async {
    await notesHttpServices.deleteNote(id);
  }
}
