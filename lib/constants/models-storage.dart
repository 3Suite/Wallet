import 'package:mobile_app/models/card-model.dart';
import 'package:mobile_app/models/country-model.dart';
import 'package:mobile_app/models/currency-model.dart';
import 'package:mobile_app/models/user-model.dart';

class ModelsStorage {
  static List<CurrencyModel> currencies = List();
  static List<CountryModel> countries = List();
  static List<CardModel> cards = List();
  static UserModel user = UserModel();
  static Map<String, String> translations = Map();
}
