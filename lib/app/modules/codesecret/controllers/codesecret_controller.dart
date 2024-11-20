import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_wave_app/app/data/models/user_model.dart';
import 'package:getx_wave_app/app/data/services/multi_auth_service.dart';
import 'package:getx_wave_app/app/data/services/security/token_storage.dart';

class CodesecretController extends GetxController {
  final AuthService _authService = Get.find<AuthService>();

  final formKey = GlobalKey<FormState>();
  final List<TextEditingController> controllers =
  List.generate(4, (index) => TextEditingController());
  final List<FocusNode> focusNodes = List.generate(4, (index) => FocusNode());
  late UserModel user;
  final isLoading = false.obs;
  late String telephone;

  @override
  void onInit() {
    super.onInit();
    final Map<String, dynamic> args = Get.arguments;
    user = args['user'] as UserModel;
    print('Detail ID: $user');
  }

  void verifyCode() async {
    if (!formKey.currentState!.validate()) {
      Get.snackbar('Erreur', 'Veuillez remplir tous les champs',
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.redAccent);
      return;
    }

    isLoading.value = true;

    try {
      String password = controllers.map((e) => e.text).join();
      final UserModel? response = await _authService.verifyPasswordAndTelephone(user.telephone!, password);

      if (response != null) {
        print(1);
      await TokenStorage.saveObject('user', response.toJson());
        Get.toNamed("/home", arguments: {"user": response});
      } else {
        Get.snackbar('Erreur',"L'email ou le mot de passe est incorrect",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.redAccent);
      }
    } catch (e) {
      Get.snackbar('Erreur', e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent);
    } finally {
      isLoading.value = false;
    }
  }
}
