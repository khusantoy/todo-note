import 'package:todo_and_note/models/todo.dart';
import 'package:todo_and_note/repositories/todos_repository.dart';

class TodoController {
  final todosRepository = TodosRepository();

  List<Todo> _list = [
    Todo(
      id: "1",
      title: "hello",
      isCompleted: false,
    ),
  ];

  Future<List<Todo>> get list async {
    _list = await todosRepository.getTodos();
    return [..._list];
  }

  void addTodo(
    String id,
    String title,
    bool isCompleted,
  ) async {
    final newTodo = await todosRepository.addTodo(
        id, title, isCompleted);
    _list.add(newTodo);
  }

  void editTodo(
    String id,
    String title,
  
    bool isCompleted,
  ) {
    todosRepository.editTodo(id, title, isCompleted);
    final index = _list.indexWhere((tod) {
      return tod.id == id;
    });

    _list[index].title = title;
    _list[index].isCompleted = isCompleted;
  }

  Future<void> deleteTodo(String id) async {
    await todosRepository.deleteTodo(id);
    _list.removeWhere((todo) {
      return todo.id == id;
    });
  }
}
