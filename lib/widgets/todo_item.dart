import 'package:flutter/material.dart';

//Packages
import 'package:intl/intl.dart';

//Colors
import '../models/colors.dart';

//Data
import '../models/todo.dart';

class ToDoItem extends StatelessWidget {
  final ToDo task;
  final Function checkTask;
  final Function deleteTask;

  const ToDoItem({
    super.key,
    required this.task,
    required this.checkTask,
    required this.deleteTask,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 20.0,
      ),
      child: ListTile(
        onTap: () {
          checkTask(task);
        },
        tileColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        leading: IconButton(
          icon: Icon(
            task.isDone ? Icons.check_box : Icons.check_box_outline_blank,
            color: blue,
          ),
          onPressed: () {
          checkTask(task);
        },
        ),
        title: Text(
          task.task,
          style: TextStyle(
            decoration: task.isDone ? TextDecoration.lineThrough : null,
          ),
        ),
        subtitle: Text('${DateFormat.yMMMd().format(task.date)} - ${task.priority}'),
        trailing: IconButton(
          icon: const Icon(
            Icons.delete,
            color: red,
          ),
          onPressed: () {
            deleteTask(task);
          },
        ),
      ),
    );
  }
}
