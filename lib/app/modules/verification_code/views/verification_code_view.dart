import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_wave_app/app/modules/verification_code/controllers/verification_code_controller.dart';
import 'package:getx_wave_app/core/theme/colors.dart';

class VerificationCodeView extends GetView<VerificationCodeController> {
  const VerificationCodeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 80),
                // Header
                Text(
                  'Code de vérification',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: AppColors.dark,
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Veuillez entrer le code envoyé à votre téléphone.',
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.secondary,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 48),

                // OTP Input Fields (6 fields)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(6, (index) {
                    return Container(
                      width: 50,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: AppColors.primaryLight.withOpacity(0.5),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: TextFormField(
                        controller: controller.otpControllers[index],
                        focusNode: controller.otpFocusNodes[index],
                        textAlign: TextAlign.center,
                        maxLength: 1,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          counterText: '',
                        ),
                        style: TextStyle(
                          fontSize: 24,
                          color: AppColors.dark,
                          fontWeight: FontWeight.bold,
                        ),
                        onChanged: (value) {
                          controller.moveToNextField(context, index, value);
                        },
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 40),

                // Verify Button
                Obx(
                      () => SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: controller.isLoading.value
                          ? null
                          : () => controller.verifyOTP(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.accent,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 4,
                        shadowColor: AppColors.accent.withOpacity(0.4),
                      ),
                      child: controller.isLoading.value
                          ? const CircularProgressIndicator(
                        valueColor:
                        AlwaysStoppedAnimation<Color>(Colors.white),
                      )
                          : const Text(
                        'Vérifier',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                TextButton(
                  onPressed: () async {
                    try {
                      // Resend logic
                    } catch (e) {
                      print(e.toString());
                    }

                    Get.snackbar(
                      'Code renvoyé',
                      'Le code a été renvoyé avec succès.',
                      backgroundColor: AppColors.primaryLight,
                      colorText: Colors.white,
                    );
                  },
                  child: Text(
                    'Renvoyer le code',
                    style: TextStyle(
                      color: AppColors.primaryLight,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
