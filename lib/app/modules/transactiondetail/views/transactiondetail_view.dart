import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/transactiondetail_controller.dart';

class TransactiondetailView extends GetView<TransactiondetailController> {
  const TransactiondetailView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TransactiondetailView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'TransactiondetailView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
