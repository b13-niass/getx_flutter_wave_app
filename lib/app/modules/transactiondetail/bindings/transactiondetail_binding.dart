import 'package:get/get.dart';

import '../controllers/transactiondetail_controller.dart';

class TransactiondetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TransactiondetailController>(
      () => TransactiondetailController(),
    );
  }
}
