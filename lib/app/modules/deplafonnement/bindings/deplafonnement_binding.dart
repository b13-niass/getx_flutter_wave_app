import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:getx_wave_app/app/data/services/client_service.dart';

import '../controllers/deplafonnement_controller.dart';

class DeplafonnementBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ClientService>(() => ClientService(
        Get.find<FirebaseFirestore>()
    ));
    Get.lazyPut<DeplafonnementController>(
      () => DeplafonnementController(),
    );
  }
}