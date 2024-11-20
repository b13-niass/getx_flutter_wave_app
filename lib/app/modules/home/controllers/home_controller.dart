import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_wave_app/app/data/models/user_model.dart';
import 'package:getx_wave_app/app/data/providers/state_management_provider.dart';
import 'package:getx_wave_app/app/data/services/multi_auth_service.dart';
import 'package:getx_wave_app/app/data/services/security/token_storage.dart';
import 'package:getx_wave_app/app/modules/home/views/widgets/contact_sync_service.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxBool isHidden = false.obs;
  final RxDouble solde = 0.0.obs;
  final RxList transactions = [].obs;
  RxString qrCode = ''.obs;
  final ContactSyncService contactSyncService = ContactSyncService();
  final AuthService authService = Get.find<AuthService>();

  @override
  void onInit() {
    super.onInit();
    _initializeContacts();
    initUser();
  }

  Future<void> initUser() async{
    final userData = await TokenStorage.getObject('user');
    bool isAuthenticated = userData != null;
    if (isAuthenticated) {
      GlobalState.user.value = UserModel.fromJson(userData);
      final base64Data = base64Encode(utf8.encode(GlobalState.user.value!.telephone!));
      if (GlobalState.user.value?.transactions != null) {
        GlobalState.transactions.value = GlobalState.user.value!.transactions!
          ..sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
      } else {
        GlobalState.transactions.value = [];
      }
      print(GlobalState.user.value!.planifications);
      if (GlobalState.user.value?.planifications != null) {
        GlobalState.planifications.value = GlobalState.user.value!.planifications!
          ..sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
      } else {
        GlobalState.planifications.value = [];
      }
      GlobalState.solde.value = GlobalState.user.value!.wallet!.solde;
      GlobalState.qrCode.value = base64Data;
    }
  }

  void generateQRCode(String input) {
    final base64Data = base64Encode(utf8.encode(input));
    qrCode.value = base64Data;
    print('Generated Base64 QR Data: $base64Data');
  }

  Future<void> _initializeContacts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool contactsSynced = prefs.getBool('contactsSynced') ?? false;

    if (!contactsSynced) {
      bool? shouldSync = await _showImportContactsDialog();
      if (shouldSync == true) {
        await contactSyncService.syncContactsFromDevice();
        await prefs.setBool('contactsSynced', true);
      }
    }
  }

  Future<bool?> _showImportContactsDialog() async {
    return Get.dialog<bool>(
      AlertDialog(
        title: const Text("Importer les contacts"),
        content: const Text("Voulez-vous importer les contacts de votre répertoire ?"),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: const Text("Non"),
          ),
          TextButton(
            onPressed: () => Get.back(result: true),
            child: const Text("Oui"),
          ),
        ],
      ),
    );
  }

  String formatDateToFrench(String dateString) {
    Intl.defaultLocale = 'fr_FR';
    DateTime dateTime = DateTime.parse(dateString);
    final DateFormat formatter = DateFormat("MMMM d, y 'à' HH:mm", 'fr_FR');
    return formatter.format(dateTime);
  }
}
