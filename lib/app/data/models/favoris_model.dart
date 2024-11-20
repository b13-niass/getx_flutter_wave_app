import 'package:json_annotation/json_annotation.dart';

part 'generate/favoris_model.g.dart';

@JsonSerializable()
class FavorisModel {
  // Fields
  final String? id;
  final DateTime? createdAt;
  final DateTime? deletedAt;
  final DateTime? updatedAt;
  final String? nom;
  final String? prenom;
  final String? telephone;

  // Relationships
  final int? userId;

  // Constructor
  FavorisModel({
    required this.id,
    this.createdAt,
    this.deletedAt,
    this.updatedAt,
    this.nom,
    this.prenom,
    this.telephone,
    this.userId,
  });

  // JSON Serialization
  factory FavorisModel.fromJson(Map<String, dynamic> json) => _$FavorisModelFromJson(json);
  Map<String, dynamic> toJson() => _$FavorisModelToJson(this);
}
