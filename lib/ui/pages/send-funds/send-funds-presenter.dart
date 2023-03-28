import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile_app/common-presenters/cards-presenter.dart';
import 'package:mobile_app/constants/models-storage.dart';
import 'package:mobile_app/localization/localization-constants.dart';
import 'package:mobile_app/models/beneficiary-model.dart';
import 'package:mobile_app/models/card-model.dart';
import 'package:mobile_app/network/http-client/http-client-fabric.dart';

class SendFundsPresenter extends CardsPresenter {
  CardModel selectedCard;
  BeneficiaryModel selectedBeneficiary;
  String amount = "";
  String transferNote = "";
  String fileBase64Value = "";

  List<BeneficiaryModel> allBeneficiaries = new List<BeneficiaryModel>();
  List<BeneficiaryModel> favorites = new List<BeneficiaryModel>();

  Future<void> loadBeneficiaries() async {
    var http = HttpClientFactory.getHttpClient();
    String response = await http.getRawResponse("beneficiaries/");
    dynamic serverJson = json.decode(response);

    try {
      for (int i = 0; i < serverJson.length; ++i) {
        var beneficiary = BeneficiaryModel.fromJson(serverJson[i]);
        allBeneficiaries.add(beneficiary);
        if (beneficiary.favourite) {
          favorites.add(beneficiary);
        }
      }
    } catch (e) {
      print(e);
    }
    print("A");
    allBeneficiaries.sort((l, r) => l.firstName.compareTo(r.firstName));
    favorites.sort((l, r) => l.firstName.compareTo(r.firstName));
  }

  List<BeneficiaryModel> getBeneficiaries(String searchString) {
    if (searchString.isEmpty) {
      return allBeneficiaries;
    }
    return allBeneficiaries.where((b) => b.firstName.toLowerCase().contains(searchString.toLowerCase())).toList();
  }

  String getCardSign() {
    if (selectedCard == null) {
      return "USD";
    }
    var currency = ModelsStorage.currencies.firstWhere((c) => c.id == selectedCard.currencyId, orElse: () => null);
    if (currency == null) {
      return "USD";
    }
    return currency.currency;
  }

  Future<String> sendFunds(BuildContext context) async {
    if (selectedBeneficiary == null) {
      return Future.error("Need to select beneficiary");
    }

    double doubleAmount = double.tryParse(amount.replaceFirst(",", "."));
    if (doubleAmount == null) {
      return Future.error("Amount format is invalid");
    }

    if (transferNote.isEmpty) {
      return Future.error("Need to fill 'Transfer Note'");
    }

    var client = HttpClientFactory.getHttpClient();
    var result = await client.post(
      "transfer",
      {
        "addressTo": "",
        "amount": doubleAmount,
        "beneficiaryId": selectedBeneficiary.id,
        "currencyId": selectedCard.currencyId,
        "description": transferNote,
        "walletFromId": selectedCard.id,
        "file": fileBase64Value,
      },
    );

    bool success = result["success"];
    String message = result["message"];

    if (success) {
      _resetForm();
      return getTranslated(context, "success");
    }

    return Future.error(message);
  }

  void _resetForm() {
    selectedBeneficiary = null;
    amount = "";
    transferNote = "";
  }
}
