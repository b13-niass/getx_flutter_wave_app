import 'package:json_annotation/json_annotation.dart';
import 'package:getx_wave_app/app/data/models/transaction_model.dart';

part 'generate/frais_model.g.dart';

@JsonSerializable()
class FraisModel {
  // Fields
  final String? id;
  final DateTime? createdAt;
  final DateTime? deletedAt;
  final DateTime? updatedAt;
  final double valeur;

  // Relationships
  final List<TransactionModel>? transactions;

  // Constructor
  FraisModel({
    required this.id,
    this.createdAt,
    this.deletedAt,
    this.updatedAt,
    required this.valeur,
    this.transactions,
  });

  // JSON Serialization
  factory FraisModel.fromJson(Map<String, dynamic> json) => _$FraisModelFromJson(json);
  Map<String, dynamic> toJson() => _$FraisModelToJson(this);
}
