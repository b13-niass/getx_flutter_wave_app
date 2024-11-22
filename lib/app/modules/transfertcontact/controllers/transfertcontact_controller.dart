import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_wave_app/app/data/models/transaction_model.dart';
import 'package:getx_wave_app/app/data/models/user_model.dart';
import 'package:getx_wave_app/app/data/providers/state_management_provider.dart';
import 'package:getx_wave_app/app/data/services/client_service.dart';
import 'package:getx_wave_app/app/data/services/security/token_storage.dart';

class TransfertcontactController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final sentAmountController = TextEditingController();
  final receivedAmountController = TextEditingController();
  final RxBool isLoading = false.obs;

  final ClientService _clientService = Get.find<ClientService>();

  @override
  void onInit() {
    super.onInit();
    sentAmountController.addListener(_calculateReceivedAmount);
    // _initUser();
  }

  // Future<void> _initUser() async {
  //   try {
  //     final userData = await TokenStorage.getObject('user');
  //     if (userData != null) {
  //       user.value = UserModel.fromJson(userData);
  //       solde.value = user.value?.wallet?.solde ?? 0.0;
  //     }
  //   } catch (e) {
  //     print('Error initializing user: $e');
  //   }
  // }

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
      receivedAmountController.text = (montantEnvoye * 0.95).toStringAsFixed(2);
    } else {
      receivedAmountController.clear();
    }
  }

  Future<void> sendTransfer(String phoneNumber) async {
    if (!formKey.currentState!.validate()) return;

    final montantEnvoye = double.tryParse(sentAmountController.text) ?? 0;

    if (montantEnvoye > (GlobalState.user.value?.wallet?.solde ?? 0)) {
      Get.snackbar(
        'Erreur',
        'Solde insuffisant',
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    isLoading.value = true;
    try {

      final bool receiverPlafond = await _clientService.isTransactionSumExceedingPlafond(telephone: "+221$phoneNumber");
      final bool senderPlafond = await _clientService.isTransactionSumExceedingPlafond(telephone: GlobalState.user.value!.telephone!);
      if(!receiverPlafond && !senderPlafond) {
        final transactionModel = await _clientService.transferAmount(
          senderPhone: GlobalState.user.value!.telephone!,
          receiverPhone: "+221$phoneNumber",
          amount: montantEnvoye,
        );

        if (transactionModel != null) {
          GlobalState.user.update((val) {
            val?.wallet?.solde -= montantEnvoye;
            val?.transactions?.insert(0, transactionModel);
          });

          await TokenStorage.saveObject(
              'user', GlobalState.user.value!.toJson());

          Get.snackbar(
            'Succès',
            'Transfert réussi !',
            backgroundColor: Colors.green,
            snackPosition: SnackPosition.BOTTOM,
          );

          Get.offNamed('/home');
        } else {
          Get.snackbar(
            'Erreur',
            'Transfert échoué !',
            backgroundColor: Colors.red,
            snackPosition: SnackPosition.BOTTOM,
          );
        }
      }else{
        Get.snackbar(
          'Erreur',
          'Le plafond est atteint',
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Erreur',
        'Une erreur est survenue : $e',
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Validation method for form
  String? validateAmount(String? value) {
    if (value == null || value.isEmpty) {
      return 'Veuillez entrer un montant';
    }
    final amount = double.tryParse(value);
    if (amount == null || amount <= 0) {
      return 'Montant invalide';
    }
    if (amount > (GlobalState.user.value?.wallet?.solde ?? 0)) {
      return 'Solde insuffisant';
    }
    return null;
  }
}