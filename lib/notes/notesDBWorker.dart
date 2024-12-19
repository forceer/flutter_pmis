import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class NotesDBWorker {
  Future<Database> _openDatabase() async {
    databaseFactory = databaseFactoryFfi;
    
    return openDatabase('notes.db');
  }

  Future<void> createTable() async {
    final db = await _openDatabase();
    await db.execute('''CREATE TABLE IF NOT EXISTS notes (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT,
      content TEXT
    )''');
  }

  Future<void> insertNote(String title, String content) async {
    final db = await _openDatabase();
    await db.insert('notes', {'title': title, 'content': content});
  }

  Future<List<Map<String, dynamic>>> getNotes() async {
    final db = await _openDatabase();
    return await db.query('notes');
  }

  Future<void> deleteNote(int id) async {
    final db = await _openDatabase();
    await db.delete('notes', where: 'id = ?', whereArgs: [id]);
  }
}
