import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:getx_wave_app/app/data/models/planification_model.dart';
import 'package:getx_wave_app/app/data/models/transaction_model.dart';
import 'package:getx_wave_app/app/data/models/user_model.dart';
import 'package:getx_wave_app/app/data/models/wallet_model.dart';
import 'package:getx_wave_app/app/enums/enums.dart';
import 'package:path/path.dart';
class ClientService {
  FirebaseFirestore firebaseFirestore;

  ClientService(this.firebaseFirestore);

  Future<TransactionModel> transferAmount({
    required String senderPhone,
    required String receiverPhone,
    required double amount,
  }) async {
    try {
      final senderQuery = await firebaseFirestore
          .collection('users')
          .where('telephone', isEqualTo: senderPhone)
          .get();

      final receiverQuery = await firebaseFirestore
          .collection('users')
          .where('telephone', isEqualTo: receiverPhone)
          .get();

      if (senderQuery.docs.isEmpty || receiverQuery.docs.isEmpty) {
        throw Exception('Sender or receiver not found');
      }

      final senderDoc = senderQuery.docs.first;
      final receiverDoc = receiverQuery.docs.first;

      final sender = UserModel.fromJson(senderDoc.data());
      final receiver = UserModel.fromJson(receiverDoc.data());

      // Step 2: Validate the transaction
      if (sender.wallet == null || sender.wallet!.solde < amount) {
        throw Exception('Insufficient balance in sender\'s wallet');
      }

      // Step 3: Update sender and receiver wallets
      final updatedSenderWallet = WalletModel(
        id: sender.wallet!.id,
        plafond: sender.wallet!.plafond,
        solde: sender.wallet!.solde - amount,
        createdAt: sender.wallet!.createdAt,
        updatedAt: DateTime.now(),
      );

      final updatedReceiverWallet = WalletModel(
        id: receiver.wallet!.id,
        plafond: receiver.wallet!.plafond,
        solde: receiver.wallet!.solde + amount,
        createdAt: receiver.wallet!.createdAt,
        updatedAt: DateTime.now(),
      );

      // Step 4: Create transaction
      final transaction = TransactionModel(
        id: firebaseFirestore
            .collection('transactions')
            .doc()
            .id,
        createdAt: DateTime.now(),
        montantEnvoye: amount,
        montantRecus: amount,
        typeTransaction: TypeTransactionEnum.TRANSFERT,
        etatTransaction: EtatTransactionEnum.EFFECTUER,
        senderId: senderDoc.id.hashCode,
        receiverId: receiverDoc.id.hashCode,
      );

      // Step 5: Update Firestore
      final batch = firebaseFirestore.batch();

      // Update sender wallet and add transaction
      batch.update(
        senderDoc.reference,
        {
          'wallet': updatedSenderWallet.toJson(),
          'transactions': FieldValue.arrayUnion([transaction.toJson()])
        },
      );

      // Update receiver wallet and add transaction
      batch.update(
        receiverDoc.reference,
        {
          'wallet': updatedReceiverWallet.toJson(),
          'transactions': FieldValue.arrayUnion([transaction.toJson()])
        },
      );

      await batch.commit();

      print('Transaction completed successfully');

      // Step 6: Return the transaction
      return transaction;
    } catch (e) {
      print('Error during transaction: $e');
      rethrow;
    }
  }

  Future<List<TransactionModel>> transferMultipleAmounts({
    required String senderPhone,
    required List<UserModel> receivers,
    required double montant
  }) async {
    final List<TransactionModel> completedTransactions = [];

    try {
      for (var receiver in receivers) {
        final receiverPhone = receiver.telephone as String;
        final transaction = await transferAmount(
          senderPhone: senderPhone,
          receiverPhone: receiverPhone,
          amount: montant,
        );

        completedTransactions.add(transaction);
      }

      print('All transactions completed successfully');
      return completedTransactions;
    } catch (e) {
      print('Error during multiple transactions: $e');
      rethrow;
    }
  }

  Future<PlanificationModel> addPlanificationToUser(
      String userId, Map<String, dynamic> schedulingData) async {
    try {
      // Add additional fields if missing
      final enrichedData = {
        ...schedulingData,
        'id': firebaseFirestore.collection('users').doc(userId).collection('planifications').doc().id,
        'createdAt': DateTime.now().toIso8601String(),
        if (schedulingData['timeOfDay'] is String)
          'timeOfDay': schedulingData['timeOfDay']
        else if (schedulingData['timeOfDay'] != null)
          'timeOfDay': schedulingData['timeOfDay'] as TimeOfDay,
      };

      // Create PlanificationModel from JSON
      final planification = PlanificationModel.fromJson(enrichedData);

      // Reference the user's document
      final userDocRef = firebaseFirestore.collection('users').doc(userId);

      // Update the user's planifications list
      await userDocRef.update({
        'planifications': FieldValue.arrayUnion([planification.toJson()]),
      });

      print('Planification added successfully');
      return planification;
    } catch (e) {
      print('Error adding planification: $e');
      throw Exception('Failed to add planification');
    }
  }



}
