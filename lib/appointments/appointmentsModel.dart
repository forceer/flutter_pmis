import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:sqflite/sqflite.dart';  
import 'package:scoped_model/scoped_model.dart';

class AppointmentsModel extends Model {
  Future<Database> _openDatabase() async {
    if (kIsWeb) {
      return openDatabase('appointments.db'); 
    } else {
      throw UnsupportedError('Mobile platforms are not supported');
    }
  }

  Future<void> createTable() async {
    final db = await _openDatabase();
    await db.execute('''CREATE TABLE IF NOT EXISTS appointments (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT,
      date TEXT
    )''');
    notifyListeners();
  }

  Future<void> insertAppointment(String name, String date) async {
    final db = await _openDatabase();
    await db.insert('appointments', {'name': name, 'date': date});
    notifyListeners();
  }

  Future<List<Map<String, dynamic>>> getAppointments() async {
    final db = await _openDatabase();
    return await db.query('appointments');
  }

  Future<void> deleteAppointment(int id) async {
    final db = await _openDatabase();
    await db.delete('appointments', where: 'id = ?', whereArgs: [id]);
    notifyListeners(); 
  }
}
