import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/common-presenters/cards-presenter.dart';
import 'package:mobile_app/constants/models-storage.dart';
import 'package:mobile_app/localization/localization-constants.dart';
import 'package:mobile_app/models/card-model.dart';
import 'package:mobile_app/models/country-model.dart';
import 'package:mobile_app/models/pagination-model.dart';
import 'package:mobile_app/models/response-pagination-model.dart';
import 'package:mobile_app/models/transaction-model.dart';
import 'package:mobile_app/models/user-model.dart';
import 'package:mobile_app/network/http-client/http-client-fabric.dart';
import 'package:mobile_app/network/http-client/ihttp-client.dart';
import 'package:mobile_app/ui/pages/pdf/pdf-preview.dart';
import 'package:mobile_app/view-models/transaction-view-model.dart';
import 'package:mobile_app/ui/pages/dashboard/transactions-filter.dart';
import 'package:mobile_app/ui/extensions/custom-widget-extension.dart';
import 'package:path_provider/path_provider.dart';

import 'dashboard-page.dart';

class DashboardPresenter extends CardsPresenter {
  List<TransactionViewModel> transactions = new List();

  final TransactionsFilter _filter = TransactionsFilter();
  PaginationModel _pagination;
  ResponsePaginationModel _response;
  Set<int> _transactionsIds = Set();

  DashboardPageState controller;

  bool _isInProgress = false;

  IHttpClient client = HttpClientFactory.getHttpClient();

  Future<void> fetchCountries() async {
    if (ModelsStorage.countries.isNotEmpty) {
      return;
    }
    var rawJson = await client.getRawResponse("setting/countries");
    var serverJson = json.decode(rawJson);
    List<CountryModel> countries = new List<CountryModel>();

    try {
      for (int i = 0; i < serverJson.length; i++) {
        countries.add(CountryModel.fromJson(serverJson[i]));
      }
    } catch (error) {
      return Future.error(error);
    }

    ModelsStorage.countries = countries;
  }

  Future<void> fetchUser() async {
    var rawJson = await client.getRawResponse("profile/read");
    var serverJson = json.decode(rawJson);
    UserModel user = UserModel();
    try {
      user = UserModel.fromJson(serverJson);
    } catch (error) {
      return Future.error(error);
    }
    ModelsStorage.user = user;
  }

  Future<void> loadTransactions(CardModel card) async {
    if (_filter.walletFromId != card.id) {
      _filter.walletFromId = card.id;

      _pagination = PaginationModel.withFilter(filter: _filter);
      _response = null;

      transactions.clear();
      _transactionsIds.clear();
    } else {
      if (_isInProgress) {
        return;
      }
      _isInProgress = true;

      if (_response != null) {
        if (_response.page >= _response.totalPages) {
          return;
        }
      }
      _pagination.page += 1;
    }

    Map<String, dynamic> data = _pagination.toJson();
    String rawJson = await client.postRawResponse("/transfer/page", data);
    dynamic serverJson = json.decode(rawJson);

    _response = ResponsePaginationModel.fromJson(serverJson);
    if (_response == null) {
      _isInProgress = false;
      return;
    }

    try {
      for (int i = 0; i < _response.data.length; ++i) {
        var transaction = TransactionModel.fromJson(_response.data[i]);
        if (_transactionsIds.add(transaction.id)) {
          transactions.add(
            TransactionViewModel(
              transaction: transaction,
              card: card,
            ),
          );
        }
      }
    } catch (e) {
      print(e);
    }
    _pagination.page = _response.page;
    _isInProgress = false;
  }

  double getTotalBalance(DateTime transactionDate) {
    double finalBalance = 0;
    transactions.where((t) => t.transactionDate == transactionDate).forEach((t) => finalBalance += t.balance);
    return finalBalance;
  }

  Future<void> getPdf(BuildContext context) async {
    if (transactions.length == 0) {
      return Future.error("There are no transactions on this page");
    }
    controller.showActivityIndicator();
    _pagination.type = 2;
    Map<String, dynamic> data = _pagination.toJson();
    var rawJson = await client.postRawResponse("/transfer/page", data);
    var serverJson = json.decode(rawJson);
    var base64Value;
    try {
      base64Value = serverJson["body"];
    } catch (error) {
      controller.hideActivityIndicator();
      return Future.error(error);
    }
    var bytes = base64.decode(base64Value);
    Directory directory = await getApplicationDocumentsDirectory();
    File file = File("${directory.path}/" + DateTime.now().millisecondsSinceEpoch.toString() + ".pdf");
    file.writeAsBytes(bytes);
    controller.hideActivityIndicator();
    controller.showErrorAlert(
      title: "",
      message: getTranslated(context, "file-saved"),
      actions: <CupertinoDialogAction>[
        CupertinoDialogAction(
          isDefaultAction: true,
          child: Text("Ok"),
          onPressed: () {
            controller.goBack();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PDFPreviewPage(pdfFile: file),
              ),
            );
          },
        ),
      ],
    );
  }
}
