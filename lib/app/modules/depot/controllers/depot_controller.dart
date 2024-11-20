import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_wave_app/app/data/models/user_model.dart';
import 'package:getx_wave_app/app/data/services/client_service.dart';
import 'package:getx_wave_app/app/routes/app_pages.dart';

class DepotController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final montantController = TextEditingController();

  late String telephone;
  late String nom;

  final ClientService _clientService = Get.find<ClientService>();

  DepotController();

  @override
  void onInit() {
    super.onInit();
    final Map<String, dynamic> args = Get.arguments;
    // user = args['user'] as UserModel;
    // print('Detail ID: $user');
  }

  RxBool isLoading = false.obs;

  Future<void> submitMontant() async {
    if (!formKey.currentState!.validate()) return;

    isLoading.value = true;
    try {
      final montant = double.parse(montantController.text);

      // final result = await _clientService.depot(montant.toString(), telephone);
      //
      // if (result?.status == "OK") {
      //   // Update local state or user wallet if necessary
      //   Get.snackbar(
      //     'Succès',
      //     'Dépôt effectué avec succès',
      //     backgroundColor: Colors.green,
      //     snackPosition: SnackPosition.BOTTOM,
      //   );
      //
      //   // Navigate to home
      //   Get.offAllNamed(Routes.HOME);
      // } else {
      //   Get.snackbar(
      //     'Erreur',
      //     result?.message ?? 'Une erreur est survenue',
      //     backgroundColor: Colors.red,
      //     snackPosition: SnackPosition.BOTTOM,
      //   );
      // }
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
