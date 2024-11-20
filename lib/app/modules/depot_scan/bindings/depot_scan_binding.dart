import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:getx_wave_app/app/data/services/client_service.dart';
import 'package:getx_wave_app/app/data/services/multi_auth_service.dart';

import '../controllers/depot_scan_controller.dart';

class DepotScanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthService>(() => AuthService(
        Get.find<FirebaseAuth>(),
        Get.find<FirebaseFirestore>()
    ));
    Get.lazyPut<ClientService>(() => ClientService(
        Get.find<FirebaseFirestore>()
    ));
    Get.lazyPut<DepotScanController>(
      () => DepotScanController(),
    );
  }
}
