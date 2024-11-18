// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../favoris_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FavorisModel _$FavorisModelFromJson(Map<String, dynamic> json) => FavorisModel(
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
      nom: json['nom'] as String?,
      prenom: json['prenom'] as String?,
      telephone: json['telephone'] as String?,
      userId: (json['userId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$FavorisModelToJson(FavorisModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt?.toIso8601String(),
      'deleted': instance.deleted,
      'deletedAt': instance.deletedAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'nom': instance.nom,
      'prenom': instance.prenom,
      'telephone': instance.telephone,
      'userId': instance.userId,
    };
