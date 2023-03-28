import 'package:json_annotation/json_annotation.dart';

part 'transaction-model.g.dart';

@JsonSerializable()
class TransactionModel {
  int id;
  String type;
  int walletFromId;
  String addressTo;
  String direction;
  int currencyId;
  double amount;
  double exchangeRate;
  double commission;
  DateTime createdAt;
  String status;
  String filePath;

  TransactionModel({
    this.id,
    this.type,
    this.walletFromId,
    this.addressTo,
    this.direction,
    this.currencyId,
    this.amount,
    this.exchangeRate,
    this.commission,
    this.createdAt,
    this.status,
    this.filePath,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      _$TransactionModelFromJson(json);
  Map<String, dynamic> toJson() => _$TransactionModelToJson(this);
}
