class ToDo {
  final String id;
  final String task;
  final DateTime date;
  final String priority;
  bool isDone;

  ToDo({
    required this.id,
    required this.task,
    required this.date,
    required this.priority,
    this.isDone = false,
  });
}
