import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class TasksDBWorker {
  Future<Database> _openDatabase() async {
    databaseFactory = databaseFactoryFfi;
    
    return openDatabase('tasks.db');
  }

  Future<void> createTable() async {
    final db = await _openDatabase();
    await db.execute('''CREATE TABLE IF NOT EXISTS tasks (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT,
      description TEXT
    )''');
  }

  Future<void> insertTask(String title, String description) async {
    final db = await _openDatabase();
    await db.insert('tasks', {'title': title, 'description': description});
  }

  Future<List<Map<String, dynamic>>> getTasks() async {
    final db = await _openDatabase();
    return await db.query('tasks');
  }

  Future<void> deleteTask(int id) async {
    final db = await _openDatabase();
    await db.delete('tasks', where: 'id = ?', whereArgs: [id]);
  }
}
