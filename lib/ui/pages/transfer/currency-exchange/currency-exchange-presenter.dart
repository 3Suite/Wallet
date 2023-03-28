import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:mobile_app/network/http-client/http-client-fabric.dart';
import 'package:mobile_app/network/http-client/ihttp-client.dart';
import 'package:mobile_app/ui/pages/transfer/currency-exchange/currency-exchange.dart';

import 'package:mobile_app/ui/extensions/custom-widget-extension.dart';

class CurrencyExchangePresenter {
  CurrencyExchangeState controller;

  IHttpClient client = HttpClientFactory.getHttpClient();

  Future<void> processTransfer(
    int walletFromId,
    int walletToId,
    int amount,
  ) async {
    controller.showActivityIndicator();

    Map<String, dynamic> data = {
      "walletFromId": walletFromId,
      "walletToId": walletToId,
      "amount": amount,
    };

    var rawJson = await client.postRawResponse("transfer/exchange", data);

    if (rawJson == null) {
      controller.hideActivityIndicator();
      return Future.error("Internal error. Please contact support");
    }

    var serverJson = json.decode(rawJson);

    var success = false;
    try {
      success = serverJson["success"];
    } catch (error) {
      controller.hideActivityIndicator();
      return Future.error(error);
    }

    if (success) {
      controller.transferFinishedSuccessfully();
    } else {
      var message = "";
      try {
        message = serverJson["message"];
      } catch (error) {
        controller.hideActivityIndicator();
        return Future.error(error);
      }

      controller.hideActivityIndicator();
      controller.showErrorAlert(
        message: message,
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            isDefaultAction: true,
            child: Text("Ok"),
            onPressed: () {
              controller.goBack();
            },
          ),
        ],
      );
    }
  }

  Future<String> getApproximateAmount(
    int currencyFromId,
    int currencyToId,
    int amount,
  ) async {
    Map<String, dynamic> data = {
      "currencyFromId": currencyFromId,
      "currencyToId": currencyToId,
      "amount": amount,
    };

    var rawJson;
    try {
      rawJson = await client.postRawResponse("transfer/rate", data);
    } catch (error) {
      return Future.error(error);
    }

    if (rawJson == null) {
      return Future.error("Internal error. Please contact support");
    }
    var value = double.parse(rawJson);
    return value.toStringAsFixed(2).toString();
  }
}
