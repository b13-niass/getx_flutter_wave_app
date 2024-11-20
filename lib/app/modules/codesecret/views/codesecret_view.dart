import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:getx_wave_app/core/theme/colors.dart';
import 'package:getx_wave_app/core/theme/text_styles.dart';
import '../controllers/codesecret_controller.dart';

class CodesecretView extends GetView<CodesecretController> {
  const CodesecretView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 100),
                  // Animated Header
                  TweenAnimationBuilder(
                    duration: const Duration(milliseconds: 800),
                    tween: Tween<double>(begin: 0, end: 1),
                    builder: (context, double value, child) {
                      return Opacity(
                        opacity: value,
                        child: Padding(
                          padding: EdgeInsets.only(top: 20 * (1 - value)),
                          child: child,
                        ),
                      );
                    },
                    child: const Text(
                      'Entrer le mot de passe',
                      style: AppTextStyles.heading,
                    ),
                  ),
                  const SizedBox(height: 48),

                  // PIN Code Input Fields
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(4, (index) {
                      return Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                              color: AppColors.primaryLight.withOpacity(0.3)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 4,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: RawKeyboardListener(
                          focusNode: FocusNode(),
                          onKey: (event) {
                            if (event is RawKeyDownEvent &&
                                event.logicalKey ==
                                    LogicalKeyboardKey.backspace &&
                                controller.controllers[index].text.isEmpty &&
                                index > 0) {
                              FocusScope.of(context)
                                  .requestFocus(controller.focusNodes[index - 1]);
                            }
                          },
                          child: TextFormField(
                            controller: controller.controllers[index],
                            focusNode: controller.focusNodes[index],
                            textAlign: TextAlign.center,
                            maxLength: 1,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              counterText: '',
                            ),
                            style: AppTextStyles.heading.copyWith(fontSize: 24),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return ''; // No error text for clean layout
                              }
                              return null;
                            },
                            onChanged: (value) {
                              if (value.length == 1) {
                                if (index < 3) {
                                  FocusScope.of(context)
                                      .requestFocus(controller.focusNodes[index + 1]);
                                } else {
                                  FocusScope.of(context)
                                      .unfocus(); // Dismiss keyboard when all fields are filled
                                }
                              }
                            },
                          ),
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
                        onPressed:
                        controller.isLoading.value ? null : controller.verifyCode,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.accent,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 3,
                          shadowColor: AppColors.accent.withOpacity(0.5),
                        ),
                        child: controller.isLoading.value
                            ? const CircularProgressIndicator(
                          valueColor:
                          AlwaysStoppedAnimation<Color>(Colors.white),
                        )
                            : const Text(
                          'Vérifier',
                          style: AppTextStyles.body,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
