import 'package:flutter/material.dart';
import 'notesModel.dart';

class NotesEntry extends StatefulWidget {
  const NotesEntry({super.key});

  @override
  _NotesEntryState createState() => _NotesEntryState();
}

class _NotesEntryState extends State<NotesEntry> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  void _saveNote() async {
    final title = _titleController.text;
    final content = _contentController.text;

    if (title.isEmpty || content.isEmpty) return;

    await NotesModel().insertNote(title, content);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Note'),
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
              controller: _contentController,
              decoration: const InputDecoration(labelText: 'Content'),
              maxLines: 5,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveNote,
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
