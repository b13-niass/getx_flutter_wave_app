// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../frais_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FraisModel _$FraisModelFromJson(Map<String, dynamic> json) => FraisModel(
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
      valeur: (json['valeur'] as num).toDouble(),
      transactions: (json['transactions'] as List<dynamic>?)
          ?.map((e) => TransactionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FraisModelToJson(FraisModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt?.toIso8601String(),
      'deleted': instance.deleted,
      'deletedAt': instance.deletedAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'valeur': instance.valeur,
      'transactions': instance.transactions,
    };
