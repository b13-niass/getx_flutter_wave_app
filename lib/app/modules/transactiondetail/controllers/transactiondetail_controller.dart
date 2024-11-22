import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_wave_app/app/data/models/transaction_model.dart';
import 'package:getx_wave_app/app/data/providers/state_management_provider.dart';
import 'package:getx_wave_app/app/data/services/client_service.dart';
import 'package:getx_wave_app/app/enums/enums.dart';

class TransactiondetailController extends GetxController {
  TransactionModel? transaction;
  final ClientService clientService = Get.find<ClientService>();
  @override
  void onInit() {
    super.onInit();
    final Map<String, dynamic> args = Get.arguments;
    transaction = args['transaction'] as TransactionModel;
  }

  bool showCancelButton(TransactionModel? transaction) {
    print(transaction?.createdAt);
    if (transaction == null) return false;

    final status = transaction.etatTransaction?.name;
    final type = transaction.typeTransaction?.name;
    if (status != 'EFFECTUER') return false;

    if (transaction.createdAt != null) {
      final now = DateTime.now();
      final difference = now.difference(transaction.createdAt!).inMinutes;
      print(difference);
      return difference < 30;
    }
    return false;
  }

  void cancelTransaction(String idTransaction) async{

    if(idTransaction.isNotEmpty){
      Get.snackbar(
        'Annulation',
        'Annulation de la transaction....',
        snackPosition: SnackPosition.BOTTOM,
      );

      TransactionModel transactionModel = await clientService.cancelTransaction(transactionId: idTransaction);
      if(transactionModel != null){
        Get.snackbar(
          'Annulation',
          'Transaction annulée avec succès',
          snackPosition: SnackPosition.BOTTOM,
        );

        final transactionIndex =
        GlobalState.transactions.indexWhere((transaction) => transaction.id == idTransaction);

        // Vérifier si la transaction existe
        if (transactionIndex == -1) {
          print('Transaction not found.');
          return null; // Retourne null si la transaction n'est pas trouvée
        }

        // Mettre à jour l'état de la transaction
        GlobalState.transactions[transactionIndex].etatTransaction = EtatTransactionEnum.ANNULER;
        GlobalState.solde.value += transactionModel.montantEnvoye;
        Get.toNamed("/home");
      }else{
        Get.snackbar(
          'Annulation',
          'La transaction à échoué',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red
        );
      }
    }


    Get.back();
  }

}
