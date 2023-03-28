// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'provider-model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProviderModel _$ProviderModelFromJson(Map<String, dynamic> json) {
  return ProviderModel(
    id: json['id'] as int,
    name: json['name'] as String ?? '',
    fee: (json['fee'] as num)?.toDouble() ?? 0,
    terms: json['terms'] as String ?? '',
    type: json['type'] as String ?? 'CARD',
  );
}

Map<String, dynamic> _$ProviderModelToJson(ProviderModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'fee': instance.fee,
      'terms': instance.terms,
      'type': instance.type,
    };
