import 'package:flutter/material.dart';
import 'package:getx_wave_app/app/enums/enums.dart';

class RecurrenceSelectorWidget extends StatefulWidget {
  final RecurrenceType selectedRecurrence;
  final Function(Set<RecurrenceType>) onRecurrenceSelected;

  const RecurrenceSelectorWidget({
    required this.selectedRecurrence,
    required this.onRecurrenceSelected,
    super.key
  });

  @override
  State<RecurrenceSelectorWidget> createState() => _RecurrenceSelectorWidgetState();
}

class _RecurrenceSelectorWidgetState extends State<RecurrenceSelectorWidget> {
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
              'Fréquence d\'envoi',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            SegmentedButton<RecurrenceType>(
              segments: [
                ButtonSegment(
                  value: RecurrenceType.DAILY,
                  label: Text('Quotidien'),
                  icon: Icon(Icons.calendar_today),
                ),
                ButtonSegment(
                  value: RecurrenceType.WEEKLY,
                  label: Text('Hebdomadaire'),
                  icon: Icon(Icons.calendar_view_week),
                ),
                ButtonSegment(
                  value: RecurrenceType.MONTHLY,
                  label: Text('Mensuel'),
                  icon: Icon(Icons.calendar_month),
                ),
              ],
              selected: {widget.selectedRecurrence},
              onSelectionChanged: (Set<RecurrenceType> selection) {
                widget.onRecurrenceSelected(selection);
              },
            ),
          ],
        ),
      ),
    );
  }
}
