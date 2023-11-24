class Todo {
  final String id;
  final String todo;
  bool isCompleted;

  Todo({
    required this.id,
    required this.todo,
    this.isCompleted = false,
  });
}
