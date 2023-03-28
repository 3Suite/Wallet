import 'dart:convert';

import 'package:mobile_app/constants/models-storage.dart';
import 'package:mobile_app/models/card-model.dart';
import 'package:mobile_app/models/currency-model.dart';
import 'package:mobile_app/network/http-client/http-client-fabric.dart';
import 'package:mobile_app/view-models/card-view-model.dart';

abstract class CardsPresenter {
  List<CardViewModel> cardViewModels = List();
  List<CardModel> cards = List();

  Future<void> loadCards() async {
    try {
      await loadCurrencies();

      var http = HttpClientFactory.getHttpClient();
      var rawJson = await http.getRawResponse("/wallet/all");
      var serverJson = json.decode(rawJson);

      cards.clear();
      cardViewModels.clear();
      for (int i = 0; i < serverJson.length; ++i) {
        var card = CardModel.fromJson(serverJson[i]);
        cards.add(card);
        cardViewModels.add(CardViewModel.withCard(card: card));
      }
    } catch (error) {
      print(error);
    }

    ModelsStorage.cards = cards;
  }

  Future<void> loadCurrencies() async {
    if (ModelsStorage.currencies.length > 0) {
      return;
    }

    var http = HttpClientFactory.getHttpClient();

    var rawJson = await http.getRawResponse("/wallet/currency/all");
    var serverJson = json.decode(rawJson);

    var currencies = new List<CurrencyModel>();
    try {
      for (int i = 0; i < serverJson.length; ++i) {
        var currency = CurrencyModel.fromJson(serverJson[i]);
        currencies.add(currency);
      }
      ModelsStorage.currencies = currencies;
    } catch (e) {
      print(e);
    }
  }
}
