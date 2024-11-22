import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_wave_app/app/data/models/contact_model.dart';
import 'package:getx_wave_app/app/data/providers/state_management_provider.dart';
import 'package:getx_wave_app/app/enums/enums.dart';
import 'package:getx_wave_app/app/data/services/client_service.dart';

class PlanificationController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final RxDouble amount = 0.0.obs;
  final Rx<RecurrenceType> selectedRecurrence = RecurrenceType.DAILY.obs;
  final Rx<TimeOfDay> selectedTime = TimeOfDay.now().obs;
  final RxList<bool> selectedDays = List.generate(7, (_) => false).obs; // For WEEKLY recurrence
  final RxInt selectedDayOfMonth = 1.obs; // For MONTHLY recurrence

  final ClientService clientService = Get.find<ClientService>();
  final Contact contact = Get.arguments['contact'];

  /// Called when the amount is changed in the form.
  void onAmountChanged(double value) {
    amount.value = value;
  }

  /// Handles changes in the recurrence type and resets other fields as needed.
  void onRecurrenceSelected(Set<RecurrenceType> recurrence) {
    selectedRecurrence.value = recurrence as RecurrenceType;

    // Reset dependent fields based on the recurrence type
    if (recurrence == RecurrenceType.WEEKLY) {
      selectedDays.value = List.generate(7, (_) => false);
    } else if (recurrence == RecurrenceType.MONTHLY) {
      selectedDayOfMonth.value = 1;
    }
  }

  /// Called when the user selects a time.
  void onTimeSelected(TimeOfDay time) {
    selectedTime.value = time;
  }

  /// Called when a day of the week is selected for WEEKLY recurrence.
  void onDaysSelected(bool selected, int index) {
    selectedDays[index] = selected;
  }

  /// Called when the user selects a day of the month for MONTHLY recurrence.
  void onDayOfMonthChanged(int day) {
    selectedDayOfMonth.value = day;
  }

  /// Submits the form and creates a new planification.
  Future<void> submitForm() async {
    if (!formKey.currentState!.validate()) return;

    Get.snackbar(
      'Planification',
      'Planification en cours...',
      backgroundColor: Colors.blue,
    );

    final Map<String, dynamic> schedulingData = {
      'montant': amount.value,
      'telephone': contact.telephone,
      'recurrenceType': selectedRecurrence.value.toString().split('.').last,
      'timeOfDay': '${selectedTime.value.hour}:${selectedTime.value.minute}',
      if (selectedRecurrence.value == RecurrenceType.WEEKLY)
        'daysOfWeek': getSelectedDays(),
      if (selectedRecurrence.value == RecurrenceType.MONTHLY)
        'dayOfMonth': selectedDayOfMonth.value,
    };

    try {
      final result = await clientService.addPlanificationToUser(
        GlobalState.user.value!.id!,
        schedulingData,
      );

      if (result != null) {
        GlobalState.planifications.value.insert(0, result);
        Get.snackbar(
          'Succès',
          'Planification réussie!',
          backgroundColor: Colors.green,
        );
        Get.offNamed('/home');
      } else {
        Get.snackbar(
          'Erreur',
          'Planification non enregistrée',
          backgroundColor: Colors.red,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Erreur',
        'Une erreur est survenue : $e',
        backgroundColor: Colors.red,
      );
    }
  }

  /// Returns a list of selected days for WEEKLY recurrence.
  List<String> getSelectedDays() {
    final days = ['Lun', 'Mar', 'Mer', 'Jeu', 'Ven', 'Sam', 'Dim'];
    return selectedDays
        .asMap()
        .entries
        .where((entry) => entry.value)
        .map((entry) => days[entry.key])
        .toList();
  }
}
