// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../transaction_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionModel _$TransactionModelFromJson(Map<String, dynamic> json) =>
    TransactionModel(
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
      etatTransaction: $enumDecodeNullable(
          _$EtatTransactionEnumEnumMap, json['etatTransaction']),
      montantEnvoye: (json['montantEnvoye'] as num).toDouble(),
      montantRecus: (json['montantRecus'] as num).toDouble(),
      typeTransaction: $enumDecodeNullable(
          _$TypeTransactionEnumEnumMap, json['typeTransaction']),
      fraisId: (json['fraisId'] as num?)?.toInt(),
      receiverId: (json['receiverId'] as num?)?.toInt(),
      senderId: (json['senderId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$TransactionModelToJson(TransactionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt?.toIso8601String(),
      'deletedAt': instance.deletedAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'etatTransaction': _$EtatTransactionEnumEnumMap[instance.etatTransaction],
      'montantEnvoye': instance.montantEnvoye,
      'montantRecus': instance.montantRecus,
      'typeTransaction': _$TypeTransactionEnumEnumMap[instance.typeTransaction],
      'fraisId': instance.fraisId,
      'receiverId': instance.receiverId,
      'senderId': instance.senderId,
    };

const _$EtatTransactionEnumEnumMap = {
  EtatTransactionEnum.EFFECTUER: 'EFFECTUER',
  EtatTransactionEnum.ANNULER: 'ANNULER',
};

const _$TypeTransactionEnumEnumMap = {
  TypeTransactionEnum.TRANSFERT: 'TRANSFERT',
  TypeTransactionEnum.DEPOT: 'DEPOT',
  TypeTransactionEnum.RETRAIT: 'RETRAIT',
  TypeTransactionEnum.PAIEMENT: 'PAIEMENT',
};
