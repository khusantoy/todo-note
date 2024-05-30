import 'dart:convert';

import 'package:todo_and_note/models/todo.dart';
import 'package:http/http.dart' as http;

class TodosHttpServices {
  Future<List<Todo>> getTodos() async {
    Uri url = Uri.parse(
      "https://lesson47-bcb67-default-rtdb.firebaseio.com/todos.json",
    );
    final response = await http.get(url);
    final data = jsonDecode(response.body);
    List<Todo> loadedTodos = [];

    if (data != null) {
      (data as Map).forEach((key, value) {
        value['id'] = key;
        loadedTodos.add(Todo.fromJson(value));
      });
    }

    return loadedTodos;
  }

  Future<Todo> addTodo(
    String id,
    String title,
    bool isCompleted,
  ) async {
    Uri url = Uri.parse(
      "https://lesson47-bcb67-default-rtdb.firebaseio.com/todos.json",
    );

    Map<String, dynamic> todoData = {
      "id": id,
      "title": title,
      "isCompleted": isCompleted,
    };

    final response = await http.post(
      url,
      body: jsonEncode(todoData),
    );

    final data = jsonDecode(response.body);
    todoData['id'] = data['name'];
    Todo newTodo = Todo.fromJson(todoData);
    return newTodo;
  }

  Future<void> editTodo(
    String id,
    String title,
    bool isCompleted,
  ) async {
    Uri url = Uri.parse(
      "https://lesson47-bcb67-default-rtdb.firebaseio.com/todos/$id.json",
    );

    Map<String, dynamic> todoData = {
      "id": id,
      "title": title,
      "isCompleted": isCompleted,
    };
    await http.patch(
      url,
      body: jsonEncode(todoData),
    );
  }

  Future<void> deleteTodo(String id) async {
    Uri url = Uri.parse(
      "https://lesson47-bcb67-default-rtdb.firebaseio.com/todos/$id.json",
    );

    await http.delete(url);
  }
}
