import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ButtonActionWidget extends StatelessWidget {
  final String label;
  final IconData icon;

  const ButtonActionWidget({required this.label, required this.icon, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (this.label == 'Transfert') {
          Get.toNamed('/contactselection');
        } else if (this.label == 'Planifier') {
          Get.toNamed('/contactplanification');
        } else if (this.label == 'Multi Transfert') {
          Get.toNamed('/contactselection-multiple');
        }else if (this.label == 'Depot') {
          Get.toNamed('/depot-scan');
        }else if (this.label == 'Retrait') {
          Get.toNamed('/qrretrait');
        }else if (this.label == 'Déplafonnement') {
          Get.toNamed('/deplafonnement');
        }
      },
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.blue),
          ),
          Text(label, style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}
