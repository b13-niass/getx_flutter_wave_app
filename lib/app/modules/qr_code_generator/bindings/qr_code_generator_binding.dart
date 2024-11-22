import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:getx_wave_app/app/data/services/multi_auth_service.dart';

import '../controllers/qr_code_generator_controller.dart';

class QrCodeGeneratorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthService>(() => AuthService(
        Get.find<FirebaseAuth>(),
        Get.find<FirebaseFirestore>()
    ));
    Get.lazyPut<QrCodeGeneratorController>(
      () => QrCodeGeneratorController(),
    );
  }
}
