import 'package:get/get.dart';

import '../controllers/contactselection_controller.dart';

class ContactselectionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ContactSelectionController>(
      () => ContactSelectionController(),
    );
  }
}
