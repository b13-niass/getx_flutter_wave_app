import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_wave_app/app/modules/contactselection/views/widgets/tab_contact.dart';
import 'package:getx_wave_app/app/modules/contactselection_multiple/controllers/contactselection_multiple_controller.dart';
import 'package:getx_wave_app/core/theme/colors.dart';
import 'package:getx_wave_app/core/theme/text_styles.dart';

class ContactselectionMultipleView extends GetView<ContactselectionMultipleController> {
  const ContactselectionMultipleView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      appBar: AppBar(
        backgroundColor: AppColors.primaryLight,
        title: Obx(() {
          final isSelectionMode = controller.isSelectionMode.value;
          final selectedCount = controller.selectedContacts.length;
          return Row(
            children: [
              Text(
                isSelectionMode
                    ? '$selectedCount sélectionné(s)'
                    : 'Contacts',
                style: const TextStyle(color: Colors.white),
              ),
              const Spacer(),
              TextButton(
                onPressed: isSelectionMode
                    ? controller.cancelSelection
                    : controller.startSelectionMode,
                child: Text(
                  isSelectionMode ? 'Annuler' : 'Sélectionner',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          );
        }),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final contacts = controller.filteredContacts;
        return Column(
          children: [
            // Search Field
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: controller.searchController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search, color: AppColors.accent),
                  hintText: 'Rechercher',
                  fillColor: Colors.white,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                        color: AppColors.primaryLight.withOpacity(0.3)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                        color: AppColors.primaryLight, width: 2),
                  ),
                ),
                onChanged: (value) {
                  controller.filteredContacts;
                },
              ),
            ),
            // Tabs
            Row(
              children: [
                TabContactWidget(
                  title: 'Favoris',
                  tab: 'favoris',
                  activeTab: controller.activeTab.value,
                  updateParentTab: (tab) => controller.activeTab.value = tab,
                ),
                TabContactWidget(
                  title: 'Contacts',
                  tab: 'contacts',
                  activeTab: controller.activeTab.value,
                  updateParentTab: (tab) => controller.activeTab.value = tab,
                ),
              ],
            ),
            // Contact List
            Expanded(
              child: contacts.isNotEmpty
                  ? ListView.builder(
                itemCount: contacts.length,
                itemBuilder: (context, index) {
                  final contact = contacts[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2,
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor:
                        AppColors.primaryLight.withOpacity(0.1),
                        child: Text(
                          contact.prenom.isNotEmpty
                              ? contact.prenom[0]
                              : 'N',
                          style: const TextStyle(color: AppColors.accent),
                        ),
                      ),
                      title: Text(
                        '${contact.prenom} ${contact.nom}',
                        style: AppTextStyles.body,
                      ),
                      trailing: controller.isSelectionMode.value
                          ? Checkbox(
                        activeColor: AppColors.primaryLight,
                        value: controller.selectedContacts
                            .contains(contact.id),
                        onChanged: (bool? value) {
                          controller.toggleSelection(contact.id);
                        },
                      )
                          : PopupMenuButton<String>(
                        icon: Icon(Icons.more_vert,
                            color: AppColors.accent),
                        onSelected: (value) {
                          if (value == 'favorite') {
                            controller.toggleFavorite(contact, !contact.isFavorite);
                          }
                        },
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            value: 'favorite',
                            child: Text(contact.isFavorite
                                ? 'Enlever des Favoris'
                                : 'Ajouter aux Favoris'),
                          ),
                        ],
                      ),
                      onTap: () {
                        if (controller.isSelectionMode.value) {
                          controller.toggleSelection(contact.id);
                        } else {
                          Get.toNamed('/transfertcontact', arguments: {
                            'name': '${contact.prenom} ${contact.nom}',
                            'phoneNumber': contact.telephone,
                          });
                        }
                      },
                    ),
                  );
                },
              )
                  : const Center(
                child: Text(
                  'Aucun contact trouvé.',
                  style: AppTextStyles.body,
                ),
              ),
            ),
          ],
        );
      }),
      floatingActionButton: Obx(() {
        if (controller.selectedContacts.isNotEmpty) {
          return FloatingActionButton.extended(
            onPressed: () {
              // print(controller.contacts);
              final selected = controller.contacts
                  .where((contact) =>
                  controller.selectedContacts.contains(contact.id))
                  .toList();
              Get.toNamed('/transfertmultiple', arguments: {'contacts': selected});
            },
            backgroundColor: AppColors.primaryLight,
            label: const Text('Transférer'),
            icon: const Icon(Icons.send),
          );
        }
        return const SizedBox.shrink();
      }),
    );
  }
}
