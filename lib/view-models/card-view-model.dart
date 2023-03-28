import 'package:intl/intl.dart';
import 'package:mobile_app/constants/models-storage.dart';
import 'package:mobile_app/models/card-model.dart';
import 'package:mobile_app/models/currency-model.dart';

class CardViewModel {
  String number;
  String currency;
  String balance;
  String ownerName;

  final CardModel card;

  CardViewModel.withCard({this.card}) {
    number = card.address;

    CurrencyModel currencyModel = ModelsStorage.currencies.firstWhere(
      (element) {
        return element.id == card.currencyId;
      },
      orElse: () {
        print("Currency with id ${card.currencyId} not found");
        balance = "";
        currency = "";
        return null;
      },
    );

    if (currencyModel == null) {
      return;
    }
    currency = currencyModel.currency;

    balance = NumberFormat.currency(symbol: currencyModel.getCurrencySign()).format(card.balance);

    ownerName = ModelsStorage.user.getName();
    if (ownerName.isEmpty) {
      ownerName = ModelsStorage.user.email;
    }
  }
}
