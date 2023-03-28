import 'dart:convert';

import 'package:mobile_app/models/provider-model.dart';
import 'package:mobile_app/network/http-client/http-client-fabric.dart';
import 'package:mobile_app/view-models/money-provider-view-model.dart';

class MoneyProviderPresenter {
  List<MoneyProviderViewModel> providers = new List();

  Future<int> loadProviders() async {
    try {
      var http = HttpClientFactory.getHttpClient();
      String rawJson = await http.getRawResponse("setting/methods");
      dynamic serverJson = json.decode(rawJson);

      providers.clear();

      for (var obj in serverJson) {
        var provider = ProviderModel.fromJson(obj);
        providers.add(MoneyProviderViewModel(provider: provider));
      }
    } catch (error) {
      print(error);
    }

    return providers.length;
  }
}
