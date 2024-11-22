import 'package:json_annotation/json_annotation.dart';

enum RecurrenceType { DAILY, WEEKLY, MONTHLY }

enum EtatCompteEnum {
  @JsonValue('ACTIF')
  ACTIF,
  @JsonValue('INACTIF')
  INACTIF,
}

enum ChannelEnum {
  @JsonValue('SMS')
  SMS,
  @JsonValue('MAIL')
  MAIL,
}

enum RoleEnum {
  @JsonValue('CLIENT')
  CLIENT,
  @JsonValue('DISTRIBUTEUR')
  DISTRIBUTEUR,
  @JsonValue('ADMIN')
  ADMIN,
}

enum EtatTransactionEnum {
  @JsonValue('EFFECTUER')
  EFFECTUER,
  @JsonValue('ANNULER')
  ANNULER,
  @JsonValue('RETRAIT')
  RETIRER,
}

enum TypeTransactionEnum {
  @JsonValue('TRANSFERT')
  TRANSFERT,
  @JsonValue('DEPOT')
  DEPOT,
  @JsonValue('RETRAIT')
  RETRAIT,
  @JsonValue('PAIEMENT')
  PAIEMENT,
}