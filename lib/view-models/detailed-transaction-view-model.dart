import 'package:intl/intl.dart';
import 'package:mobile_app/constants/models-storage.dart';
import 'package:mobile_app/models/transaction-model.dart';

class DetailedTransactionViewModel {
  String dateAndTime;
  String id;
  String type;
  String beneficieryName;
  String accountIban;
  String amount;
  String status;
  String filePath;

  final TransactionModel transaction;
  DetailedTransactionViewModel.withTransaction(this.transaction) {
    dateAndTime =
        "${DateFormat.MMMd().format(transaction.createdAt)}, ${DateFormat.Hm().format(transaction.createdAt)}";
    id = "${transaction.id}";
    type = transaction.type;
    beneficieryName = transaction.addressTo;
    var currency = ModelsStorage.currencies.firstWhere(
      (c) => c.id == transaction.currencyId,
      orElse: null,
    );
    if (currency != null) {
      amount = NumberFormat.currency(symbol: currency.getCurrencySign())
          .format(transaction.amount);
    }
    status = transaction.status;
    filePath = transaction.filePath;

    // -ER- Unknown field. Not used
    accountIban = "GB29 NWBK 6016 1331 9268 19";
  }
}
