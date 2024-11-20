import 'package:flutter/material.dart';

class TransactionLineWidget extends StatelessWidget {
  final String title;
  final String date;
  final String amount;
  final dynamic transaction;

  const TransactionLineWidget({
    required this.title,
    required this.date,
    required this.amount,
    required this.transaction,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bool isNegative = amount.startsWith('-');
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(color: Colors.indigo)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(date, style: const TextStyle(color: Colors.grey)),
              Text(
                amount,
                style: TextStyle(color: isNegative ? Colors.red : Colors.green),
              ),
            ],
          ),
          const Divider(),
        ],
      ),
    );
  }
}
