import 'package:flutter/material.dart';
import 'package:mobile_app/ui/pages/authorization/code-entering/code-entering.dart';

abstract class ICodeEnteringPresenter {
  CodeEnteringPageState controller;
  Future<void> sendCode(BuildContext context, String code);
  String getButtonName(BuildContext context);
  Widget getAdditionalButton(BuildContext context);
}