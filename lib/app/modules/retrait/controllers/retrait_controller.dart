import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_wave_app/app/data/models/user_model.dart';
import 'package:getx_wave_app/app/data/providers/state_management_provider.dart';
import 'package:getx_wave_app/app/data/services/client_service.dart';
import 'package:getx_wave_app/app/data/services/security/token_storage.dart';

class RetraitController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final montantController = TextEditingController();
  final Rxn<UserModel> user = Rxn<UserModel>();
  late String telephone;
  late String nom;

  final ClientService _clientService = Get.find<ClientService>();

  RetraitController();

  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    final Map<String, dynamic> args = Get.arguments;
    nom = args['nom'] as String;
    telephone = args['telephone'] as String;
  }

  Future<void> submitMontant() async {
    if (!formKey.currentState!.validate()) return;
    print(1);
    isLoading.value = true;
    try {
      final bool receiverPlafond = await _clientService.isTransactionSumExceedingPlafond(telephone: telephone);
      final bool senderPlafond = await _clientService.isTransactionSumExceedingPlafond(telephone: GlobalState.user.value!.telephone!);
      if(!receiverPlafond && !senderPlafond) {
        final montant = double.parse(montantController.text);
        print(2);
        final result = await _clientService.withdrawAmount(
          senderPhone: GlobalState.user.value!.telephone!,
          receiverPhone: telephone,
          amount: montant,
        );

        if (result != null) {
          print(3);
          GlobalState.user.update((val) {
            val?.wallet?.solde -= montant;
            val?.transactions?.insert(0, result);
          });

          // Update stored user data
          await TokenStorage.saveObject(
              'user', GlobalState.user.value!.toJson());

          Get.snackbar(
            'Succès',
            'Dépôt effectué avec succès',
            backgroundColor: Colors.green,
            snackPosition: SnackPosition.BOTTOM,
          );

          // Navigate to home
          Get.toNamed("/home");
        } else {
          Get.snackbar(
            'Erreur',
            'Une erreur est survenue',
            backgroundColor: Colors.red,
            snackPosition: SnackPosition.BOTTOM,
          );
        }
      }else{
        Get.snackbar(
          'Erreur',
          'Plafond Atteint',
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

  @override
  void onClose() {
    montantController.dispose();
    super.onClose();
  }
}
