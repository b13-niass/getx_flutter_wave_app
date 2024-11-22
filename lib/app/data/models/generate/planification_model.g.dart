// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../planification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlanificationModel _$PlanificationModelFromJson(Map<String, dynamic> json) =>
    PlanificationModel(
      id: json['id'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : _parseDate(json['createdAt']),
      deletedAt: json['deletedAt'] == null
          ? null
          : _parseDate(json['deletedAt']),
      updatedAt: json['updatedAt'] == null
          ? null
          : _parseDate(json['updatedAt']),
      dayOfMonth: (json['dayOfMonth'] as num?)?.toInt(),
      daysOfWeek: (json['daysOfWeek'] as List<dynamic>?)?.map((e) => e as String).toList(),
      montant: (json['montant'] as num).toDouble(),
      recurrenceType:
      $enumDecodeNullable(_$RecurrenceTypeEnumMap, json['recurrenceType']),
      timeOfDay: json['timeOfDay'] as String?,
      receiverId: (json['receiverId'] as num?)?.toInt(),
      senderId: (json['senderId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PlanificationModelToJson(
    PlanificationModel instance) =>
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

/// Helper function to handle Timestamp and String
DateTime? _parseDate(dynamic value) {
  if (value is Timestamp) {
    return value.toDate();
  } else if (value is String) {
    return DateTime.tryParse(value);
  }
  return null; // Unsupported format
}

const _$RecurrenceTypeEnumMap = {
      RecurrenceType.DAILY: 'DAILY',
      RecurrenceType.WEEKLY: 'WEEKLY',
      RecurrenceType.MONTHLY: 'MONTHLY',
};
