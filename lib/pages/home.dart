import 'package:flutter/material.dart';

//Colors
import '../models/colors.dart';

//Widgets
import '../widgets/search_bar.dart';
import '../widgets/todo_item.dart';
import '../widgets/new_todo.dart';

//Data
import '../models/todo.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<ToDo> tasks = [
    ToDo(
      id: '1',
      task: 'Buy Milk',
      priority: 'High',
      date: DateTime.now(),
      isDone: true,
    ),
    ToDo(
      id: '2',
      task: 'Buy Eggs',
      priority: 'High',
      date: DateTime.now(),
    ),
    ToDo(
      id: '3',
      task: 'Buy Bread',
      priority: 'Low',
      date: DateTime.now(),
    ),
    ToDo(
      id: '4',
      task: 'Buy Butter',
      priority: 'Low',
      date: DateTime.now(),
    ),
    ToDo(
      id: '5',
      task: 'Buy Cheese',
      priority: 'High',
      date: DateTime.now(),
      isDone: true,
    ),
    ToDo(
      id: '6',
      task: 'Buy Yogurt',
      priority: 'Low',
      date: DateTime.now(),
    ),
    ToDo(
      id: '7',
      task: 'Buy Chicken',
      priority: 'High',
      date: DateTime.now(),
    ),
    ToDo(
      id: '8',
      task: 'Buy Beef',
      priority: 'High',
      date: DateTime.now(),
    ),
    ToDo(
      id: '9',
      task: 'Buy Pork',
      priority: 'Low',
      date: DateTime.now(),
    ),
    ToDo(
      id: '10',
      task: 'Buy Fish',
      priority: 'Low',
      date: DateTime.now(),
    ),
  ];

  List<ToDo> foundTodo = [];
  void _addNewTask(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) => NewTask(
        addTask: _setNewTask,
      ),
    );
  }

  @override
  void initState() {
    foundTodo = tasks;
    super.initState();
  }

  //Pending tasks
  int pendingTasks() {
    List<ToDo> pendingTasks =
        foundTodo.where((task) => task.isDone == false).toList();
    return pendingTasks.length;
  }

  void _setNewTask(String task, String priority, DateTime date) {
    var len = tasks.length + 1;
    final newTask = ToDo(
      id: len.toString(),
      task: task,
      priority: priority,
      date: date,
    );
    setState(() {
      tasks.add(newTask);
    });
  }

  void _checkTask(ToDo task) {
    setState(() {
      task.isDone = !task.isDone;
    });
  }

  void _deleteTask(ToDo task) {
    setState(() {
      tasks.removeWhere((todo) => todo.id == task.id);
      foundTodo.removeWhere((todo) => todo.id == task.id);
    });
  }

  void _runFilter(String enteredKeyword) {
    List<ToDo> results = [];
    if (enteredKeyword.isEmpty) {
      results = tasks;
    } else {
      results = tasks
          .where(
            (task) => task.task.toLowerCase().contains(
                  enteredKeyword.toLowerCase(),
                ),
          )
          .toList();
    }
    setState(() {
      foundTodo = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: customAppBar(),
      drawer: const Drawer(),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15.0,
          vertical: 15.0,
        ),
        child: Column(
          children: [
            Card(
              margin: const EdgeInsets.only(
                bottom: 20.0,
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15.0,
                  vertical: 20.0,
                ),
                width: double.infinity,
                child: Text(
                  'You have [${pendingTasks()}] pending tasks out of [${foundTodo.length}].',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            SearchBar(
              search: _runFilter,
            ),
            Container(
              margin: const EdgeInsets.only(
                top: 30.0,
                bottom: 20.0,
              ),
              child: const Text(
                'Your Tasks',
                style: TextStyle(
                  color: black,
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  for (ToDo task in foundTodo)
                    ToDoItem(
                      task: task,
                      checkTask: _checkTask,
                      deleteTask: _deleteTask,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
      /*
      
      Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 15.0,
          vertical: 15.0,
        ),
        child: Column(
          children: [
            SearchBar(search: _runFilter,),
            Expanded(
              child: ListView(
                children: [
                  for (ToDo task in foundTodo)
                    ToDoItem(
                      task: task,
                      checkTask: _checkTask,
                      deleteTask: _deleteTask,
                    ),
                ],
              ),
            ),
          ],
        ),
      )*/
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
        backgroundColor: bgColor,
        onPressed: () {
          _addNewTask(context);
        },
        child: const Icon(
          Icons.add,
          color: black,
        ),
      ),
    );
  }

  AppBar customAppBar() {
    return AppBar(
      title: RichText(
        text: const TextSpan(
          text: 'Task',
          style: TextStyle(
            color: black,
            fontSize: 22,
          ),
          children: <TextSpan>[
            TextSpan(
              text: ' Manager',
              style: TextStyle(
                color: red,
              ),
            ),
          ],
        ),
      ),
      backgroundColor: bgColor,
      actions: const [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 20.0,
          ),
          child: CircleAvatar(
            radius: 20.0,
            backgroundColor: red,
            child: Icon(
              Icons.person,
              color: white,
            ),
          ),
        ),
        //   IconButton(
        //     onPressed: () {},
        //     icon: const Icon(Icons.settings_backup_restore_outlined),
        //     color: black,
        //   ),
        //   IconButton(
        //     onPressed: () {},
        //     icon: const Icon(Icons.settings_outlined),
        //     color: black,
        //   ),
      ],
    );
  }
}
