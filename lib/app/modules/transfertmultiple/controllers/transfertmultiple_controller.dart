import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_wave_app/app/data/models/contact_model.dart';
import 'package:getx_wave_app/app/data/models/transaction_model.dart';
import 'package:getx_wave_app/app/data/models/user_model.dart';
import 'package:getx_wave_app/app/data/providers/state_management_provider.dart';
import 'package:getx_wave_app/app/data/services/client_service.dart';

class TransfertmultipleController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final sentAmountController = TextEditingController();
  final receivedAmountController = TextEditingController();

  final RxList<Contact> selectedContacts = <Contact>[].obs;
  final RxDouble solde = 0.0.obs;
  final RxBool isLoading = false.obs;

  final ClientService _clientService = Get.find<ClientService>();

  @override
  void onInit() {
    super.onInit();
    sentAmountController.addListener(_calculateReceivedAmount);

    // Get the passed contacts
    selectedContacts.value = Get.arguments['contacts'] ?? [];
    // print(selectedContacts);
    solde.value = Get.arguments['solde'] ?? 0.0;
  }

  @override
  void onClose() {
    sentAmountController.removeListener(_calculateReceivedAmount);
    sentAmountController.dispose();
    receivedAmountController.dispose();
    super.onClose();
  }

  void _calculateReceivedAmount() {
    final montantEnvoye = double.tryParse(sentAmountController.text) ?? 0;
    if (montantEnvoye > 0) {
      receivedAmountController.text = (montantEnvoye * 0.95).toStringAsFixed(2); // 5% fee deduction
    } else {
      receivedAmountController.clear();
    }
  }

  Future<void> sendTransfer() async {
    if (!formKey.currentState!.validate()) return;

    isLoading.value = true;

    try {
      final users = selectedContacts.map((contact) {
        return UserModel(
          telephone: "+221${contact.telephone}",
        );
      }).toList();



      double montantEnvoye = double.parse(sentAmountController.text);
      double montantRecus = double.parse(receivedAmountController.text);

      double montantTotal = montantEnvoye * users.length;
      if(montantTotal <= GlobalState.solde.value) {
        final List<TransactionModel> results = await _clientService
            .transferMultipleAmounts(
            senderPhone: GlobalState.user.value!.telephone!,
            receivers: users,
            montant: montantEnvoye
        );
        if (results != null) {
          GlobalState.solde.value -= montantTotal;
          GlobalState.transactions.value.insertAll(0, results..sort((a, b) {
            return b.createdAt!.compareTo(a.createdAt!);
          }));
          Get.offNamed('/home');
          Get.snackbar(
            'Succès',
            'Transfert Réussit',
            backgroundColor: Colors.green,
            snackPosition: SnackPosition.BOTTOM,
          );
        } else {
          Get.snackbar(
            'Erreur',
            'Le transfert à échoué',
            backgroundColor: Colors.redAccent,
            snackPosition: SnackPosition.BOTTOM,
          );
        }
      }else{
        Get.snackbar(
          'Erreur',
          'Le montant est insuffisant',
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Erreur',
        'Une erreur est survenue : $e',
        backgroundColor: Colors.redAccent,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
