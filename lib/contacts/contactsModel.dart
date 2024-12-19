import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:sqflite/sqflite.dart';  
import 'package:scoped_model/scoped_model.dart';

class ContactsModel extends Model {
  Future<Database> _openDatabase() async {
    if (kIsWeb) {
      return openDatabase('contacts.db');  
    } else {
      throw UnsupportedError('Mobile platforms are not supported');
    }
  }

  Future<void> createTable() async {
    final db = await _openDatabase();
    await db.execute('''CREATE TABLE IF NOT EXISTS contacts (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT,
      phone TEXT,
      email TEXT
    )''');
    notifyListeners(); 
  }

  Future<void> insertContact(String name, String phone, String email) async {
    final db = await _openDatabase();
    await db.insert('contacts', {'name': name, 'phone': phone, 'email': email});
    notifyListeners(); 
  }

  Future<List<Map<String, dynamic>>> getContacts() async {
    final db = await _openDatabase();
    return await db.query('contacts');
  }

  Future<void> deleteContact(int id) async {
    final db = await _openDatabase();
    await db.delete('contacts', where: 'id = ?', whereArgs: [id]);
    notifyListeners(); 
  }
}
