// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../planification_origin_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlanificationOriginModel _$PlanificationOriginModelFromJson(
    Map<String, dynamic> json) =>
    PlanificationOriginModel(
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
      dayOfMonth: (json['dayOfMonth'] as num?)?.toInt(),
      daysOfWeek: (json['daysOfWeek'] as List<dynamic>?)?.map((e) => e as String).toList(),
      montant: (json['montant'] as num).toDouble(),
      recurrenceType:
      $enumDecodeNullable(_$RecurrenceTypeEnumMap, json['recurrenceType']),
      timeOfDay: json['timeOfDay'] as String?,
      receiverId: (json['receiverId'] as num?)?.toInt(),
      senderId: (json['senderId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PlanificationOriginModelToJson(
    PlanificationOriginModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt?.toIso8601String(),
      'deletedAt': instance.deletedAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'dayOfMonth': instance.dayOfMonth,
      'daysOfWeek': instance.daysOfWeek,
      'montant': instance.montant,
      'recurrenceType': _$RecurrenceTypeEnumMap[instance.recurrenceType],
      'timeOfDay': instance.timeOfDay,
      'receiverId': instance.receiverId,
      'senderId': instance.senderId,
    };

const _$RecurrenceTypeEnumMap = {
  RecurrenceType.DAILY: 'DAILY',
  RecurrenceType.WEEKLY: 'WEEKLY',
  RecurrenceType.MONTHLY: 'MONTHLY',
};
