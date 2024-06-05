import 'package:flutter/material.dart';
import 'package:todo_and_note/models/todo.dart';

class TodoItem extends StatefulWidget {
  final Todo todo;
  final Function() onEdit;
  final Function() onDelete;
  const TodoItem({
    super.key,
    required this.todo,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  State<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            widget.todo.isCompleted = !widget.todo.isCompleted;
            setState(() {});
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color(0xFFFEB941),
            ),
            child: ListTile(
              leading: widget.todo.isCompleted
                  ? Container(
                      decoration: const BoxDecoration(
                        color: Colors
                            .black, // Set your desired background color here
                        shape: BoxShape
                            .circle, // This makes the container a circle
                      ),
                      child: const Icon(
                        Icons.check_circle,
                        color: Colors.green, // Set icon color to white
                      ),
                    )
                  : const Icon(
                      Icons.circle_outlined,
                      color: Color(0xFFDD761C),
                    ),
              title: Text(
                widget.todo.title,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: widget.onEdit,
                    icon: const Icon(
                      Icons.edit,
                      color: Colors.yellow,
                    ),
                  ),
                  IconButton(
                    onPressed: widget.onDelete,
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
      ],
    );
  }
}
