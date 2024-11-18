// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../pays_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaysModel _$PaysModelFromJson(Map<String, dynamic> json) => PaysModel(
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
      indicatif: json['indicatif'] as String?,
      libelle: json['libelle'] as String?,
      users: (json['users'] as List<dynamic>?)
          ?.map((e) => UserModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PaysModelToJson(PaysModel instance) => <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt?.toIso8601String(),
      'deleted': instance.deleted,
      'deletedAt': instance.deletedAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'indicatif': instance.indicatif,
      'libelle': instance.libelle,
      'users': instance.users,
    };
