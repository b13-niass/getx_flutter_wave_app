import 'package:flutter/material.dart';

class SummaryRowWidget extends StatefulWidget {
  final String title;
  final String value;
  const SummaryRowWidget({
    required this.title,
    required this.value,
    super.key
  });

  @override
  State<SummaryRowWidget> createState() => _SummaryRowWidgetState();
}

class _SummaryRowWidgetState extends State<SummaryRowWidget> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.title,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 16,
            ),
          ),
          Text(
            widget.value,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
