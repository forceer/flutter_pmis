import 'package:flutter/material.dart';
import 'notesList.dart';
import 'notesEntry.dart';


class Notes extends StatelessWidget {
  const Notes({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const Key('notes_tab'),
      appBar: AppBar(
        title: const Text('Notes'),
      ),
      body: NotesList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NotesEntry(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
