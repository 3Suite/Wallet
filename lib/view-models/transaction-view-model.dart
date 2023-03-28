import 'dart:core';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_app/constants/models-storage.dart';
import 'package:mobile_app/models/card-model.dart';
import 'package:mobile_app/models/transaction-model.dart';

class TransactionViewModel {
  String image;
  String title;
  String source;
  String time;
  double balance;

  DateTime transactionDate;

  final TransactionModel transaction;
  final CardModel card;

  TransactionViewModel({@required this.transaction, @required this.card}) {
    image = "images/transfer.png";
    title = transaction.addressTo;
    source = card.address;
    time = DateFormat(DateFormat.HOUR24_MINUTE).format(transaction.createdAt);
    balance = transaction.amount;
    if (transaction.direction.toLowerCase() == "out") {
      if (transaction.type.toLowerCase() == "exchange") {
        balance = transaction.amount / transaction.exchangeRate;

        if (title == null) {
          title = transaction.type;
        }
      }
      balance *= -1;
    }
    transactionDate = DateTime(
      transaction.createdAt.year,
      transaction.createdAt.month,
      transaction.createdAt.day,
    );

    if (title == null) {
      title = "Not provided";
    }
    if (source == null) {
      source = "";
    }
    if (balance == null) {
      balance = 0;
    }
  }

  String formatBalance() {
    return TransactionViewModel.FormatBalance(transaction.currencyId, balance);
  }

  // ignore: non_constant_identifier_names
  static String FormatBalance(int currencyId, double balance) {
    var currency = ModelsStorage.currencies.firstWhere(
      (c) => c.id == currencyId,
      orElse: () => null,
    );
    var result = "";
    if (balance < 0) {
      result = "-";
    }
    var strBalance = NumberFormat.currency(symbol: currency.getCurrencySign()).format(balance.abs());
    result += " $strBalance";
    return result;
  }
}
