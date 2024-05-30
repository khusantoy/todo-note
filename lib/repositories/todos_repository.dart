import 'package:todo_and_note/models/todo.dart';
import 'package:todo_and_note/services/todos_http_services.dart';

class TodosRepository {
  final todosHttpServices = TodosHttpServices();

  Future<List<Todo>> getTodos() async {
    return todosHttpServices.getTodos();
  }

  Future<Todo> addTodo(
    String id,
    String title,
    bool isCompleted,
  ) async {
    final newTodo = await todosHttpServices.addTodo(
      id,
      title,
      isCompleted,
    );
    return newTodo;
  }

  Future<void> editTodo(
    String id,
    String title,
    bool isCompleted,
  ) async {
    await todosHttpServices.editTodo(id, title, isCompleted);
  }

  Future<void> deleteTodo(String id) async {
    await todosHttpServices.deleteTodo(id);
  }
}
