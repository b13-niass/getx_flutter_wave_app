import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../controllers/qr_code_generator_controller.dart';

class QRCodeGeneratorView extends GetView<QrCodeGeneratorController> {
  const QRCodeGeneratorView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Code Generator'),
        backgroundColor: const Color(0xFF4749D5),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Scan the QR Code below to get the phone number:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Obx(() {
              if (controller.phoneNumber.value.isEmpty) {
                return const Text(
                  'No phone number provided.',
                  style: TextStyle(fontSize: 14, color: Colors.red),
                );
              }
              return QrImageView(
                data: controller.phoneNumber.value,
                version: QrVersions.auto,
                size: 200.0,
                backgroundColor: Colors.white,
              );
            }),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final scannedData = controller.phoneNumber.value;
                if (scannedData.isNotEmpty) {
                  await controller.handleQrScan(scannedData);
                } else {
                  Get.snackbar(
                    'Error',
                    'No QR code data to scan',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4749D5),
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Simulate Scan and Search',
                style: TextStyle(color: Colors.white),
              ),
            ),
            // Obx(() {
            //   if (controller.isLoading.value) {
            //     return const Padding(
            //       padding: EdgeInsets.all(16.0),
            //       child: CircularProgressIndicator(),
            //     );
            //   }
            //   if (controller.scannedUser.value != null) {
            //     final user = controller.scannedUser.value!;
            //     return Text(
            //       'Found User: ${user.nom} ${user.prenom}',
            //       style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            //     );
            //   }
            //   return const SizedBox();
            // }),
          ],
        ),
      ),
    );
  }
}
