import 'package:flutter/material.dart';
import 'appointmentsList.dart';
import 'appointmentsEntry.dart';


class Appointments extends StatelessWidget {
  const Appointments({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const Key('appointments_tab'),
      appBar: AppBar(
        title: const Text('Appointments'),
      ),
      body: AppointmentsList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AppointmentsEntry(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
