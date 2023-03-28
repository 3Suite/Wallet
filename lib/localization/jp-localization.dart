import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class JPLocalization {
  final Locale locale;

  JPLocalization(this.locale);

  static JPLocalization of(BuildContext context) {
    return Localizations.of<JPLocalization>(context, JPLocalization);
  }

  Map<String, String> _localizedValues;

  Future load() async {
    String jsonStringValues = await rootBundle.loadString('localizations/${locale.languageCode}.json');

    Map<String, dynamic> mappedJson = json.decode(jsonStringValues);

    _localizedValues = mappedJson.map((key, value) => MapEntry(key, value.toString()));
  }

  String getTranslatedValue(String key) {
    if (_localizedValues.containsKey(key)) {
      return _localizedValues[key];
    }
    return "key not found";
  }

  static const LocalizationsDelegate<JPLocalization> delegate = _JPLocalizationDelegate();
}

class _JPLocalizationDelegate extends LocalizationsDelegate<JPLocalization> {
  const _JPLocalizationDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'es'].contains(locale.languageCode);
  }

  @override
  Future<JPLocalization> load(Locale locale) async {
    JPLocalization jpLocalization = new JPLocalization(locale);
    await jpLocalization.load();
    return jpLocalization;
  }

  @override
  bool shouldReload(LocalizationsDelegate<JPLocalization> old) => false;
}
