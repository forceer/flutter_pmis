import 'package:flutter/material.dart';
import 'contactsModel.dart';

class ContactsEntry extends StatefulWidget {
  const ContactsEntry({super.key});

  @override
  _ContactsEntryState createState() => _ContactsEntryState();
}

class _ContactsEntryState extends State<ContactsEntry> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();  

  void _saveContact() async {
    final name = _nameController.text;
    final phone = _phoneController.text;
    final email = _emailController.text; 

    if (name.isEmpty || phone.isEmpty || email.isEmpty) return; 

    await ContactsModel().insertContact(name, phone, email); 
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Contact'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Contact Name'),
            ),
            TextField(
              controller: _phoneController,
              decoration: const InputDecoration(labelText: 'Phone Number'),
            ),
            TextField(
              controller: _emailController,  
              decoration: const InputDecoration(labelText: 'Email Address'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveContact,
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}