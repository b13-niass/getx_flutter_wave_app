import 'package:flutter/material.dart';
import 'package:getx_wave_app/app/data/models/planification_model.dart';

class PlanificationCard extends StatelessWidget {
  final PlanificationModel planification;
  final VoidCallback onCancel;

  const PlanificationCard({
    Key? key,
    required this.planification,
    required this.onCancel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Montant: ${planification.montant.toStringAsFixed(2)}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            Text('Récurrence: ${planification.recurrenceType}'),
            if (planification.timeOfDay != null)
              Text('Heure: ${planification.timeOfDay}'),
            if (planification.daysOfWeek != null)
              Text('Jours de la semaine: ${planification.daysOfWeek}'),
            if (planification.dayOfMonth != null)
              Text('Jour du mois: ${planification.dayOfMonth}'),
            // Text('Téléphone: ${planification.receiverTelephone}'),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                onPressed: onCancel,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: const Text('Annuler'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
