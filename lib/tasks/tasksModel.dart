import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:sqflite/sqflite.dart';  
import 'package:scoped_model/scoped_model.dart';

class TasksModel extends Model {
  Future<Database> _openDatabase() async {
    if (kIsWeb) {
      return openDatabase('tasks.db');  
    } else {
      throw UnsupportedError('Mobile platforms are not supported');
    }
  }

  Future<void> createTable() async {
    final db = await _openDatabase();
    await db.execute('''CREATE TABLE IF NOT EXISTS tasks (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT,
      description TEXT,
      due_date TEXT
    )''');
    notifyListeners(); 
  }

  Future<void> insertTask(String title, String description, String dueDate) async {
    final db = await _openDatabase();
    await db.insert('tasks', {'title': title, 'description': description, 'due_date': dueDate});
    notifyListeners(); 
  }

  Future<List<Map<String, dynamic>>> getTasks() async {
    final db = await _openDatabase();
    return await db.query('tasks');
  }

  Future<void> deleteTask(int id) async {
    final db = await _openDatabase();
    await db.delete('tasks', where: 'id = ?', whereArgs: [id]);
    notifyListeners(); 
  }
}
