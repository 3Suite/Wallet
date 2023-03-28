import 'package:json_annotation/json_annotation.dart';

part 'bank-model.g.dart';

@JsonSerializable()
class BankModel {

  @JsonKey(defaultValue: "")
  String bankName;

  @JsonKey(defaultValue: "")
  String bankSwift;

  @JsonKey(defaultValue: "")
  String bankAddress;

  @JsonKey(defaultValue: "")
  String currency;

  @JsonKey(defaultValue: "")
  String receiverName;

  @JsonKey(defaultValue: "")
  String receiverAccount;

  BankModel({
    this.bankName,
    this.bankSwift,
    this.bankAddress,
    this.currency,
    this.receiverName,
    this.receiverAccount,
  });

  factory BankModel.fromJson(Map<String, dynamic> json) => _$BankModelFromJson(json);
  Map<String, dynamic> toJson() => _$BankModelToJson(this);
}