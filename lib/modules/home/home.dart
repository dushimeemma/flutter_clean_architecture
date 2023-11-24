import 'package:flutter/material.dart';
import 'package:todo_list/domain/model/todo.dart';
import 'package:todo_list/modules/shared/todo.dart';
import 'package:uuid/uuid.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
    required this.title,
  });

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _textFieldController = TextEditingController();

  List<Todo> todos = [
    Todo(
      id: const Uuid().v8(),
      todo: 'wake up',
    ),
    Todo(
      id: const Uuid().v8(),
      todo: 'pray',
    ),
    Todo(
      id: const Uuid().v8(),
      todo: 'sport',
    ),
    Todo(
      id: const Uuid().v8(),
      todo: 'go to work',
    ),
    Todo(
      id: const Uuid().v8(),
      todo: 'sport',
    ),
    Todo(
      id: const Uuid().v8(),
      todo: 'sleep',
    ),
  ];

  void handleChangeTodo(Todo todo) {
    setState(() {
      todo.isCompleted = !todo.isCompleted;
    });
  }

  void handleDeleteTodo(Todo todo) {
    setState(() {
      todos = todos
          .where(
            (item) => item.id != todo.id,
          )
          .toList();
    });
  }

  void _addTodoItem(String name) {
    setState(() {
      todos.add(Todo(
        todo: name,
        id: const Uuid().v8(),
      ));
    });
    _textFieldController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8.0),
        children: todos.map(
          (todo) {
            return TodoItem(
              item: todo,
              handleChangeTodo: () => handleChangeTodo(todo),
              handleDeleteTodo: () => handleDeleteTodo(todo),
            );
          },
        ).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _displayDialog(),
        tooltip: 'Add Todo',
        child: const Icon(
          Icons.add,
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Future<void> _displayDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add a todo'),
          content: TextField(
            controller: _textFieldController,
            decoration: const InputDecoration(hintText: 'Type your todo'),
            autofocus: true,
          ),
          actions: <Widget>[
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                _addTodoItem(_textFieldController.text);
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }
}
