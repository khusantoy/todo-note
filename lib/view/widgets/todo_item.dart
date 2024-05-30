import 'package:flutter/material.dart';
import 'package:todo_and_note/models/todo.dart';

class TodoItem extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xFFFEB941),
          ),
          child: ListTile(
            leading: const Icon(
              Icons.circle_outlined,
              color: Color(0xFFDD761C),
            ),
            title: Text(
              todo.title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: onEdit,
                  icon: const Icon(
                    Icons.edit,
                    color: Colors.yellow,
                  ),
                ),
                IconButton(
                  onPressed: onDelete,
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                ),
              ],
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
