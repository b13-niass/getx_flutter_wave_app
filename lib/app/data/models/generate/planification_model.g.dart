// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../planification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlanificationModel _$PlanificationModelFromJson(Map<String, dynamic> json) =>
    PlanificationModel(
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
      dayOfMonth: (json['dayOfMonth'] as num?)?.toInt(),
      daysOfWeek: json['daysOfWeek'] as String?,
      montant: (json['montant'] as num).toDouble(),
      recurrenceType:
          $enumDecodeNullable(_$RecurrenceTypeEnumMap, json['recurrenceType']),
      timeOfDay: json['timeOfDay'] == null
          ? null
          : DateTime.parse(json['timeOfDay'] as String),
      receiverId: (json['receiverId'] as num?)?.toInt(),
      senderId: (json['senderId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PlanificationModelToJson(PlanificationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt?.toIso8601String(),
      'deleted': instance.deleted,
      'deletedAt': instance.deletedAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'dayOfMonth': instance.dayOfMonth,
      'daysOfWeek': instance.daysOfWeek,
      'montant': instance.montant,
      'recurrenceType': _$RecurrenceTypeEnumMap[instance.recurrenceType],
      'timeOfDay': instance.timeOfDay?.toIso8601String(),
      'receiverId': instance.receiverId,
      'senderId': instance.senderId,
    };

const _$RecurrenceTypeEnumMap = {
  RecurrenceType.DAILY: 'DAILY',
  RecurrenceType.WEEKLY: 'WEEKLY',
  RecurrenceType.MONTHLY: 'MONTHLY',
};
