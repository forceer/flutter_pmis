import 'package:flutter/material.dart';
import 'tasksModel.dart';

class TasksList extends StatefulWidget {
  const TasksList({super.key});

  @override
  _TasksListState createState() => _TasksListState();
}

class _TasksListState extends State<TasksList> {
  List<Map<String, dynamic>> _tasks = [];

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  void _loadTasks() async {
    final tasks = await TasksModel().getTasks();
    setState(() {
      _tasks = tasks;
    });
  }

  void _deleteTask(int id) async {
    await TasksModel().deleteTask(id);
    _loadTasks();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _tasks.length,
      itemBuilder: (context, index) {
        final task = _tasks[index];
        return ListTile(
          title: Text(task['title']),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(task['description']),
              const SizedBox(height: 4),
              Text('Due Date: ${task['due_date']}', style: const TextStyle(fontStyle: FontStyle.italic)),
            ],
          ),
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => _deleteTask(task['id']),
          ),
        );
      },
    );
  }
}
