import 'package:flutter/material.dart';
import 'contactsList.dart';
import 'contactsEntry.dart';


class Contacts extends StatelessWidget {
  const Contacts({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const Key('contacts_tab'),
      appBar: AppBar(
        title: const Text('Contacts'),
      ),
      body: ContactsList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ContactsEntry(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
