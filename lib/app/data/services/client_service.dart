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

  Future<PlanificationModel> addPlanificationToUser(String userId,
      Map<String, dynamic> schedulingData) async {
    try {
      // Add additional fields if missing
      final enrichedData = {
        ...schedulingData,
        'id': firebaseFirestore
            .collection('users')
            .doc(userId)
            .collection('planifications')
            .doc()
            .id,
        'createdAt': DateTime.now().toIso8601String(),
        if (schedulingData['timeOfDay'] is String)
          'timeOfDay': schedulingData['timeOfDay']
        else
          if (schedulingData['timeOfDay'] != null)
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

  Future<TransactionModel> depotAmount({
    required String senderPhone,
    required String receiverPhone,
    required double amount,
  }) async {
    print(senderPhone);
    print(receiverPhone);
    print(amount);
    try {
      // Fetch sender and receiver data from Firestore
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

      // Validate the transaction
      if (sender.wallet == null || sender.wallet!.solde < amount) {
        throw Exception('Insufficient balance in sender\'s wallet');
      }

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

      // Create a DEPOT transaction
      final transaction = TransactionModel(
        id: firebaseFirestore
            .collection('transactions')
            .doc()
            .id,
        createdAt: DateTime.now(),
        montantEnvoye: amount,
        montantRecus: amount,
        typeTransaction: TypeTransactionEnum.DEPOT,
        etatTransaction: EtatTransactionEnum.EFFECTUER,
        senderId: senderDoc.id.hashCode,
        receiverId: receiverDoc.id.hashCode,
      );

      // Update Firestore using a batch
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

      print('DEPOT transaction completed successfully');

      return transaction;
    } catch (e) {
      print('Error during DEPOT transaction: $e');
      rethrow;
    }
  }

  Future<TransactionModel> withdrawAmount({
    required String senderPhone,
    required String receiverPhone,
    required double amount,
  }) async {
    print(senderPhone);
    print(receiverPhone);
    print(amount);
    try {
      // Fetch sender and receiver data from Firestore
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

      // Validate the transaction
      if (receiver.wallet == null || receiver.wallet!.solde < amount) {
        throw Exception('Insufficient balance in receiver\'s wallet');
      }

      // Update the wallets
      final updatedReceiverWallet = WalletModel(
        id: receiver.wallet!.id,
        plafond: receiver.wallet!.plafond,
        solde: receiver.wallet!.solde - amount,
        createdAt: receiver.wallet!.createdAt,
        updatedAt: DateTime.now(),
      );

      final updatedSenderWallet = WalletModel(
        id: sender.wallet!.id,
        plafond: sender.wallet!.plafond,
        solde: sender.wallet!.solde + amount,
        createdAt: sender.wallet!.createdAt,
        updatedAt: DateTime.now(),
      );

      // Create a RETRAIT transaction
      final transaction = TransactionModel(
        id: firebaseFirestore
            .collection('transactions')
            .doc()
            .id,
        createdAt: DateTime.now(),
        montantEnvoye: amount,
        montantRecus: amount,
        typeTransaction: TypeTransactionEnum.RETRAIT,
        etatTransaction: EtatTransactionEnum.EFFECTUER,
        senderId: senderDoc.id.hashCode,
        receiverId: receiverDoc.id.hashCode,
      );

      final batch = firebaseFirestore.batch();

      batch.update(
        receiverDoc.reference,
        {
          'wallet': updatedReceiverWallet.toJson(),
          'transactions': FieldValue.arrayUnion([transaction.toJson()])
        },
      );

      // Update sender wallet and add transaction
      batch.update(
        senderDoc.reference,
        {
          'wallet': updatedSenderWallet.toJson(),
          'transactions': FieldValue.arrayUnion([transaction.toJson()])
        },
      );

      await batch.commit();

      print('RETRAIT transaction completed successfully');

      return transaction;
    } catch (e) {
      print('Error during RETRAIT transaction: $e');
      rethrow;
    }
  }


  Future<TransactionModel> cancelTransaction(
      {required String transactionId}) async {
    try {
      final usersQuery = await firebaseFirestore.collection('users').get();

      if (usersQuery.docs.isEmpty) {
        throw Exception('No users found.');
      }

      DocumentSnapshot? senderDoc;
      DocumentSnapshot? receiverDoc;
      TransactionModel? transactionToCancel;

      for (final userDoc in usersQuery.docs) {
        final userData = userDoc.data() as Map<String, dynamic>;
        final transactions = (userData['transactions'] as List<dynamic>?)
            ?.map((e) => TransactionModel.fromJson(e as Map<String, dynamic>))
            .toList();

        if (transactions != null) {
          for (final transaction in transactions) {
            if (transaction.id == transactionId) {
              if (transactionToCancel == null) {
                transactionToCancel = transaction;
                senderDoc = userDoc;
              } else {
                receiverDoc = userDoc;
              }
            }
          }
        }
      }

      if (transactionToCancel == null || senderDoc == null ||
          receiverDoc == null) {
        throw Exception('Transaction or related users not found.');
      }

      // Check if the transaction is already canceled
      if (transactionToCancel.etatTransaction == EtatTransactionEnum.ANNULER) {
        throw Exception('Transaction is already canceled.');
      }

      // Check if the transaction is already "RETIRER"
      if (transactionToCancel.etatTransaction == EtatTransactionEnum.RETIRER) {
        throw Exception(
            'Transaction cannot be canceled as it is already "RETIRER".');
      }

      final senderData = senderDoc.data() as Map<String, dynamic>;
      final receiverData = receiverDoc.data() as Map<String, dynamic>;

      // Update wallet balances
      final senderWallet = WalletModel.fromJson(senderData['wallet']);
      final receiverWallet = WalletModel.fromJson(receiverData['wallet']);

      senderWallet.solde += transactionToCancel.montantEnvoye;
      receiverWallet.solde -= transactionToCancel.montantRecus;

      if (receiverWallet.solde < 0) {
        throw Exception('Insufficient balance in receiver wallet to cancel.');
      }

      // Update the transaction's status to "ANNULER"
      transactionToCancel.etatTransaction = EtatTransactionEnum.ANNULER;

      // Batch update for sender and receiver documents
      final batch = firebaseFirestore.batch();

      // Update sender's wallet and transaction
      final updatedSenderTransactions = (senderData['transactions'] as List<
          dynamic>?)
          ?.map((e) {
        final transaction = TransactionModel.fromJson(
            e as Map<String, dynamic>);
        return transaction.id == transactionId
            ? transactionToCancel!.toJson()
            : e;
      })
          .toList();

      batch.update(
        senderDoc.reference,
        {
          'wallet': senderWallet.toJson(),
          'transactions': updatedSenderTransactions,
        },
      );

      // Update receiver's wallet and transaction
      final updatedReceiverTransactions = (receiverData['transactions'] as List<
          dynamic>?)
          ?.map((e) {
        final transaction = TransactionModel.fromJson(
            e as Map<String, dynamic>);
        return transaction.id == transactionId
            ? transactionToCancel!.toJson()
            : e;
      })
          .toList();

      batch.update(
        receiverDoc.reference,
        {
          'wallet': receiverWallet.toJson(),
          'transactions': updatedReceiverTransactions,
        },
      );

      // Commit the batch updates
      await batch.commit();

      print('Transaction canceled successfully.');

      // Return the updated transaction
      return transactionToCancel;
    } catch (e) {
      print('Error canceling transaction: $e');
      throw Exception('Failed to cancel the transaction.');
    }
  }

  Future<WalletModel> updatePlafond({
    required String telephone,
    required double newPlafond,
  }) async {
    try {
      final userQuery = await FirebaseFirestore.instance
          .collection('users')
          .where('telephone', isEqualTo: telephone)
          .limit(1) // Limit to one result
          .get();

      if (userQuery.docs.isEmpty) {
        throw Exception('User not found');
      }

      final userDoc = userQuery.docs.first;
      final userData = userDoc.data();

      if (userData['wallet'] == null) {
        throw Exception('User wallet not found');
      }

      final WalletModel currentWallet = WalletModel.fromJson(userData['wallet']);
      final WalletModel updatedWallet = WalletModel(
        id: currentWallet.id,
        plafond: newPlafond, // Update plafond
        solde: currentWallet.solde, // Keep the current solde
        createdAt: currentWallet.createdAt,
        updatedAt: DateTime.now(), // Update timestamp
        userId: currentWallet.userId,
      );

      await FirebaseFirestore.instance
          .collection('users')
          .doc(userDoc.id) // Use the document ID
          .update({
        'wallet': updatedWallet.toJson(),
      });

      print('Plafond updated successfully for user with telephone $telephone');

      return updatedWallet;
    } catch (e) {
      print('Error updating plafond: $e');
      throw Exception('Failed to update plafond');
    }
  }

  Future<bool> isTransactionSumExceedingPlafond({required String telephone}) async {
    try {
      // Query user by telephone
      final userQuery = await firebaseFirestore
          .collection('users')
          .where('telephone', isEqualTo: telephone)
          .limit(1)
          .get();

      // Check if user exists
      if (userQuery.docs.isEmpty) {
        throw Exception('User not found');
      }

      final userDoc = userQuery.docs.first;
      final userData = userDoc.data();

      if (userData == null || userData['wallet'] == null || userData['transactions'] == null) {
        throw Exception('User wallet or transactions not found');
      }

      // Parse wallet and transactions
      final WalletModel wallet = WalletModel.fromJson(userData['wallet']);
      final List<dynamic> rawTransactions = userData['transactions'] as List<dynamic>;
      print('Raw Transactions: $rawTransactions');

      final List<TransactionModel> transactions = rawTransactions
          .map((e) => TransactionModel.fromJson(e as Map<String, dynamic>))
          .toList();
      print('Parsed Transactions: $transactions');

      // Calculate totalAmountSent
      final double totalAmountSent = transactions.fold(
        0.0,
            (sum, transaction) {
          print('Transaction montantEnvoye: ${transaction.montantEnvoye}');
          return sum + transaction.montantEnvoye;
        },
      );

      print('Total Amount Sent: $totalAmountSent');
      print('Wallet Plafond: ${wallet.plafond}');

      // Check if totalAmountSent exceeds or equals plafond
      return totalAmountSent >= wallet.plafond;
    } catch (e) {
      print('Error checking transaction sum against plafond: $e');
      throw Exception('Failed to check transaction sum against plafond');
    }
  }


}
