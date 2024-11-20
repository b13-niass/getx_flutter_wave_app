import 'package:flutter/material.dart';
import 'package:getx_wave_app/app/data/models/contact_model.dart';

class SelectedContactsGrid extends StatelessWidget {
  final List<Contact> selectedContacts;

  const SelectedContactsGrid({
    super.key,
    required this.selectedContacts,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Wrap(
        spacing: 8,
        children: selectedContacts.map((contact) {
          return Chip(
            label: Text('${contact.nom} ${contact.prenom}'),
          );
        }).toList(),
      ),
    );
  }
}
