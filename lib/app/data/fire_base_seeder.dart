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

    // Generate 10 users
    for (int i = 1; i <= 10; i++) {
      // Create a wallet for the user
      WalletModel wallet = WalletModel(
        id: null,
        createdAt: DateTime.now(),
        deletedAt: null,
        updatedAt: DateTime.now(),
        plafond: 10000 + random.nextDouble() * 5000,
        solde: 5000 + random.nextDouble() * 5000,
        userId: i,
      );

      // Generate transactions for the user
      List<TransactionModel> transactions = List<TransactionModel>.generate(
        5,
            (index) => TransactionModel(
          id: null,
          createdAt: DateTime.now(),
          deletedAt: null,
          updatedAt: DateTime.now(),
          etatTransaction: EtatTransactionEnum.EFFECTUER,
          montantEnvoye: 1000 + random.nextDouble() * 4000,
          montantRecus: 950 + random.nextDouble() * 3950,
          typeTransaction: random.nextBool()
              ? TypeTransactionEnum.TRANSFERT
              : TypeTransactionEnum.DEPOT,
          fraisId: index,
          receiverId: random.nextInt(10),
          senderId: i,
        ),
      );

      // Generate a user
      UserModel user = UserModel(
        id: null,
        createdAt: DateTime.now(),
        deletedAt: null,
        updatedAt: DateTime.now(),
        adresse: 'Adresse ${i + 1}',
        channel: random.nextBool() ? ChannelEnum.SMS : ChannelEnum.MAIL,
        cni: 'CNI-${i + 1}',
        codeVerification: 'VERIF-${i + 1}',
        dateNaissance: DateTime(1990 + i, random.nextInt(12) + 1, random.nextInt(28) + 1),
        email: 'user${i + 1}@example.com',
        etatCompte: random.nextBool() ? EtatCompteEnum.ACTIF : EtatCompteEnum.INACTIF,
        fileCni: 'fileCni-${i + 1}.jpg',
        nbrConnection: random.nextInt(100),
        nom: 'Nom ${i + 1}',
        password: 'password${i + 1}',
        prenom: 'Prenom ${i + 1}',
        role: RoleEnum.CLIENT,
        telephone: '+22177123${1000 + i}',
        paysId: i,
        favoris: null,
        wallet: wallet,
        transactions: transactions,
        planifications: null,
      );

      // Convert to Firestore-compatible map
      Map<String, dynamic> userData = {
        ...user.toJson(),
        'wallet': user.wallet?.toJson(),
        'transactions': user.transactions?.map((tx) => tx.toJson()).toList(),
      };

      await _firestore.collection('users').add(userData);
    }
  }
}
