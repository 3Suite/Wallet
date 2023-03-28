import 'package:json_annotation/json_annotation.dart';
import 'package:mobile_app/constants/models-storage.dart';
import 'package:mobile_app/ui/common-widgets/selection-page.dart';

part 'card-model.g.dart';

@JsonSerializable()
class CardModel implements SelectionModel {
  int id;
  final int currencyId;
  final String address;
  final double balance;
  final double blockBalance;
  final bool isClosed;
  final String name;

  String get value {
    return name == null ? address : name;
  }

  CardModel(
    this.id,
    this.currencyId,
    this.address,
    this.balance,
    this.blockBalance,
    this.isClosed,
    this.name,
  );

  factory CardModel.fromJson(Map<String, dynamic> json) => _$CardModelFromJson(json);
  Map<String, dynamic> toJson() => _$CardModelToJson(this);

  String getCurrencySign() {
    var currency = ModelsStorage.currencies.firstWhere((c) => c.id == currencyId, orElse: () => null);
    if (currency == null) {
      return "USD";
    }
    return currency.getCurrencySign();
  }
}
