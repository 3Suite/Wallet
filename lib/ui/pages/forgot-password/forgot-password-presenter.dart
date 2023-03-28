import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/network/http-client/http-client-fabric.dart';
import 'package:mobile_app/network/http-client/ihttp-client.dart';
import 'package:mobile_app/ui/pages/authorization/sign-in/sign-in.dart';
import 'package:mobile_app/ui/pages/forgot-password/forgot-password.dart';
import 'package:mobile_app/ui/extensions/custom-widget-extension.dart';

class ForgotPasswordPresenter {
  ForgotPasswordPageState controller;

  IHttpClient client = HttpClientFactory.getHttpClient();

  Future<void> restorePassword(String email, BuildContext context) async {
    if (email.isEmpty) {
      return Future.error("Please, fill email");
    }

    controller.showActivityIndicator();

    Map<String, dynamic> data = {
      "em": email,
    };

    var rawJson = await client.postRawResponse("oauth/recovery", data);

    if (rawJson == null) {
      return Future.error("Internal error. Please contact support");
    }

    var serverJson = json.decode(rawJson);

    var status;
    try {
      status = serverJson["st"].toString();
    } catch (error) {
      Future.error(error);
    }

    if (status == "1") {
      controller.hideActivityIndicator();
      controller.showErrorAlert(
        title: "",
        message: "The letter was successfully sent to the email - $email",
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            isDefaultAction: true,
            child: Text("Ok"),
            onPressed: () {
              controller.goBack();
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SignInPage(),
                  ),
                  (route) => false);
            },
          ),
        ],
      );
    } else if (status == "44") {
      Future.error("Email is not in datebase");
    } else {
      return Future.error("Internal error. Please contact support");
    }
  }
}
