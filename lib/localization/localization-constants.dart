import 'package:flutter/material.dart';
import 'package:mobile_app/localization/jp-localization.dart';

String getTranslated(BuildContext context, String key) {
  return JPLocalization.of(context).getTranslatedValue(key);
}