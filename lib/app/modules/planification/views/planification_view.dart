import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_wave_app/app/modules/planification/controllers/planification_controller.dart';
import 'package:getx_wave_app/app/modules/planification/views/widgets/amount_field.dart';
import 'package:getx_wave_app/app/modules/planification/views/widgets/contact_info.dart';
import 'package:getx_wave_app/app/modules/planification/views/widgets/frequency_selector.dart';
import 'package:getx_wave_app/app/modules/planification/views/widgets/recurrence_selector.dart';
import 'package:getx_wave_app/app/modules/planification/views/widgets/submit_button.dart';
import 'package:getx_wave_app/app/modules/planification/views/widgets/summary_card.dart';
import 'package:getx_wave_app/app/modules/planification/views/widgets/time_selector.dart';
import 'package:getx_wave_app/core/theme/colors.dart';

class PlanificationView extends GetView<PlanificationController> {
  const PlanificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      appBar: AppBar(
        backgroundColor: AppColors.primaryLight,
        title: const Text(
          'Planifier un envoi récurrent',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Form(
        key: controller.formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            ContactInfoWidget(contact: controller.contact),
            const SizedBox(height: 24),
            AmountFieldWidget(onAmountChanged: controller.onAmountChanged),
            const SizedBox(height: 24),
            RecurrenceSelectorWidget(
              selectedRecurrence: controller.selectedRecurrence.value,
              onRecurrenceSelected: controller.onRecurrenceSelected,
            ),
            const SizedBox(height: 16),
            TimeSelectorWidget(
              selectedTime: controller.selectedTime.value,
              onTimeSelected: controller.onTimeSelected,
            ),
            const SizedBox(height: 16),
            FrequencySelectorWidget(
              selecedRecurrence: controller.selectedRecurrence.value,
              selectedDays: controller.selectedDays,
              onDaySelected: controller.onDaysSelected,
              selectedDayOfMonth: controller.selectedDayOfMonth.value,
              onSelectedDayOfMonth: controller.onDayOfMonthChanged,
            ),
            const SizedBox(height: 24),
            Obx(
                  () => SummaryCardWidget(
                selectedRecurrence: controller.selectedRecurrence.value,
                selectedDayOfMonth: controller.selectedDayOfMonth.value,
                getSelectedDaysText: controller.getSelectedDays,
                amount: controller.amount.value,
                telephone: controller.contact.telephone,
                selectedTime: controller.selectedTime.value,
              ),
            ),
            const SizedBox(height: 24),
            SubmitButtonWidget(
              label: 'Planifier',
              submitForm: controller.submitForm,
            ),
          ],
        ),
      ),
    );
  }
}

