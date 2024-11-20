import 'package:get/get.dart';
import 'package:getx_wave_app/app/data/models/planification_model.dart';
import 'package:getx_wave_app/app/data/providers/state_management_provider.dart';
import 'package:getx_wave_app/app/data/services/client_service.dart';

class PlanificationlistController extends GetxController {
  // final RxList<PlanificationModel> planifications = <PlanificationModel>[].obs;
  final RxBool isLoading = false.obs;

  // final ClientService _clientService = Get.find<ClientService>();

  @override
  void onInit() {
    super.onInit();
  }

  void cancelPlanification(PlanificationModel planification) {
    GlobalState.planifications.remove(planification);
    Get.snackbar('Success', 'Planification annulée',
        snackPosition: SnackPosition.BOTTOM);
  }
}
