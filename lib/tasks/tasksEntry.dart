import 'package:flutter/material.dart';
import 'tasksModel.dart';

class TasksEntry extends StatefulWidget {
  const TasksEntry({super.key});

  @override
  _TasksEntryState createState() => _TasksEntryState();
}

class _TasksEntryState extends State<TasksEntry> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dueDateController = TextEditingController();  

  void _saveTask() async {
    final title = _titleController.text;
    final description = _descriptionController.text;
    final dueDate = _dueDateController.text; 

    if (title.isEmpty || description.isEmpty || dueDate.isEmpty) return; 

    await TasksModel().insertTask(title, description, dueDate);  
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
              maxLines: 5,
            ),
            TextField(
              controller: _dueDateController,  
              decoration: const InputDecoration(labelText: 'Due Date'),
              keyboardType: TextInputType.datetime,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveTask,
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
