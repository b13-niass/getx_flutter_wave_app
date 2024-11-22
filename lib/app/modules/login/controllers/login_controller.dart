import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:getx_wave_app/app/data/models/user_model.dart';
import 'package:getx_wave_app/app/data/services/multi_auth_service.dart';
import 'package:getx_wave_app/app/data/services/security/token_storage.dart';

class LoginController extends GetxController {
  final AuthService _authService = Get.find<AuthService>();

  final formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();
  final countryCodes = ['+221', '+223'].obs;
  var selectedCountryCode = '+221'.obs;
  String? _verificationId;

  Rx<UserModel?> user = Rx<UserModel?>(null);
  RxBool isLoading = false.obs;

  // @override
  // void onInit() {
  //   user.value = _authService.getCurrentUser();
  //   super.onInit();
  // }

  // Phone number validation logic
  String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Veuillez entrer un numéro de téléphone';
    } else if (value.length < 9) {
      return 'Le numéro de téléphone doit contenir au moins 9 chiffres';
    }
    return null;
  }

  // Handle login action
  void handleLogin(BuildContext context) async{
    if (formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Connexion en cours...'),
          backgroundColor: Colors.green,
        ),
      );
      final user = await _authService.getUserByPhoneNumber("+221${phoneController.text}");

      if(user != null) {
        Get.toNamed("/verification-code", arguments: {"user": user});
      }else{
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Cette utilisateur n'existe pas"),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  // Google Sign In
  Future<void> googleSignIn() async {
    isLoading.value = true;
    final result = await _authService.signInWithGoogle();
    if(result != null){
    final UserModel? userModel = await _authService.getUserByEmail(result.user!.email!);
    await TokenStorage.saveObject('user', userModel!.toJson());
    Get.toNamed("/home", arguments: {"user": userModel});
    isLoading.value = false;
    }else{
      isLoading.value = false;
      Get.snackbar(
        'Erreur',
        "Vous n'avez pas de compte",
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  // Facebook Sign In
  Future<void> facebookSignIn() async {
    isLoading.value = true;
    final result = await _authService.signInWithFacebook();
    // user.value = result?.user;
    isLoading.value = false;
  }
  // Logout
  Future<void> logout() async {
    await _authService.logout();
    user.value = null;
  }
}