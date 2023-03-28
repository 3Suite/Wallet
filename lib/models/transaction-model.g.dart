// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction-model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionModel _$TransactionModelFromJson(Map<String, dynamic> json) {
  return TransactionModel(
    id: json['id'] as int,
    type: json['type'] as String,
    walletFromId: json['walletFromId'] as int,
    addressTo: json['addressTo'] as String,
    direction: json['direction'] as String,
    currencyId: json['currencyId'] as int,
    amount: (json['amount'] as num)?.toDouble(),
    exchangeRate: (json['exchangeRate'] as num)?.toDouble(),
    commission: (json['commission'] as num)?.toDouble(),
    createdAt: json['createdAt'] == null
        ? null
        : DateTime.parse(json['createdAt'] as String),
    status: json['status'] as String,
    filePath: json['filePath'] as String,
  );
}

Map<String, dynamic> _$TransactionModelToJson(TransactionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'walletFromId': instance.walletFromId,
      'addressTo': instance.addressTo,
      'direction': instance.direction,
      'currencyId': instance.currencyId,
      'amount': instance.amount,
      'exchangeRate': instance.exchangeRate,
      'commission': instance.commission,
      'createdAt': instance.createdAt?.toIso8601String(),
      'status': instance.status,
      'filePath': instance.filePath,
    };
