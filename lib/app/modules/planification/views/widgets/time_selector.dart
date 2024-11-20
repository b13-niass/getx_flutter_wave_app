import 'dart:math';

import 'package:flutter/material.dart';

class TimeSelectorWidget extends StatefulWidget {
  final TimeOfDay selectedTime;
  final Function(TimeOfDay) onTimeSelected;

  const TimeSelectorWidget({required this.onTimeSelected,required this.selectedTime,super.key});

  @override
  State<TimeSelectorWidget> createState() => _TimeSelectorWidgetState();
}

class _TimeSelectorWidgetState extends State<TimeSelectorWidget> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('Heure d\'envoi'),
      trailing: TextButton(
        child: Text(
          '${widget.selectedTime.hour.toString().padLeft(2, '0')}:${widget.selectedTime.minute.toString().padLeft(2, '0')}',
          style: TextStyle(fontSize: 16),
        ),
        onPressed: () async {
          final TimeOfDay? picked = await showTimePicker(
            context: context,
            initialTime: widget.selectedTime,
          );
          if (picked != null) {
            widget.onTimeSelected(picked);
          }
        },
      ),
    );
  }
}
