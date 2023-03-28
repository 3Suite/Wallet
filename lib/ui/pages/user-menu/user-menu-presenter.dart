import 'package:flutter/material.dart';
import 'package:mobile_app/ui/pages/authorization/sign-in/sign-in.dart';
import 'package:mobile_app/ui/pages/user-menu/user-menu.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:mobile_app/ui/extensions/custom-widget-extension.dart';

class UserMenuPresenter {
  UserMenuPageState controller;

  void logout(BuildContext context) async {
    controller.showActivityIndicator();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("guestToken")) {
      prefs.remove("guestToken");
    }
    if (prefs.containsKey("confirmToken")) {
      prefs.remove("confirmToken");
    }
    if (prefs.containsKey("accessToken")) {
      prefs.remove("accessToken");
    }

    controller.hideActivityIndicator();

    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => SignInPage(),
        ),
        (route) => false);
  }
}
