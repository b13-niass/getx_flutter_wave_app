// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../wallet_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WalletModel _$WalletModelFromJson(Map<String, dynamic> json) => WalletModel(
      id: (json['id'] as num).toInt(),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      deleted: json['deleted'] as bool,
      deletedAt: json['deletedAt'] == null
          ? null
          : DateTime.parse(json['deletedAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      plafond: (json['plafond'] as num).toDouble(),
      solde: (json['solde'] as num).toDouble(),
      userId: (json['userId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$WalletModelToJson(WalletModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt?.toIso8601String(),
      'deleted': instance.deleted,
      'deletedAt': instance.deletedAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'plafond': instance.plafond,
      'solde': instance.solde,
      'userId': instance.userId,
    };
