import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:mobile_app/network/http-client/http-client-fabric.dart';
import 'package:mobile_app/network/http-client/ihttp-client.dart';
import 'package:mobile_app/ui/pages/profile/change-password/change-password.dart';
import 'package:mobile_app/ui/extensions/custom-widget-extension.dart';

class ChangePasswordPresenter {
  ChangePasswordPageState controller;

  IHttpClient client = HttpClientFactory.getHttpClient();

  Future<void> changePassword(String oldPassword, String newPassword, String repeatedNewPassword) async {
    if (oldPassword.isEmpty) {
      return Future.error("Please, fill old password");
    }

    if (newPassword.isEmpty) {
      return Future.error("Please, fill new password");
    }

    if (repeatedNewPassword.isEmpty) {
      return Future.error("Please, re-type password");
    }

    if (newPassword != repeatedNewPassword) {
      return Future.error("Please mismatch");
    }

    controller.showActivityIndicator();

    var oldPasswordData = "";
    try {
      oldPasswordData = sha512.convert(utf8.encode(oldPassword)).toString();
    } catch (error) {
      controller.hideActivityIndicator();
      return Future.error(error);
    }

    var newPasswordData = "";
    try {
      newPasswordData = sha512.convert(utf8.encode(newPassword)).toString();
    } catch (error) {
      controller.hideActivityIndicator();
      return Future.error(error);
    }

    var newRepeatedPasswordData = "";
    try {
      newRepeatedPasswordData = sha512.convert(utf8.encode(repeatedNewPassword)).toString();
    } catch (error) {
      controller.hideActivityIndicator();
      return Future.error(error);
    }

    var rawJson = client.postRawResponse("oauth/password", {
      "pa1": oldPasswordData,
      "pa2": newPasswordData,
      "pa3": newRepeatedPasswordData,
    });

    if (rawJson == null) {
      controller.hideActivityIndicator();
      return Future.error("Internal error. Please contact support");
    }

    controller.hideActivityIndicator();
  }
}
