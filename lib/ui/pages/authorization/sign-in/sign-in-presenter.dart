import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:mobile_app/network/http-client/http-client-fabric.dart';
import 'package:mobile_app/network/http-client/ihttp-client.dart';
import 'package:mobile_app/ui/pages/authorization/sign-in/sign-in.dart';
import 'package:mobile_app/ui/extensions/custom-widget-extension.dart';
import 'package:email_validator/email_validator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInPresenter {
  SignInPageState controller;

  IHttpClient client = HttpClientFactory.getHttpClient();

  Future<void> authorization(String email, String password) async {
    email = email.trim();
    if (email.isEmpty) {
      return Future.error("Please, fill email");
    }

    if (!EmailValidator.validate(email)) {
      return Future.error("Email is not valid");
    }

    if (password.isEmpty) {
      return Future.error("Please, fill password");
    }

    controller.showActivityIndicator();

    var passwordData = "";
    try {
      passwordData = sha512.convert(utf8.encode(password)).toString();
    } catch (error) {
      return Future.error(error);
    }

    Map<String, dynamic> data = {
      "em": email,
      "pa": passwordData,
    };

    try {
      String rawJson = await client.postRawResponse("oauth/login", data);
      if (rawJson == null) {
        throw ("Internal error. Please contact support");
      }

      dynamic serverJson = json.decode(rawJson);

      int status = serverJson["st"];
      if (status == null) {
        throw ("Status is null. Raw response: $rawJson");
      }
      if (status == 41) {
        throw ("Login or password is incorrect");
      }

      var token = serverJson["to"];
      if (token == null) {
        throw ("Token is null. Raw response: $rawJson");
      }

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("accessToken", token);
      controller.hideActivityIndicator();
    } catch (error) {
      try {
        var errorJson = json.decode(error);
        String message = errorJson["message"];
        if (message != null) {
          return Future.error(message);
        }
        return Future.error("Authorization: $error");
      } catch (error2) {
        return Future.error("Authorization: $error");
      }
    } finally {
      controller.hideActivityIndicator();
    }
  }
}
