import 'package:json_annotation/json_annotation.dart';
import 'package:mobile_app/ui/common-widgets/selection-page.dart';

part 'currency-model.g.dart';

@JsonSerializable()
class CurrencyModel implements SelectionModel {
  int id;
  final String currency;
  final String name;
  final double commission;
  final int withdraw;
  final int deposit;
  final double withdrawCommission;
  final double depositCommission;
  final bool isFlat;

  String get value => name;

  CurrencyModel({
    this.id,
    this.currency,
    this.name,
    this.commission,
    this.withdraw,
    this.deposit,
    this.withdrawCommission,
    this.depositCommission,
    this.isFlat,
  });

  factory CurrencyModel.fromJson(Map<String, dynamic> json) => _$CurrencyModelFromJson(json);
  Map<String, dynamic> toJson() => _$CurrencyModelToJson(this);

  String getCurrencySign() {
    if (currency == "USD") {
      return "\$";
    }
    if (currency == "EUR") {
      return "€";
    }
    if (currency == "BTC") {
      return "₿";
    }
    if (currency == "AED") {
      return "د.إ";
    }
    if (currency == "ETH") {
      return "Ξ";
    }
    return "";
  }
}
