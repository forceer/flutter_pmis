import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'appointments/appointments.dart';
import 'contacts/contacts.dart';
import 'notes/notes.dart';
import 'tasks/tasks.dart';
import 'appointments/appointmentsModel.dart';
import 'contacts/contactsModel.dart';
import 'notes/notesModel.dart';
import 'tasks/tasksModel.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:sqflite_common_ffi/sqflite_ffi.dart';  
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';  

void main() async {
  if (kIsWeb) {
    databaseFactory = databaseFactoryFfiWeb;  
  } else {
    databaseFactory = databaseFactoryFfi;
  }

  await _initializeDatabase();

  runApp(MyApp());
}

Future<void> _initializeDatabase() async {

  var dbAppointments = await openDatabase('appointments.db', version: 1, onCreate: (db, version) async {
    await db.execute('''CREATE TABLE IF NOT EXISTS appointments (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        date TEXT
      )''');
  });

  List<Map> appointmentsResult = await dbAppointments.rawQuery('SELECT * FROM appointments');
  print('Appointments: $appointmentsResult');

  var dbContacts = await openDatabase('contacts.db', version: 1, onCreate: (db, version) async {
    await db.execute('''CREATE TABLE IF NOT EXISTS contacts (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        phone TEXT,
        email TEXT
      )''');
  });

  List<Map> contactsResult = await dbContacts.rawQuery('SELECT * FROM contacts');
  print('Contacts: $contactsResult');

  var dbNotes = await openDatabase('notes.db', version: 1, onCreate: (db, version) async {
    await db.execute('''CREATE TABLE IF NOT EXISTS notes (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        content TEXT
      )''');
  });

  List<Map> notesResult = await dbNotes.rawQuery('SELECT * FROM notes');
  print('Notes: $notesResult');

  var dbTasks = await openDatabase('tasks.db', version: 1, onCreate: (db, version) async {
    await db.execute('''CREATE TABLE IF NOT EXISTS tasks (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        description TEXT,
        due_date TEXT
      )''');
  });

  List<Map> tasksResult = await dbTasks.rawQuery('SELECT * FROM tasks');
  print('Tasks: $tasksResult');

  print('All databases initialized.');
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Information Manager',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<AppointmentsModel>(
      model: AppointmentsModel(),
      child: ScopedModel<ContactsModel>(
        model: ContactsModel(),
        child: ScopedModel<NotesModel>(
          model: NotesModel(),
          child: ScopedModel<TasksModel>(
            model: TasksModel(),
            child: Scaffold(
              appBar: AppBar(
                title: Text('Заметочник'),
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    ListTile(
                      title: Text('Appointments'),
                      onTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Appointments(),
                          ),
                        );
                      },
                    ),
                    ListTile(
                      title: Text('Contacts'),
                      onTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Contacts(),
                          ),
                        );
                      },
                    ),
                    ListTile(
                      title: Text('Notes'),
                      onTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Notes(),
                          ),
                        );
                      },
                    ),
                    ListTile(
                      title: Text('Tasks'),
                      onTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Tasks(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
