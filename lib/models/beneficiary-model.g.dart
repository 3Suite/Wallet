// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'beneficiary-model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BeneficiaryModel _$BeneficiaryModelFromJson(Map<String, dynamic> json) {
  return BeneficiaryModel(
    id: json['id'] as int ?? 0,
    iban: json['iban'] as String ?? '',
    firstName: json['firstName'] as String ?? '',
    countryId: json['countryId'] as int,
    swiftCode: json['swiftCode'] as String ?? '',
    favourite: json['favourite'] as bool ?? false,
  );
}

Map<String, dynamic> _$BeneficiaryModelToJson(BeneficiaryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'iban': instance.iban,
      'firstName': instance.firstName,
      'countryId': instance.countryId,
      'swiftCode': instance.swiftCode,
      'favourite': instance.favourite,
    };
