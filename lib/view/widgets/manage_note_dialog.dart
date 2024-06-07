import 'package:flutter/material.dart';
import 'package:todo_and_note/models/note.dart';

class ManageNoteDialog extends StatefulWidget {
  final Note? note;
  const ManageNoteDialog({super.key, this.note});

  @override
  State<ManageNoteDialog> createState() => _ManageNoteDialogState();
}

class _ManageNoteDialogState extends State<ManageNoteDialog> {
  final formKey = GlobalKey<FormState>();
  String title = '';

  @override
  void initState() {
    super.initState();

    if (widget.note != null) {
      title = widget.note!.title;
    }
  }

  void submit() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      Navigator.pop(context, {"title": title});
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: Text(
        widget.note != null ? "Edit note" : "Add Note",
      ),
      content: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              minLines: 5,
              maxLines: 10,
              initialValue: title,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Note",
                alignLabelWithHint: true,
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Enter a note";
                }
                return null;
              },
              onSaved: (newValue) {
                title = newValue!;
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("Close"),
        ),
        FilledButton(
          onPressed: submit,
          child: const Text("Save"),
        ),
      ],
    );
  }
}
