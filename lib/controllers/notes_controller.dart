import 'package:todo_and_note/models/note.dart';
import 'package:todo_and_note/repositories/notes_repository.dart';

class NotesController {
  final notesRepository = NotesRepository();

  List<Note> _list = [];

  Future<List<Note>> get list async {
    _list = await notesRepository.getNotes();
    return [..._list];
  }

  Future<void> addNote({required String title}) async {
    await notesRepository.addNote(title: title);
  }

  void editNote(int id, String title) async {
    await notesRepository.editNote(id, title);
    // final index = _list.indexWhere((note) {
    //   return note.id == id;
    // });
    // _list[index].title = title;
  }

  Future<void> deleteNote(int id) async {
    await notesRepository.deleteNote(id);
    // await notesRepository.deleteNote(id);
    // _list.removeWhere((note) {
    //   return note.id == id;
    // });
  }
}
