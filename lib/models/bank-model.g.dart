// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bank-model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BankModel _$BankModelFromJson(Map<String, dynamic> json) {
  return BankModel(
    bankName: json['bankName'] as String ?? '',
    bankSwift: json['bankSwift'] as String ?? '',
    bankAddress: json['bankAddress'] as String ?? '',
    currency: json['currency'] as String ?? '',
    receiverName: json['receiverName'] as String ?? '',
    receiverAccount: json['receiverAccount'] as String ?? '',
  );
}

Map<String, dynamic> _$BankModelToJson(BankModel instance) => <String, dynamic>{
      'bankName': instance.bankName,
      'bankSwift': instance.bankSwift,
      'bankAddress': instance.bankAddress,
      'currency': instance.currency,
      'receiverName': instance.receiverName,
      'receiverAccount': instance.receiverAccount,
    };
