import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:getx_wave_app/app/enums/enums.dart';

part 'generate/planification_model.g.dart';

@JsonSerializable()
class PlanificationModel {
  final String? id;
  final DateTime? createdAt;
  final DateTime? deletedAt;
  final DateTime? updatedAt;
  final int? dayOfMonth;
  final String? daysOfWeek;
  final double montant;
  final RecurrenceType? recurrenceType;
  final String? timeOfDay;
  final int? receiverId;
  final int? senderId;

  PlanificationModel({
    this.id,
    this.createdAt,
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

  // Factory constructor for JSON deserialization
  factory PlanificationModel.fromJson(Map<String, dynamic> json) =>
      _$PlanificationModelFromJson(json);

  // Method for JSON serialization
  Map<String, dynamic> toJson() => _$PlanificationModelToJson(this);

  // Helper method to parse DateTime from various formats
  static DateTime? _parseDate(dynamic date) {
    if (date == null) return null;
    if (date is Timestamp) return date.toDate();
    if (date is String) return DateTime.tryParse(date);
    return null; // Unsupported format
  }
}
