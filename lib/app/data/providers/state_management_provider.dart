import 'package:get/get.dart';
import 'package:getx_wave_app/app/data/models/planification_model.dart';
import 'package:getx_wave_app/app/data/models/transaction_model.dart';
import 'package:getx_wave_app/app/data/models/user_model.dart';
class GlobalState {
  static Rxn<UserModel> user = Rxn<UserModel>();
  static Rx<double>  solde = 0.0.obs;
  static RxList<TransactionModel> transactions = <TransactionModel>[].obs;
  static RxList<PlanificationModel> planifications = <PlanificationModel>[].obs;
  static Rx<String> qrCode = ''.obs;
}