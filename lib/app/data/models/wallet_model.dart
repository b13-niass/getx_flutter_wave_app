import 'package:json_annotation/json_annotation.dart';

part 'generate/wallet_model.g.dart';

@JsonSerializable()
class WalletModel {
  // Fields
  final int id;
  final DateTime? createdAt;
  final bool deleted;
  final DateTime? deletedAt;
  final DateTime? updatedAt;
  final double plafond;
  final double solde;

  // Relationships
  final int? userId;

  // Constructor
  WalletModel({
    required this.id,
    this.createdAt,
    required this.deleted,
    this.deletedAt,
    this.updatedAt,
    required this.plafond,
    required this.solde,
    this.userId,
  });

  // JSON Serialization
  factory WalletModel.fromJson(Map<String, dynamic> json) => _$WalletModelFromJson(json);
  Map<String, dynamic> toJson() => _$WalletModelToJson(this);
}
