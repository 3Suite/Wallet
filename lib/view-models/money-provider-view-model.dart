import 'package:mobile_app/models/provider-model.dart';

class MoneyProviderViewModel {
  String name;
  String image;

  final ProviderModel provider;

  MoneyProviderViewModel({this.provider}) {
    name = provider.name;

    switch (name.toLowerCase()) {
      case "visa card":
        image = 'images/visa.png';
        break;

      case "paypal":
        image = 'images/paypal.png';
        break;

      case "bank transfer":
        image = 'images/bank.png';
        break;

      default:
        image = 'images/transfer-icon.png';
        break;
    }
  }
}
