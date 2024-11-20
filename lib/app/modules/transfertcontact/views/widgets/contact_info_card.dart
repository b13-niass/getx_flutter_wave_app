import 'package:flutter/material.dart';
import 'package:getx_wave_app/core/theme/text_styles.dart';

class ContactInfoCard extends StatelessWidget {
  final String name;
  final String phoneNumber;

  const ContactInfoCard({
    super.key,
    required this.name,
    required this.phoneNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name, style: AppTextStyles.heading),
            const SizedBox(height: 8),
            Text(phoneNumber, style: AppTextStyles.body),
          ],
        ),
      ),
    );
  }
}
