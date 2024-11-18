import 'package:json_annotation/json_annotation.dart';
import 'package:getx_wave_app/app/data/models/user_model.dart';

part 'generate/pays_model.g.dart';

@JsonSerializable()
class PaysModel {
  // Fields
  final int id;
  final DateTime? createdAt;
  final bool deleted;
  final DateTime? deletedAt;
  final DateTime? updatedAt;
  final String? indicatif;
  final String? libelle;

  // Relationships
  final List<UserModel>? users;

  // Constructor
  PaysModel({
    required this.id,
    this.createdAt,
    required this.deleted,
    this.deletedAt,
    this.updatedAt,
    this.indicatif,
    this.libelle,
    this.users,
  });

  // JSON Serialization
  factory PaysModel.fromJson(Map<String, dynamic> json) => _$PaysModelFromJson(json);
  Map<String, dynamic> toJson() => _$PaysModelToJson(this);
}
