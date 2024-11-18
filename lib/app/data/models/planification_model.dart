import 'package:json_annotation/json_annotation.dart';
import 'package:getx_wave_app/app/enums/enums.dart';

part 'generate/planification_model.g.dart';

@JsonSerializable()
class PlanificationModel {
  // Fields
  final int id;
  final DateTime? createdAt;
  final bool deleted;
  final DateTime? deletedAt;
  final DateTime? updatedAt;
  final int? dayOfMonth;
  final String? daysOfWeek;
  final double montant;
  final RecurrenceType? recurrenceType;
  final DateTime? timeOfDay;

  // Relationships
  final int? receiverId;
  final int? senderId;

  // Constructor
  PlanificationModel({
    required this.id,
    this.createdAt,
    required this.deleted,
    this.deletedAt,
    this.updatedAt,
    this.dayOfMonth,
    this.daysOfWeek,
    required this.montant,
    this.recurrenceType,
    this.timeOfDay,
    this.receiverId,
    this.senderId,
  });

  // JSON Serialization
  factory PlanificationModel.fromJson(Map<String, dynamic> json) => _$PlanificationModelFromJson(json);
  Map<String, dynamic> toJson() => _$PlanificationModelToJson(this);
}
