// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'currency-model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CurrencyModel _$CurrencyModelFromJson(Map<String, dynamic> json) {
  return CurrencyModel(
    id: json['id'] as int,
    currency: json['currency'] as String,
    name: json['name'] as String,
    commission: (json['commission'] as num)?.toDouble(),
    withdraw: json['withdraw'] as int,
    deposit: json['deposit'] as int,
    withdrawCommission: (json['withdrawCommission'] as num)?.toDouble(),
    depositCommission: (json['depositCommission'] as num)?.toDouble(),
    isFlat: json['isFlat'] as bool,
  );
}

Map<String, dynamic> _$CurrencyModelToJson(CurrencyModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'currency': instance.currency,
      'name': instance.name,
      'commission': instance.commission,
      'withdraw': instance.withdraw,
      'deposit': instance.deposit,
      'withdrawCommission': instance.withdrawCommission,
      'depositCommission': instance.depositCommission,
      'isFlat': instance.isFlat,
    };
