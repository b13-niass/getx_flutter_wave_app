import 'package:flutter/material.dart';
import 'package:getx_wave_app/app/enums/enums.dart';
import 'package:getx_wave_app/app/modules/planification/views/widgets/summary_row.dart';

class SummaryCardWidget extends StatefulWidget {
  final RecurrenceType selectedRecurrence;
  final int selectedDayOfMonth;
  final List<String> Function() getSelectedDaysText;
  final double amount;
  final String telephone;
  final TimeOfDay selectedTime;

  const SummaryCardWidget({
    required this.selectedRecurrence,
    required this.selectedDayOfMonth,
    required this.getSelectedDaysText,
    required this.amount,
    required this.telephone,
    required this.selectedTime,
    super.key
  });

  @override
  State<SummaryCardWidget> createState() => _SummaryCardWidgetState();
}

class _SummaryCardWidgetState extends State<SummaryCardWidget> {
  @override
  Widget build(BuildContext context) {
    String frequencyText = '';
    switch (widget.selectedRecurrence) {
      case RecurrenceType.DAILY:
        frequencyText = 'Tous les jours';
        break;
      case RecurrenceType.WEEKLY:
        final selectedDaysText = widget.getSelectedDaysText();
        frequencyText = 'Chaque semaine le $selectedDaysText';
        break;
      case RecurrenceType.MONTHLY:
        frequencyText = 'Le ${widget.selectedDayOfMonth} de chaque mois';
        break;
    }

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Récapitulatif',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            SummaryRowWidget(title: 'Montant:', value: '${widget.amount} FCFA'),
            SummaryRowWidget(title: 'Destinataire:',value:  widget.telephone),
            SummaryRowWidget(title: 'Fréquence:', value: frequencyText),
            SummaryRowWidget(
                title: 'Heure d\'envoi:',value:  widget.selectedTime.format(context)),
          ],
        ),
      ),
    );
  }
}
