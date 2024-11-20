import 'package:get/get.dart';

import '../controllers/contactselection_multiple_controller.dart';

class ContactselectionMultipleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ContactselectionMultipleController>(
      () => ContactselectionMultipleController(),
    );
  }
}
