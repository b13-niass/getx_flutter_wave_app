import 'package:json_annotation/json_annotation.dart';
import 'package:getx_wave_app/app/enums/enums.dart';

part 'generate/transaction_model.g.dart';

@JsonSerializable()
class TransactionModel {
  // Fields
  final String? id;
  final DateTime? createdAt;
  final DateTime? deletedAt;
  final DateTime? updatedAt;
  EtatTransactionEnum? etatTransaction;
  final double montantEnvoye;
  final double montantRecus;
  final TypeTransactionEnum? typeTransaction;

  // Relationships
  final int? fraisId;
  final int? receiverId;
  final int? senderId;

  // Constructor
  TransactionModel({
    this.id,
    this.createdAt,
    this.deletedAt,
    this.updatedAt,
    this.etatTransaction,
    required this.montantEnvoye,
    required this.montantRecus,
    this.typeTransaction,
    this.fraisId,
    this.receiverId,
    this.senderId,
  });

  // JSON Serialization
  factory TransactionModel.fromJson(Map<String, dynamic> json) => _$TransactionModelFromJson(json);
  Map<String, dynamic> toJson() => _$TransactionModelToJson(this);
}
