import 'package:get/get.dart';

import '../controllers/planificationliste_controller.dart';

class PlanificationlisteBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PlanificationlistController>(
      () => PlanificationlistController(),
    );
  }
}
