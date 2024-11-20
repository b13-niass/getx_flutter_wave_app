import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:getx_wave_app/app/data/services/client_service.dart';

import '../controllers/transfertcontact_controller.dart';

class TransfertcontactBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ClientService>(() => ClientService(
        Get.find<FirebaseFirestore>()
    ));
    Get.lazyPut<TransfertcontactController>(
      () => TransfertcontactController(),
    );
  }
}
