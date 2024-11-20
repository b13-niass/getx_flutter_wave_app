import 'package:flutter/material.dart';

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
        border: const OutlineInputBorder(),
      ),
      validator: validator,
    );
  }
}
