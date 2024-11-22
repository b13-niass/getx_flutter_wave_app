import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_wave_app/app/data/models/user_model.dart';
import 'package:getx_wave_app/app/data/providers/state_management_provider.dart';
import 'package:getx_wave_app/app/data/services/client_service.dart';
import 'package:getx_wave_app/app/data/services/security/token_storage.dart';

class DeplafonnementController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final montantController = TextEditingController();
  final Rxn<UserModel> user = Rxn<UserModel>();
  late String telephone;
  late String nom;
  late double plafond;
  late String idUser;

  final ClientService _clientService = Get.find<ClientService>();

  DeplafonnementController();

  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    final Map<String, dynamic> args = Get.arguments;
    nom = args['nom'] as String;
    telephone = args['telephone'] as String;
    plafond = args['plafond'] as double;
    print(telephone);
  }

  Future<void> submitMontant() async {
    if (!formKey.currentState!.validate()) return;
    print(1);
    isLoading.value = true;
    try {
      final montant = double.parse(montantController.text);
      final result = await _clientService.updatePlafond(
        telephone: telephone,
        newPlafond: montant,
      );

      if (result != null) {
        GlobalState.user.update((val) {
          val?.wallet?.plafond -= montant;
        });

        // Update stored user data
        await TokenStorage.saveObject('user', GlobalState.user.value!.toJson());

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
