import 'dart:convert';

import 'package:email_validator/email_validator.dart';
import 'package:mobile_app/network/http-client/http-client-fabric.dart';
import 'package:mobile_app/ui/pages/authorization/registration/registration.dart';
import 'package:mobile_app/ui/extensions/custom-widget-extension.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:crypto/crypto.dart';

class RegistrationPresenter {
  RegistrationPageState controller;

  Future<void> register(String phone, String email, String password, String repeatedPassword, String code) async {
    if (phone.isEmpty) {
      return Future.error("Please, fill phone");
    }

    if (email.isEmpty) {
      return Future.error("Please, fill email");
    }

    if (!EmailValidator.validate(email)) {
      return Future.error("Email is not valid");
    }

    if (password.isEmpty) {
      return Future.error("Please, fill password");
    }

    if (password != repeatedPassword) {
      return Future.error("Password mismatch");
    }

    controller.showActivityIndicator();

    var passwordData = "";
    try {
      passwordData = sha512.convert(utf8.encode(password)).toString();
    } catch (error) {
      print("### Converting password to sha512 finished with error - $error");
      return Future.error("Error: password converting finished with error");
    }

    Map<String, dynamic> data = {
      "phone": phone,
      "em": email,
      "pa": passwordData,
    };

    if (code != null && code.isNotEmpty) {
      data["code"] = code;
    } else {
      data["code"] = "";
    }

    var client = HttpClientFactory.getHttpClient();
    String rawResponse = await client.postRawResponse("/oauth/register2", data);
    print(rawResponse);
    dynamic jsonResponse = json.decode(rawResponse);
    try {
      String confirmationToken = jsonResponse["to"];
      int status = jsonResponse["st"];

      if (status == null) {
        throw ("Incorrect server answer. Error: status is null. Raw response: $rawResponse");
      }

      if (status == 39) {
        throw ("Email already registered");
      }

      if (confirmationToken == null) {
        throw ("Incorrect server answer. Error: confirmation token is null. Raw response: $rawResponse");
      }

      if (status == 0) {
        throw ("Status is not success. Raw response: $rawResponse");
      }

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("confirmToken", confirmationToken);
    } catch (error) {
      return Future.error("Registration: $error");
    } finally {
      controller.hideActivityIndicator();
    }
  }
}
