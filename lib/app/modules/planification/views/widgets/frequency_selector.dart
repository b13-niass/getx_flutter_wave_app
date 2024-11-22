import 'package:flutter/material.dart';
import 'package:getx_wave_app/app/enums/enums.dart';
import 'package:getx_wave_app/app/modules/planification/views/widgets/month_day_selector.dart';
import 'package:getx_wave_app/app/modules/planification/views/widgets/week_day_selector.dart';

class FrequencySelectorWidget extends StatelessWidget {
  final RecurrenceType selectedRecurrence;
  final List<bool> selectedDays;
  final Function(bool, int) onDaySelected;
  final int selectedDayOfMonth;
  final Function(int) onSelectedDayOfMonth;

  const FrequencySelectorWidget({
    required this.selectedDayOfMonth,
    required this.onSelectedDayOfMonth,
    required this.selectedDays,
    required this.onDaySelected,
    required this.selectedRecurrence,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    switch (selectedRecurrence) {
      case RecurrenceType.DAILY:
        return const SizedBox(); // No additional selector needed for DAILY
      case RecurrenceType.WEEKLY:
        return WeekDaySelectorWidget(
          onDaySelected: onDaySelected,
          selectedDays: selectedDays,
        );
      case RecurrenceType.MONTHLY:
        return MonthDaySelectorWidget(
          selectedDayOfMonth: selectedDayOfMonth,
          onSelectedDayOfMonth: onSelectedDayOfMonth,
        );
      default:
        return const SizedBox();
    }
  }
}
