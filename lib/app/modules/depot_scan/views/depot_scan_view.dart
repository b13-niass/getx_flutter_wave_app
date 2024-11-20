import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:getx_wave_app/core/theme/colors.dart';
import '../controllers/depot_scan_controller.dart';

class DepotScanView extends GetView<DepotScanController> {
  const DepotScanView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scanner QR Code'),
        backgroundColor: AppColors.primaryLight,
        actions: [
          IconButton(
            icon: ValueListenableBuilder(
              valueListenable: controller.cameraController.torchState,
              builder: (context, state, child) {
                return Icon(
                  state == TorchState.off ? Icons.flash_off : Icons.flash_on,
                  color: state == TorchState.off ? Colors.grey : Colors.yellow,
                );
              },
            ),
            onPressed: controller.toggleTorch,
          ),
          IconButton(
            icon: ValueListenableBuilder(
              valueListenable: controller.cameraController.cameraFacingState,
              builder: (context, state, child) {
                return Icon(
                  state == CameraFacing.front
                      ? Icons.camera_front
                      : Icons.camera_rear,
                );
              },
            ),
            onPressed: controller.switchCamera,
          ),
        ],
      ),
      body: Stack(
        children: [
          MobileScanner(
            controller: controller.cameraController,
            onDetect: controller.foundBarcode,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.only(bottom: 40),
              child: const Text(
                'Placez le QR code dans le cadre',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  backgroundColor: Colors.black54,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
