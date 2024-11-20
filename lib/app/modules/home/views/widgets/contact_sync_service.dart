import 'package:getx_wave_app/app/modules/home/views/widgets/database_helper.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

class ContactSyncService {
  final DatabaseHelper dbHelper = DatabaseHelper.instance;

  Future<void> syncContactsFromDevice() async {
    if (await Permission.contacts.request().isGranted) {
      final contacts = await FlutterContacts.getContacts(withProperties: true);
      print(contacts.first.phones);
      for (var contact in contacts) {
        if (contact.phones.isNotEmpty) {
          final contactData = {
            'nom': contact.name.last,
            'prenom': contact.name.first,
            'telephone': contact.phones.first.number,
            'isFavorite': 0
          };
          await dbHelper.addContact(contactData);
        }
      }
    } else {
      // Si la permission est refusée, affichez un message ou traitez l'erreur
      print("Permission refusée pour accéder aux contacts.");
    }
  }
}
