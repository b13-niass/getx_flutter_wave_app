import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:getx_wave_app/app/data/models/user_model.dart';
import 'package:getx_wave_app/app/data/models/wallet_model.dart';
import 'package:getx_wave_app/app/data/models/transaction_model.dart';
import 'package:getx_wave_app/app/enums/enums.dart';

class FirebaseSeeder {
  final FirebaseFirestore _firestore;

  FirebaseSeeder(this._firestore);

  Future<void> seedDatabase() async {
    final Random random = Random();

    // List to store generated user IDs
    List<String> userIds = [];

    // Step 1: Create all users and store their IDs
    for (int i = 1; i <= 4; i++) {
      final userId = _firestore.collection('users').doc().id;
      userIds.add(userId);

      final WalletModel wallet = WalletModel(
        id: _firestore.collection('wallets').doc().id,
        createdAt: DateTime.now(),
        deletedAt: null,
        updatedAt: DateTime.now(),
        plafond: 10000 + random.nextDouble() * 5000,
        solde: 5000 + random.nextDouble() * 5000,
        userId: userId.hashCode, // Reference the Firebase-generated userId
      );

      // Create the user without transactions
      final UserModel user = UserModel(
        id: userId,
        createdAt: DateTime.now(),
        deletedAt: null,
        updatedAt: DateTime.now(),
        adresse: 'Adresse $i',
        channel: random.nextBool() ? ChannelEnum.SMS : ChannelEnum.MAIL,
        cni: 'CNI-$i',
        codeVerification: 'VERIF-$i',
        dateNaissance: DateTime(1990 + i, random.nextInt(12) + 1, random.nextInt(28) + 1),
        email: 'user$i@example.com',
        etatCompte: random.nextBool() ? EtatCompteEnum.ACTIF : EtatCompteEnum.INACTIF,
        fileCni: 'fileCni-$i.jpg',
        nbrConnection: random.nextInt(100),
        nom: 'Nom $i',
        password: 'password$i',
        prenom: 'Prenom $i',
        role: RoleEnum.CLIENT,
        telephone: '+22177123${1000 + i}',
        paysId: i,
        favoris: null,
        wallet: wallet,
        transactions: [],
        planifications: null,
      );

      final Map<String, dynamic> userData = {
        ...user.toJson(),
        'wallet': wallet.toJson(),
      };

      // Add user to Firestore
      await _firestore.collection('users').doc(userId).set(userData);
    }

    // Step 2: Create transactions for each user
    for (int i = 0; i < userIds.length; i++) {
      final senderId = userIds[i];
      final senderDoc = _firestore.collection('users').doc(senderId);

      List<TransactionModel> transactions = [];

      for (int j = 0; j < 2; j++) {
        final transactionId = _firestore.collection('transactions').doc().id;

        // Select a random receiver (other than the sender)
        final receiverIndex = (i + 1) % userIds.length;
        final receiverId = userIds[receiverIndex];

        final transaction = TransactionModel(
          id: transactionId,
          createdAt: DateTime.now(),
          deletedAt: null,
          updatedAt: DateTime.now(),
          etatTransaction: EtatTransactionEnum.EFFECTUER,
          montantEnvoye: 1000 + random.nextDouble() * 4000,
          montantRecus: 950 + random.nextDouble() * 3950,
          typeTransaction: random.nextBool()
              ? TypeTransactionEnum.TRANSFERT
              : TypeTransactionEnum.DEPOT,
          fraisId: random.nextInt(100),
          receiverId: receiverId.hashCode, // Reference the Firebase-generated receiverId
          senderId: senderId.hashCode, // Reference the Firebase-generated senderId
        );

        transactions.add(transaction);

        // Update receiver with the transaction
        final receiverDoc = _firestore.collection('users').doc(receiverId);
        final receiverSnapshot = await receiverDoc.get();

        if (receiverSnapshot.exists) {
          final receiverData = receiverSnapshot.data()!;
          final updatedReceiverTransactions = [
            ...?receiverData['transactions']?.map((e) => TransactionModel.fromJson(e).toJson()),
            transaction.toJson(),
          ];

          await receiverDoc.update({'transactions': updatedReceiverTransactions});
        }
      }

      // Update sender with the transactions
      await senderDoc.update({'transactions': transactions.map((tx) => tx.toJson()).toList()});
    }

    print('Database seeding completed!');
  }
}
