import 'package:flutter/material.dart';
import 'appointmentsModel.dart';

class AppointmentsList extends StatefulWidget {
  const AppointmentsList({super.key});

  @override
  _AppointmentsListState createState() => _AppointmentsListState();
}

class _AppointmentsListState extends State<AppointmentsList> {
  List<Map<String, dynamic>> _appointments = [];

  @override
  void initState() {
    super.initState();
    _loadAppointments();
  }

  void _loadAppointments() async {
    final appointments = await AppointmentsModel().getAppointments();
    setState(() {
      _appointments = appointments;
    });
  }

  void _deleteAppointment(int id) async {
    await AppointmentsModel().deleteAppointment(id);
    _loadAppointments();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _appointments.length,
      itemBuilder: (context, index) {
        final appointment = _appointments[index];
        return ListTile(
          title: Text(appointment['name']),
          subtitle: Text(appointment['date']),
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => _deleteAppointment(appointment['id']),
          ),
        );
      },
    );
  }
}
