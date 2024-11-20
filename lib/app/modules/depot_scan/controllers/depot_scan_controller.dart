import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_wave_app/app/data/models/user_model.dart';
import 'package:getx_wave_app/app/data/services/multi_auth_service.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:getx_wave_app/app/routes/app_pages.dart';

class DepotScanController extends GetxController {
  final MobileScannerController cameraController = MobileScannerController();
  final AuthService _authService = Get.find<AuthService>();
  RxBool screenOpened = false.obs;

  @override
  void onInit() {
    super.onInit();
    _requestCameraPermission();
  }

  Future<void> _requestCameraPermission() async {
    if (await Permission.camera.request().isGranted) {
      // Permission granted
    } else {
      Get.snackbar(
        'Permission Requise',
        'La permission d\'accéder à la caméra est requise pour scanner les QR codes.',
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void foundBarcode(BarcodeCapture capture) async {
    if (screenOpened.value) return;

    final String code = capture.barcodes.first.rawValue ?? "---";
    debugPrint('Barcode found! $code');
    screenOpened.value = true;

    final UserModel? userResult = await _authService.getUserByPhoneNumber(code);

    if (userResult != null) {

      // Navigate to the depot page
      Get.toNamed(
        Routes.DEPOT,
        arguments: {
          'nom': '${userResult.prenom} ${userResult.nom}',
          'telephone': userResult.telephone,
        },
      );
    } else {
      screenOpened.value = false; // Allow retry if fetch failed
      Get.snackbar(
        'Erreur',
        'Utilisateur non trouvé',
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void toggleTorch() {
    cameraController.toggleTorch();
  }

  void switchCamera() {
    cameraController.switchCamera();
  }

  @override
  void onClose() {
    cameraController.dispose();
    super.onClose();
  }
}
