import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class ContactsDBWorker {
  Future<Database> _openDatabase() async {
    databaseFactory = databaseFactoryFfi;
    
    return openDatabase('contacts.db');
  }

  Future<void> createTable() async {
    final db = await _openDatabase();
    await db.execute('''CREATE TABLE IF NOT EXISTS contacts (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT,
      phone TEXT
    )''');
  }

  Future<void> insertContact(String name, String phone) async {
    final db = await _openDatabase();
    await db.insert('contacts', {'name': name, 'phone': phone});
  }

  Future<List<Map<String, dynamic>>> getContacts() async {
    final db = await _openDatabase();
    return await db.query('contacts');
  }

  Future<void> deleteContact(int id) async {
    final db = await _openDatabase();
    await db.delete('contacts', where: 'id = ?', whereArgs: [id]);
  }
}
