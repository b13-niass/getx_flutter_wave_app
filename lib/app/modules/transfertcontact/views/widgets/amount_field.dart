import 'package:flutter/material.dart';
import 'package:getx_wave_app/core/theme/colors.dart';
import 'package:getx_wave_app/core/theme/text_styles.dart';

class AmountField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final bool isEnabled;
  final String? Function(String?)? validator;

  const AmountField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.isEnabled,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      enabled: isEnabled,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: AppTextStyles.body.copyWith(color: AppColors.primaryLight),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.primaryLight.withOpacity(0.3)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.primaryLight.withOpacity(0.3)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primaryLight, width: 2),
        ),
      ),
      keyboardType: TextInputType.number,
      validator: validator,
      style: AppTextStyles.body,
    );
  }
}
