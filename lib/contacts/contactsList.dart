import 'package:flutter/material.dart';
import 'contactsModel.dart';

class ContactsList extends StatefulWidget {
  const ContactsList({super.key});

  @override
  _ContactsListState createState() => _ContactsListState();
}

class _ContactsListState extends State<ContactsList> {
  List<Map<String, dynamic>> _contacts = [];

  @override
  void initState() {
    super.initState();
    _loadContacts();
  }

  void _loadContacts() async {
    final contacts = await ContactsModel().getContacts();
    setState(() {
      _contacts = contacts;
    });
  }

  void _deleteContact(int id) async {
    await ContactsModel().deleteContact(id);
    _loadContacts();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _contacts.length,
      itemBuilder: (context, index) {
        final contact = _contacts[index];
        return ListTile(
          title: Text(contact['name']),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Phone: ${contact['phone']}'),
              const SizedBox(height: 4),
              Text('Email: ${contact['email']}', style: const TextStyle(fontStyle: FontStyle.italic)),
            ],
          ),
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => _deleteContact(contact['id']),
          ),
        );
      },
    );
  }
}