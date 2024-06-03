import 'package:flutter/material.dart';
import 'package:todo_and_note/models/todo.dart';

class ManageTodoDialog extends StatefulWidget {
  final Todo? todo;
  const ManageTodoDialog({
    super.key,
    this.todo,
  });

  @override
  State<ManageTodoDialog> createState() => _ManageTodoDialogState();
}

class _ManageTodoDialogState extends State<ManageTodoDialog> {
  final formKey = GlobalKey<FormState>();
  String id = '';
  String title = '';

  @override
  void initState() {
    super.initState();

    if (widget.todo != null) {
      id = widget.todo!.id;
      title = widget.todo!.title;
    }
  }

  void submit() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      Navigator.pop(context, {
        "id": title,
        "title": title,
      });
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: Text(
        widget.todo != null ? "Edit todo" : "Add todo",
      ),
      content: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              initialValue: title,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Todo title",
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Enter a todo title";
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
