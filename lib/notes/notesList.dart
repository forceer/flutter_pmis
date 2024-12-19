import 'package:flutter/material.dart';
import 'notesModel.dart';

class NotesList extends StatefulWidget {
  const NotesList({super.key});

  @override
  _NotesListState createState() => _NotesListState();
}

class _NotesListState extends State<NotesList> {
  List<Map<String, dynamic>> _notes = [];

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  void _loadNotes() async {
    final notes = await NotesModel().getNotes();
    setState(() {
      _notes = notes;
    });
  }

  void _deleteNote(int id) async {
    await NotesModel().deleteNote(id);
    _loadNotes();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _notes.length,
      itemBuilder: (context, index) {
        final note = _notes[index];
        return ListTile(
          title: Text(note['title']),
          subtitle: Text(note['content']),
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => _deleteNote(note['id']),
          ),
        );
      },
    );
  }
}
