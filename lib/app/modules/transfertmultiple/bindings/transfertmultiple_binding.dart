import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:getx_wave_app/app/data/services/client_service.dart';

import '../controllers/transfertmultiple_controller.dart';

class TransfertmultipleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ClientService>(() => ClientService(
        Get.find<FirebaseFirestore>()
    ));
    Get.lazyPut<TransfertmultipleController>(
      () => TransfertmultipleController(),
    );
  }
}
