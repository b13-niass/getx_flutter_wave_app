import 'package:flutter/material.dart';
import 'package:getx_wave_app/app/data/providers/state_management_provider.dart';

class AmountFieldWidget extends StatefulWidget {
  final Function(double) onAmountChanged;
  const AmountFieldWidget({
    required this.onAmountChanged,
    super.key
  });
  @override
  State<AmountFieldWidget> createState() => _AmountFieldWidgetState();
}

class _AmountFieldWidgetState extends State<AmountFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'Montant à envoyer (FCFA)',
        prefixIcon: Icon(Icons.attach_money),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty || double.parse(value) > GlobalState.solde.value) {
          return 'Veuillez entrer un montant valid';
        }
        return null;
      },
      onChanged: (value) {
        widget.onAmountChanged(double.parse(value));
      },
    );
  }
}
