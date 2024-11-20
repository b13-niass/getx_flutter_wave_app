import 'package:flutter/material.dart';

class WeekDaySelectorWidget extends StatefulWidget {
  final List<bool> selectedDays;
  final Function(bool, int) onDaySelected;

  const WeekDaySelectorWidget({
    required this.onDaySelected,
    required this.selectedDays,
    super.key
  });

  @override
  State<WeekDaySelectorWidget> createState() => _WeekDaySelectorWidgetState();
}

class _WeekDaySelectorWidgetState extends State<WeekDaySelectorWidget> {
  @override
  Widget build(BuildContext context) {
    final days = ['Lun', 'Mar', 'Mer', 'Jeu', 'Ven', 'Sam', 'Dim'];
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Jour de la semaine',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Wrap(
              spacing: 8,
              children: List.generate(7, (index) {
                return FilterChip(
                  label: Text(days[index]),
                  selected: widget.selectedDays[index],
                  onSelected: (bool selected) {
                    widget.onDaySelected(selected, index);
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
