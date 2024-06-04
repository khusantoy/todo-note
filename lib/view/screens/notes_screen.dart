import 'package:flutter/material.dart';
import 'package:todo_and_note/controllers/note_controller.dart';
import 'package:todo_and_note/models/note.dart';
import 'package:todo_and_note/view/widgets/manage_note_dialog.dart';
import 'package:todo_and_note/view/widgets/note_item.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  final notesController = NoteController();

  void editNote(Note note) async {
    final data = await showDialog(
      context: context,
      builder: (ctx) {
        return ManageNoteDialog(note: note);
      },
    );

    if (data != null) {
      notesController.editNote(
        note.id,
        data['title'],
      );
      setState(() {});
    }
  }

  void deleteNote(Note note) async {
    final response = await showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text("Are you sure?"),
          content: Text("You're deleting ${note.title}"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text("Cancel"),
            ),
            FilledButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text("Yes, I'm sure"),
            ),
          ],
        );
      },
    );

    if (response) {
      await notesController.deleteNote(note.id);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: notesController.list,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasError) {
          return Center(
            child: Text(snapshot.error.toString()),
          );
        }
        if (!snapshot.hasData) {
          return const Center(
            child: Text("Notelar mavjud emas, iltimos qo'shing"),
          );
        }
        final notes = snapshot.data;
        return notes == null
            ? const Center(
                child: Text("Notelar mavjud emas, iltimos qo'shing"),
              )
            : ListView.builder(
                padding: const EdgeInsets.all(15),
                itemCount: notes.length,
                itemBuilder: (ctx, index) {
                  final note = notes[index];
                  return NoteItem(
                    note: note,
                    onEdit: () {
                      editNote(note);
                    },
                    onDelete: () {
                      deleteNote(note);
                    },
                  );
                },
              );
      },
    );
  }
}
