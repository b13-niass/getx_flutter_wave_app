import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_wave_app/app/data/providers/state_management_provider.dart';
import 'package:getx_wave_app/app/modules/transfertmultiple/views/widgets/amount_field.dart';
import 'package:getx_wave_app/app/modules/transfertmultiple/views/widgets/selected_contact_grid.dart';
import 'package:getx_wave_app/app/modules/transfertmultiple/views/widgets/send_button.dart';
import '../controllers/transfertmultiple_controller.dart';

class TransfertmultipleView extends GetView<TransfertmultipleController> {
  const TransfertmultipleView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transfert de Contacts'),
      ),
      body: Obx(
            () => controller.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SelectedContactsGrid(
                    selectedContacts: controller.selectedContacts,
                  ),
                  const SizedBox(height: 24),
                  AmountField(
                    controller: controller.sentAmountController,
                    labelText: 'Montant Envoyé',
                    isEnabled: true,
                    validator: (value) {
                      final montant = (double.tryParse(value ?? '') ?? 0) * controller.selectedContacts.length;
                      if (montant <= 0 || montant > GlobalState.solde.value) {
                        return 'Montant Total (${controller.selectedContacts.length} x ${value}) doit être ≤ ${GlobalState.solde.value.round()}';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  AmountField(
                    controller: controller.receivedAmountController,
                    labelText: 'Montant Reçu',
                    isEnabled: false,
                  ),
                  const Spacer(),
                  SendButton(
                    onPressed: controller.sendTransfer,
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
