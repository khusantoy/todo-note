import 'package:todo_and_note/models/note.dart';
import 'package:todo_and_note/repositories/notes_repository.dart';

class NoteController {
  final notesRepository = NotesRepository();

  List<Note> _list = [
    Note(
      id: "1",
      title: "hello",
    ),
  ];

  Future<List<Note>> get list async {
    _list = await notesRepository.getNotes();
    return [..._list];
  }

  void addNote(
    String id,
    String title,
  ) async {
    final newNote = await notesRepository.addNote(
        id, title);
    _list.add(newNote);
  }

  void editNote(
    String id,
    String title,
  ) {
    notesRepository.editNote(id, title);
    final index = _list.indexWhere((note) {
      return note.id == id;
    });
    _list[index].title = title;
  }

  Future<void> deleteNote(String id) async {
    await notesRepository.deleteNote(id);
    _list.removeWhere((note) {
      return note.id == id;
    });
  }
}
