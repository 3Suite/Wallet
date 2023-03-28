import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/localization/localization-constants.dart';
import 'package:mobile_app/network/http-client/http-client-fabric.dart';
import 'package:mobile_app/network/http-client/ihttp-client.dart';
import 'package:mobile_app/themes/themes.dart';
import 'package:mobile_app/ui/common-widgets/custom-button.dart';
import 'package:mobile_app/ui/pages/authorization/code-entering/code-entering.dart';
import 'package:mobile_app/ui/pages/authorization/code-entering/icode-entering-presenter.dart';
import 'package:mobile_app/ui/extensions/custom-widget-extension.dart';

class SendFundsCodeEnteringPresenter extends ICodeEnteringPresenter {
  CodeEnteringPageState controller;

  IHttpClient client = HttpClientFactory.getHttpClient();
  int entityId;

  void setLogId(int logId) {
    entityId = logId;
  }

  Future<void> sendCode(BuildContext context, String code) async {
    if (code.isEmpty) {
      return Future.error("Please, fill code");
    }

    controller.showActivityIndicator();

    var client = HttpClientFactory.getHttpClient();

    Map<String, dynamic> data = {
      "code": code,
      "logId": entityId,
    };

    try {
      await client.postRawResponse("transfer/confirm", data);
    } catch (error) {
      controller.hideActivityIndicator();
      return Future.error(error);
    }

    controller.hideActivityIndicator();
    controller.goBack();
  }

  String getButtonName(BuildContext context) {
    return getTranslated(context, "confirm");
  }

  Widget getAdditionalButton(BuildContext context) {
    return CustomButton(
        text: getTranslated(context, "cancel"),
        style: CustomThemes.authorizationTheme.textTheme.subtitle1,
        tappedCallback: () {
          controller.goBack();
        });
  }
}
