import 'package:flutter/material.dart';
import 'appointmentsModel.dart';

class AppointmentsEntry extends StatefulWidget {
  const AppointmentsEntry({super.key});

  @override
  _AppointmentsEntryState createState() => _AppointmentsEntryState();
}

class _AppointmentsEntryState extends State<AppointmentsEntry> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  void _saveAppointment() async {
    final name = _nameController.text;
    final date = _dateController.text;

    if (name.isEmpty || date.isEmpty) return;

    await AppointmentsModel().insertAppointment(name, date);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Appointment'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Appointment Name'),
            ),
            TextField(
              controller: _dateController,
              decoration: const InputDecoration(labelText: 'Appointment Date'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveAppointment,
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
