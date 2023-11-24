import 'package:flutter/material.dart';
import 'package:todo_list/domain/model/todo.dart';

class TodoItem extends StatelessWidget {
  final Todo item;

  final void Function()? handleChangeTodo;

  final void Function()? handleDeleteTodo;

  const TodoItem({
    super.key,
    required this.item,
    this.handleChangeTodo,
    this.handleDeleteTodo,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: handleChangeTodo,
      leading: Checkbox(
        value: item.isCompleted,
        onChanged: null,
      ),
      title: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              item.todo,
              style: TextStyle(
                decoration: item.isCompleted
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
              ),
            ),
          )
        ],
      ),
      trailing: IconButton(
        icon: const Icon(
          Icons.delete,
          color: Colors.red,
        ),
        alignment: Alignment.center,
        onPressed: handleDeleteTodo,
      ),
    );
  }
}
