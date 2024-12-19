import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class AppointmentsDBWorker {

  Future<Database> _openDatabase() async {
    databaseFactory = databaseFactoryFfi;
    return openDatabase('appointments.db');
  }

  Future<void> createTable() async {
    final db = await _openDatabase();
    await db.execute('''CREATE TABLE IF NOT EXISTS appointments (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT,
      date TEXT
    )''');
  }

  Future<void> insertAppointment(String name, String date) async {
    final db = await _openDatabase();
    await db.insert('appointments', {'name': name, 'date': date});
  }

  Future<List<Map<String, dynamic>>> getAppointments() async {
    final db = await _openDatabase();
    return await db.query('appointments');
  }

  Future<void> deleteAppointment(int id) async {
    final db = await _openDatabase();
    await db.delete('appointments', where: 'id = ?', whereArgs: [id]);
  }
}
