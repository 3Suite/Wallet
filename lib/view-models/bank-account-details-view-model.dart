import 'package:intl/intl.dart';
import 'package:mobile_app/constants/models-storage.dart';
import 'package:mobile_app/models/bank-model.dart';
import 'package:mobile_app/models/card-model.dart';
import 'package:mobile_app/models/currency-model.dart';

class BankAccountDetailsViewModel {
  String bankName;
  String bankSwift;
  String bankAddress;

  String holderName;
  String iban;
  String formattedAmount;
  String refNumber;

  final double amount;
  final CardModel selectedCard;

  BankAccountDetailsViewModel.withAmount({this.amount, this.selectedCard}) {
    CurrencyModel currency = ModelsStorage.currencies.firstWhere((element) => element.id == selectedCard.currencyId);
    if (ModelsStorage.user.bankDetails != null) {
      BankModel bank = ModelsStorage.user.bankDetails.firstWhere((element) => element.currency == currency.currency, orElse: () => null);
      if (bank != null) {
        bankName = bank.bankName;
        bankSwift = bank.bankSwift;
        bankAddress = bank.bankAddress;

        if (bank.receiverName.isNotEmpty) {
          holderName = bank.receiverName;
          refNumber = ModelsStorage.user.refNumber;
        }

        if (bank.receiverAccount.isNotEmpty) {
          iban = bank.receiverAccount;
        }
      }
    } else {
      bankName = ""; // "Abu Dhabi Islamic Bank";
      bankSwift = ""; // "ABDIAEAD";
      bankAddress = ""; // "Sh Zayed Road Dubai";
    }

    holderName = ModelsStorage.user.firstName + " " + ModelsStorage.user.secondName;
    iban = selectedCard.address;
    refNumber = "";
    formattedAmount = NumberFormat.currency(symbol: selectedCard.getCurrencySign()).format(amount);
  }
}
