import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_wave_app/app/modules/transfertcontact/controllers/transfertcontact_controller.dart';
import 'package:getx_wave_app/app/modules/transfertcontact/views/widgets/contact_info_card.dart';
import 'package:getx_wave_app/core/theme/colors.dart';
import 'package:getx_wave_app/core/theme/text_styles.dart';

class TransfertcontactView extends GetView<TransfertcontactController> {
  const TransfertcontactView({super.key});

  @override
  Widget build(BuildContext context) {
    final String name = Get.arguments['name'];
    final String phoneNumber = Get.arguments['phoneNumber'];

    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      appBar: AppBar(
        backgroundColor: AppColors.primaryLight,
        title: const Text('Transfert de Contact', style: AppTextStyles.body),
        iconTheme: IconThemeData(color: AppColors.primaryBackground),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: controller.formKey,
            child: Obx(
                  () => Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Contact Info Card
                  ContactInfoCard(name: name, phoneNumber: phoneNumber),
                  const SizedBox(height: 24),

                  // Sent Amount Field (TextFormField)
                  TextFormField(
                    controller: controller.sentAmountController,
                    validator: controller.validateAmount,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Montant à envoyer',
                      labelStyle: const TextStyle(color: AppColors.primaryLight),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                            color: AppColors.primaryLight.withOpacity(0.3)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                            color: AppColors.primaryLight.withOpacity(0.3)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                            color: AppColors.primaryLight, width: 2),
                      ),
                    ),
                    style: AppTextStyles.body,
                  ),
                  const SizedBox(height: 16),

                  // Received Amount Field
                  TextFormField(
                    controller: controller.receivedAmountController,
                    enabled: false,
                    decoration: InputDecoration(
                      labelText: 'Montant Reçu',
                      labelStyle: const TextStyle(color: AppColors.primaryLight),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                            color: AppColors.primaryLight.withOpacity(0.3)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                            color: AppColors.primaryLight.withOpacity(0.3)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                            color: AppColors.primaryLight, width: 2),
                      ),
                    ),
                    style: AppTextStyles.body,
                  ),
                  const Spacer(),

                  // Send Button
                  ElevatedButton(
                    onPressed: controller.isLoading.value
                        ? null
                        : () => controller.sendTransfer(phoneNumber),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: controller.isLoading.value
                          ? AppColors.secondary
                          : AppColors.accent,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: controller.isLoading.value
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                      'Envoyer',
                      style: AppTextStyles.heading,
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
