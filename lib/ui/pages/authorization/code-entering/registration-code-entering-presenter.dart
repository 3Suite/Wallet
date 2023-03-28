import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile_app/localization/localization-constants.dart';
import 'package:mobile_app/network/http-client/http-client-fabric.dart';
import 'package:mobile_app/network/http-client/ihttp-client.dart';
import 'package:mobile_app/ui/pages/authorization/code-entering/icode-entering-presenter.dart';
import 'package:mobile_app/ui/pages/authorization/sign-in/sign-in.dart';
import 'code-entering.dart';
import 'package:mobile_app/ui/extensions/custom-widget-extension.dart';

class RegistrationCodeEnteringPresenter extends ICodeEnteringPresenter {
  CodeEnteringPageState controller;

  IHttpClient client = HttpClientFactory.getHttpClient();

  Future<void> sendCode(BuildContext context, String code) async {
    if (code.isEmpty) {
      Future.error("Please, fill code");
    }

    controller.showActivityIndicator();

    var client = HttpClientFactory.getHttpClient();
    String rawResponse =
        await client.postRawResponse("oauth/confirm-sms/$code", null);
    dynamic jsonResponse = json.decode(rawResponse);

    int status = jsonResponse["st"];
    if (status == 60) {
      return Future.error("Code is incorrect");
    }
    if (status != 1) {
      return Future.error("Problem with phone confirmation");
    }

    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => SignInPage(),
        ),
        (route) => false);
  }

  String getButtonName(BuildContext context) {
    return getTranslated(context, "sign-up");
  }

  Widget getAdditionalButton(BuildContext context) {
    return Container();
  }
}
