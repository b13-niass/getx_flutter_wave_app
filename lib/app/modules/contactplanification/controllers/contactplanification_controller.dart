import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_wave_app/app/data/models/contact_model.dart';
import 'package:getx_wave_app/app/modules/home/views/widgets/database_helper.dart';

class ContactplanificationController extends GetxController {
  final selectedContacts = <int>{}.obs;
  final isSelectionMode = false.obs;
  final isLoading = true.obs;
  final activeTab = 'contacts'.obs;
  final searchController = TextEditingController();
  final contacts = <Contact>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadContacts();
  }

  Future<void> _loadContacts() async {
    isLoading.value = true;
    final dbHelper = DatabaseHelper.instance;
    final contactData = await dbHelper.fetchContacts();
    contacts.value = contactData.map((map) => Contact.fromMap(map)).toList();
    isLoading.value = false;
  }

  void startSelectionMode() {
    isSelectionMode.value = true;
  }

  void cancelSelection() {
    selectedContacts.clear();
    isSelectionMode.value = false;
  }

  void toggleSelection(int contactId) {
    if (selectedContacts.contains(contactId)) {
      selectedContacts.remove(contactId);
    } else {
      selectedContacts.add(contactId);
    }
  }

  void toggleFavorite(Contact contact, bool isFavorite) async {
    contact.isFavorite = isFavorite;
    await DatabaseHelper.instance.updateContact(contact.toMap());
    await _loadContacts(); // Refresh the list after the update
  }

  List<Contact> get filteredContacts {
    return contacts.where((contact) {
      bool matchesSearch = contact.nom
          .toLowerCase()
          .contains(searchController.text.toLowerCase());
      bool matchesTab = activeTab.value == 'contacts' ||
          (activeTab.value == 'favoris' && contact.isFavorite);
      return matchesSearch && matchesTab;
    }).toList();
  }
}
