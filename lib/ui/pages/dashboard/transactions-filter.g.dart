// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transactions-filter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionsFilter _$TransactionsFilterFromJson(Map<String, dynamic> json) {
  return TransactionsFilter(
    dateFrom: json['dateFrom'] == null
        ? null
        : DateTime.parse(json['dateFrom'] as String),
    dateTo: json['dateTo'] == null
        ? null
        : DateTime.parse(json['dateTo'] as String),
    walletFromId: json['walletFromId'] as int,
    searchCriteria: json['searchCriteria'] as String,
  );
}

Map<String, dynamic> _$TransactionsFilterToJson(TransactionsFilter instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('dateFrom', instance.dateFrom?.toIso8601String());
  writeNotNull('dateTo', instance.dateTo?.toIso8601String());
  writeNotNull('walletFromId', instance.walletFromId);
  writeNotNull('searchCriteria', instance.searchCriteria);
  return val;
}
