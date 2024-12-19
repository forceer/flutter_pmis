import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:sqflite/sqflite.dart'; 
import 'package:scoped_model/scoped_model.dart';

class NotesModel extends Model {

  Future<Database> _openDatabase() async {
    if (kIsWeb) {
      return openDatabase('notes.db');  
    } else {
      throw UnsupportedError('Mobile platforms are not supported');
    }
  }

  Future<void> createTable() async {
    final db = await _openDatabase();
    await db.execute('''CREATE TABLE IF NOT EXISTS notes (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT,
      content TEXT
    )''');
    notifyListeners();
  }

  Future<void> insertNote(String title, String content) async {
    final db = await _openDatabase();
    await db.insert('notes', {'title': title, 'content': content});
    notifyListeners(); 
  }

  Future<List<Map<String, dynamic>>> getNotes() async {
    final db = await _openDatabase();
    return await db.query('notes');
  }

  Future<void> deleteNote(int id) async {
    final db = await _openDatabase();
    await db.delete('notes', where: 'id = ?', whereArgs: [id]);
    notifyListeners(); 
  }
}
