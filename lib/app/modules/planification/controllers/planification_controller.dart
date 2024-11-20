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
  final RxList<bool> selectedDays = List.generate(7, (_) => false).obs;
  final RxInt selectedDayOfMonth = 1.obs;

  final ClientService clientService = Get.find<ClientService>();
  final Contact contact = Get.arguments['contact'];

  void onAmountChanged(double value) {
    amount.value = value;
  }


  void onRecurrenceSelected(Set<RecurrenceType> selection){
    selectedRecurrence.value = selection.first;
  }

  void onTimeSelected(TimeOfDay time) {
    selectedTime.value = time;
  }

  void onDaysSelected(bool selected, int index) {
    selectedDays[index] = selected;
  }

  void onDayOfMonthChanged(int day) {
    selectedDayOfMonth.value = day;
  }

  Future<void> submitForm() async {
    if (!formKey.currentState!.validate()) return;

    Get.snackbar('Planification', 'Planification en cours...', backgroundColor: Colors.blue);

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
    print(schedulingData);
    final result = await clientService.addPlanificationToUser(GlobalState.user.value!.id!,schedulingData);

    if (result != null) {
      GlobalState.planifications.value.insert(0, result);
      Get.snackbar('Succès', 'Planification réussie!', backgroundColor: Colors.green);
      Get.offNamed('/home');
    } else {
      Get.snackbar('Erreur', 'Planification non enregistrer', backgroundColor: Colors.red);
    }
  }

  List<String>getSelectedDays() {
    final days = ['Lun', 'Mar', 'Mer', 'Jeu', 'Ven', 'Sam', 'Dim'];
    return selectedDays
        .asMap()
        .entries
        .where((entry) => entry.value)
        .map((entry) => days[entry.key])
        .toList();
  }
}
