import 'package:getx_wave_app/app/data/models/favoris_model.dart';
import 'package:getx_wave_app/app/data/models/planification_model.dart';
import 'package:getx_wave_app/app/data/models/transaction_model.dart';
import 'package:getx_wave_app/app/data/models/wallet_model.dart';
import 'package:getx_wave_app/app/enums/enums.dart';
import 'package:json_annotation/json_annotation.dart';

part 'generate/user_model.g.dart';

@JsonSerializable()
class UserModel {
  // Fields
  final int id;
  final DateTime? createdAt;
  final bool deleted;
  final DateTime? deletedAt;
  final DateTime? updatedAt;
  final String? adresse;
  final ChannelEnum? channel;
  final String? cni;
  final String? codeVerification;
  final DateTime? dateNaissance;
  final String? email;
  final EtatCompteEnum? etatCompte;
  final String? fileCni;
  final int nbrConnection;
  final String? nom;
  final String? password;
  final String? prenom;
  final RoleEnum? role;
  final String? telephone;

  // Relationships
  final int? paysId;
  final List<FavorisModel>? favoris;
  final WalletModel? wallet;
  final List<TransactionModel>? sentTransactions;
  final List<TransactionModel>? receivedTransactions;
  final List<PlanificationModel>? sentPlanifications;
  final List<PlanificationModel>? receivedPlanifications;

  // Constructor
  UserModel({
    required this.id,
    this.createdAt,
    required this.deleted,
    this.deletedAt,
    this.updatedAt,
    this.adresse,
    this.channel,
    this.cni,
    this.codeVerification,
    this.dateNaissance,
    this.email,
    this.etatCompte,
    this.fileCni,
    required this.nbrConnection,
    this.nom,
    this.password,
    this.prenom,
    this.role,
    this.telephone,
    this.paysId,
    this.favoris,
    this.wallet,
    this.sentTransactions,
    this.receivedTransactions,
    this.sentPlanifications,
    this.receivedPlanifications,
  });

  // JSON Serialization
  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
