import 'package:flutter/material.dart';

class MonthDaySelectorWidget extends StatefulWidget {
  final int selectedDayOfMonth;
  final Function(int) onSelectedDayOfMonth;
  const MonthDaySelectorWidget({
    required this.selectedDayOfMonth,
    required this.onSelectedDayOfMonth,
    super.key
  });

  @override
  State<MonthDaySelectorWidget> createState() => _MonthDaySelectorWidgetState();
}

class _MonthDaySelectorWidgetState extends State<MonthDaySelectorWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Jour du mois',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                activeTrackColor: Theme.of(context).primaryColor,
                inactiveTrackColor:
                Theme.of(context).primaryColor.withOpacity(0.3),
                thumbColor: Theme.of(context).primaryColor,
              ),
              child: Slider(
                value: widget.selectedDayOfMonth.toDouble(),
                min: 1,
                max: 28,
                divisions: 27,
                label: widget.selectedDayOfMonth.toString(),
                onChanged: (double value) {
                  widget.onSelectedDayOfMonth(value.round());
                },
              ),
            ),
            Center(
              child: Text(
                'Le ${widget.selectedDayOfMonth} de chaque mois',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
