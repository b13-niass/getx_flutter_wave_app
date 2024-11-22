import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_wave_app/app/data/models/user_model.dart';
import 'package:getx_wave_app/app/data/services/multi_auth_service.dart';

class QrCodeGeneratorController extends GetxController {
  final RxString phoneNumber = ''.obs;
  final AuthService authService = Get.find<AuthService>();
  final Rxn<UserModel> scannedUser = Rxn<UserModel>();
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    final Map<String, dynamic> args = Get.arguments;
    phoneNumber.value = args['telephone'] as String;
  }

  Future<void> handleQrScan(String scannedData) async {
    isLoading.value = true;
    try {
      final user = await authService.getUserByPhoneNumber(scannedData);
      if (user != null) {
        scannedUser.value = user;
        Get.snackbar(
          'Success',
          'User found: ${user.nom} ${user.prenom}',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        Get.snackbar(
          'Error',
          'User not found for phone: $scannedData',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'An error occurred while searching for user: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

}
