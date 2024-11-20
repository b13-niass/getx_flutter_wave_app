// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: json['id'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      deletedAt: json['deletedAt'] == null
          ? null
          : DateTime.parse(json['deletedAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      adresse: json['adresse'] as String?,
      channel: $enumDecodeNullable(_$ChannelEnumEnumMap, json['channel']),
      cni: json['cni'] as String?,
      codeVerification: json['codeVerification'] as String?,
      dateNaissance: json['dateNaissance'] == null
          ? null
          : DateTime.parse(json['dateNaissance'] as String),
      email: json['email'] as String?,
      etatCompte:
          $enumDecodeNullable(_$EtatCompteEnumEnumMap, json['etatCompte']),
      fileCni: json['fileCni'] as String?,
      nbrConnection: (json['nbrConnection'] as num).toInt(),
      nom: json['nom'] as String?,
      password: json['password'] as String?,
      prenom: json['prenom'] as String?,
      role: $enumDecodeNullable(_$RoleEnumEnumMap, json['role']),
      telephone: json['telephone'] as String?,
      paysId: (json['paysId'] as num?)?.toInt(),
      favoris: (json['favoris'] as List<dynamic>?)
          ?.map((e) => FavorisModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      wallet: json['wallet'] == null
          ? null
          : WalletModel.fromJson(json['wallet'] as Map<String, dynamic>),
      transactions: (json['transactions'] as List<dynamic>?)
          ?.map((e) => TransactionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      planifications: (json['planifications'] as List<dynamic>?)
          ?.map((e) => PlanificationModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt?.toIso8601String(),
      'deletedAt': instance.deletedAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'adresse': instance.adresse,
      'channel': _$ChannelEnumEnumMap[instance.channel],
      'cni': instance.cni,
      'codeVerification': instance.codeVerification,
      'dateNaissance': instance.dateNaissance?.toIso8601String(),
      'email': instance.email,
      'etatCompte': _$EtatCompteEnumEnumMap[instance.etatCompte],
      'fileCni': instance.fileCni,
      'nbrConnection': instance.nbrConnection,
      'nom': instance.nom,
      'password': instance.password,
      'prenom': instance.prenom,
      'role': _$RoleEnumEnumMap[instance.role],
      'telephone': instance.telephone,
      'paysId': instance.paysId,
      'favoris': instance.favoris,
      'wallet': instance.wallet,
      'transactions': instance.transactions,
      'planifications': instance.planifications,
    };

const _$ChannelEnumEnumMap = {
  ChannelEnum.SMS: 'SMS',
  ChannelEnum.MAIL: 'MAIL',
};

const _$EtatCompteEnumEnumMap = {
  EtatCompteEnum.ACTIF: 'ACTIF',
  EtatCompteEnum.INACTIF: 'INACTIF',
};

const _$RoleEnumEnumMap = {
  RoleEnum.CLIENT: 'CLIENT',
  RoleEnum.DISTRIBUTEUR: 'DISTRIBUTEUR',
  RoleEnum.ADMIN: 'ADMIN',
};
