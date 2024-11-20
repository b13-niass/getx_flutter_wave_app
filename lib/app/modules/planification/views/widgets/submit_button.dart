import 'package:flutter/material.dart';
import 'package:getx_wave_app/core/theme/colors.dart';

class SubmitButtonWidget extends StatelessWidget {
  final String label;
  final Function() submitForm;
  const SubmitButtonWidget({
    required this.label,
    required this.submitForm,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: submitForm,
      style: ElevatedButton.styleFrom(
          minimumSize: Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          backgroundColor: AppColors.secondary),
      child: Text(
        label,
        style: TextStyle(fontSize: 16, color: Colors.white),
      ),
    );
  }
}
