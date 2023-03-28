import 'package:json_annotation/json_annotation.dart';

part 'transactions-filter.g.dart';

@JsonSerializable(includeIfNull: false)
class TransactionsFilter {
  DateTime dateFrom;
  DateTime dateTo;
  int walletFromId;
  String searchCriteria;

  TransactionsFilter({
    this.dateFrom,
    this.dateTo,
    this.walletFromId,
    this.searchCriteria,
  });

  factory TransactionsFilter.fromJson(Map<String, dynamic> json) =>
      _$TransactionsFilterFromJson(json);
  Map<String, dynamic> toJson() => _$TransactionsFilterToJson(this);
}
