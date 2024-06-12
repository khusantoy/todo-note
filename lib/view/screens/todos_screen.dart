import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_and_note/controllers/todo_controller.dart';
import 'package:todo_and_note/models/todo.dart';
import 'package:todo_and_note/view/widgets/manage_todo_dialog.dart';
import 'package:todo_and_note/view/widgets/todo_item.dart';

class TodosScreen extends StatefulWidget {
  const TodosScreen({super.key});

  @override
  State<TodosScreen> createState() => _TodosScreenState();
}

class _TodosScreenState extends State<TodosScreen> {
  final todosController = TodoController();

  void addTodo() async {
    final data = await showDialog(
      context: context,
      builder: (ctx) {
        return const ManageTodoDialog();
      },
    );

    if (data != null) {
      try {
        todosController.addTodo(
          data['id'],
          data['title'],
          data['isCompleted'] ?? false,
        );
        setState(() {});
      } catch (e) {
        debugPrint(e.toString());
      }
    }
  }

  void editTodo(Todo todo) async {
    final data = await showDialog(
      context: context,
      builder: (ctx) {
        return ManageTodoDialog(todo: todo);
      },
    );

    if (data != null) {
      todosController.editTodo(
        todo.id,
        data['title'],
        data['isCompleted'] ?? false,
      );
      setState(() {});
    }
  }

  void deleteTodo(Todo todo) async {
    final response = await showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text("ishonchingiz komilmi?"),
          content: Text("Siz ${todo.title} o'chirmoqchisiz."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text("Bekor qilish"),
            ),
            FilledButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text("Ha, ishonchim komil"),
            ),
          ],
        );
      },
    );

    if (response) {
      await todosController.deleteTodo(todo.id);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: todosController.list,
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
                child: Text("Todo mavjud emas, iltimos qo'shing"),
              );
            }
            final todos = snapshot.data;
            return todos == null || todos.isEmpty
                ? const Center(
                    child: Text("Todo mavjud emas, iltimos qo'shing"),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(15),
                    itemCount: todos.length,
                    itemBuilder: (ctx, index) {
                      final todo = todos[index];
                      return TodoItem(
                        todo: todo,
                        onEdit: () {
                          editTodo(todo);
                        },
                        onDelete: () {
                          deleteTodo(todo);
                        },
                      );
                    },
                  );
          }),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: const Color(0xFF03AED2),
        onPressed: addTodo,
        child: const Icon(CupertinoIcons.add, color: Colors.white),
      ),
    );
  }
}
