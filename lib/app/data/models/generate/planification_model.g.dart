// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../planification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************


PlanificationModel _$PlanificationModelFromJson(Map<String, dynamic> json) =>
    PlanificationModel(
      id: json['id'] as String?,
      createdAt: PlanificationModel._parseDate(json['createdAt']),
      deletedAt: PlanificationModel._parseDate(json['deletedAt']),
      updatedAt: PlanificationModel._parseDate(json['updatedAt']),
      dayOfMonth: json['dayOfMonth'] as int?,
      daysOfWeek: json['daysOfWeek'] as String?,
      montant: (json['montant'] as num).toDouble(),
      recurrenceType:
      $enumDecodeNullable(_$RecurrenceTypeEnumMap, json['recurrenceType']),
      timeOfDay: json['timeOfDay'] as String?,
      receiverId: json['receiverId'] as int?,
      senderId: json['senderId'] as int?,
    );

Map<String, dynamic> _$PlanificationModelToJson(PlanificationModel instance) =>
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
