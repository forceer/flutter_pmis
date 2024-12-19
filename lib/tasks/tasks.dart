import 'package:flutter/material.dart';
import 'tasksList.dart';
import 'tasksEntry.dart';


class Tasks extends StatelessWidget {
  const Tasks({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const Key('tasks_tab'),
      appBar: AppBar(
        title: const Text('Tasks'),
      ),
      body: TasksList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TasksEntry(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
