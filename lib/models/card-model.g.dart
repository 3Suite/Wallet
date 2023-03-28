// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card-model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CardModel _$CardModelFromJson(Map<String, dynamic> json) {
  return CardModel(
    json['id'] as int,
    json['currencyId'] as int,
    json['address'] as String,
    (json['balance'] as num)?.toDouble(),
    (json['blockBalance'] as num)?.toDouble(),
    json['isClosed'] as bool,
    json['name'] as String,
  );
}

Map<String, dynamic> _$CardModelToJson(CardModel instance) => <String, dynamic>{
      'id': instance.id,
      'currencyId': instance.currencyId,
      'address': instance.address,
      'balance': instance.balance,
      'blockBalance': instance.blockBalance,
      'isClosed': instance.isClosed,
      'name': instance.name,
    };
