import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_wave_app/app/data/models/user_model.dart';
import 'package:getx_wave_app/app/data/services/multi_auth_service.dart';

class VerificationCodeController extends GetxController {
  final AuthService _authService = Get.find<AuthService>();

  final formKey = GlobalKey<FormState>();
  final otpControllers = List<TextEditingController>.generate(6, (_) => TextEditingController());
  final otpFocusNodes = List<FocusNode>.generate(6, (_) => FocusNode());
  final isLoading = false.obs;
  late UserModel user;

  late final String _verificationId;

  @override
  void onInit() {
    super.onInit();
    final Map<String, dynamic> args = Get.arguments;
    user = args['user'] as UserModel;
    print('Detail ID: $user');
  }

  // Method to validate all input fields
  bool validateInputs() {
    return otpControllers.every((controller) => controller.text.isNotEmpty);
  }

  // Verify OTP
  void verifyOTP(BuildContext context) async {
    Get.snackbar('', 'Envoi du code....',
        backgroundColor: Colors.green, colorText: Colors.white);
    try {
      final otpCode = otpControllers.map((controller) => controller.text).join();
      if (otpCode.length == 6) {
          print( user.telephone!);
          print(otpCode);
        final UserModel? result = await _authService.verifyOtpAndTelephone(
            user.telephone!,
            otpCode
        );
        if(result != null){
          Get.toNamed("/codesecret", arguments: {"user": result});

          Get.snackbar('Succès', 'Le code a été vérifié avec succès!',
              backgroundColor: Colors.green, colorText: Colors.white);

        }else{
          Get.snackbar('Succès', 'Le code a été vérifié avec succès!',
              backgroundColor: Colors.red, colorText: Colors.white);
        }

      } else {
        Get.snackbar('Erreur', 'Veuillez entrer un code valide!',
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } finally {
      isLoading.value = false;
    }
  }

  void moveToNextField(BuildContext context, int index, String value) {
    if (value.isNotEmpty && index < otpFocusNodes.length - 1) {
      FocusScope.of(context).requestFocus(otpFocusNodes[index + 1]);
    } else if (value.isEmpty && index > 0) {
      FocusScope.of(context).requestFocus(otpFocusNodes[index - 1]);
    }
  }

  @override
  void onClose() {
    for (var controller in otpControllers) {
      controller.dispose();
    }
    for (var focusNode in otpFocusNodes) {
      focusNode.dispose();
    }
    super.onClose();
  }
}
