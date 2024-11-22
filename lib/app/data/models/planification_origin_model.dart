import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:getx_wave_app/app/enums/enums.dart';

part 'generate/planification_origin_model.g.dart';

@JsonSerializable()
class PlanificationOriginModel {
  final String? id;
  final DateTime? createdAt;
  final DateTime? deletedAt;
  final DateTime? updatedAt;
  final int? dayOfMonth;
  final List<String>? daysOfWeek; // Updated to List<String>
  final double montant;
  final RecurrenceType? recurrenceType;
  final String? timeOfDay;
  final int? receiverId;
  final int? senderId;

  PlanificationOriginModel({
    this.id,
    this.createdAt,
    this.deletedAt,
    this.updatedAt,
    this.dayOfMonth,
    this.daysOfWeek, // Updated
    required this.montant,
    this.recurrenceType,
    this.timeOfDay,
    this.receiverId,
    this.senderId,
  });

  // Factory constructor for JSON deserialization
  factory PlanificationOriginModel.fromJson(Map<String, dynamic> json) =>
      _$PlanificationOriginModelFromJson(json);

  // Method for JSON serialization
  Map<String, dynamic> toJson() => _$PlanificationOriginModelToJson(this);

  // Helper method to parse DateTime from various formats
  static DateTime? _parseDate(dynamic date) {
    if (date == null) return null;
    if (date is Timestamp) return date.toDate();
    if (date is String) return DateTime.tryParse(date);
    return null; // Unsupported format
  }
}
