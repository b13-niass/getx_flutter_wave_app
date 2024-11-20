import 'package:flutter/cupertino.dart';
import 'package:getx_wave_app/app/enums/enums.dart';
import 'package:getx_wave_app/app/modules/planification/views/widgets/month_day_selector.dart';
import 'package:getx_wave_app/app/modules/planification/views/widgets/week_day_selector.dart';

class FrequencySelectorWidget extends StatefulWidget {
  final RecurrenceType selecedRecurrence;
  final List<bool> selectedDays;
  final Function(bool, int) onDaySelected;
  final int selectedDayOfMonth;
  final Function(int) onSelectedDayOfMonth;

  const FrequencySelectorWidget({
    required this.selectedDayOfMonth,
    required this.onSelectedDayOfMonth,
    required this.selectedDays,
    required this.onDaySelected,
    required this.selecedRecurrence,
    super.key
  });

  @override
  State<FrequencySelectorWidget> createState() => _FrequencySelectorWidgetState();
}

class _FrequencySelectorWidgetState extends State<FrequencySelectorWidget> {
  @override
  Widget build(BuildContext context) {
    switch (widget.selecedRecurrence) {
      case RecurrenceType.DAILY:
        return Container(); // No additional selector needed for DAILY
      case RecurrenceType.WEEKLY:
        return WeekDaySelectorWidget(onDaySelected: widget.onDaySelected, selectedDays: widget.selectedDays);
      case RecurrenceType.MONTHLY:
        return MonthDaySelectorWidget(selectedDayOfMonth: widget.selectedDayOfMonth, onSelectedDayOfMonth: widget.onSelectedDayOfMonth);
    }
  }
}
