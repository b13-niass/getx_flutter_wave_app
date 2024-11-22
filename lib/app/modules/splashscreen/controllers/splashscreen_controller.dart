import 'package:get/get.dart';
import 'package:getx_wave_app/app/data/models/user_model.dart';
import 'package:getx_wave_app/app/data/services/multi_auth_service.dart';
import 'package:getx_wave_app/app/data/services/security/token_storage.dart';

class SplashscreenController extends GetxController {
  final RxBool isLoading = true.obs;
  final RxBool isAuthenticated = false.obs;
  final AuthService _authService = Get.find<AuthService>();

  @override
  void onInit() {
    super.onInit();
    navigateBasedOnToken();
  }


  Future<void> navigateBasedOnToken() async {
      isLoading.value = true;
    final userData = await TokenStorage.getObject('user');
      isAuthenticated.value = userData != null;
    if (isAuthenticated.value) {
      final retrievedUser = UserModel.fromJson(userData!);
      // UserModel? userModel = await _authService.getUserByPhoneNumber(retrievedUser.telephone!);
      // await TokenStorage.deleteObject('user');
      // await TokenStorage.saveObject('user', userModel!.toJson());
      Get.toNamed("/home");
    } else {
      Get.toNamed("/login");
    }
      isLoading.value = false;
  }
}
