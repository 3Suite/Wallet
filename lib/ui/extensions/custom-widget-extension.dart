import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:load/load.dart';

extension CustomState on State {
  void showErrorAlert({
    String title = "Error",
    String message,
    List<CupertinoDialogAction> actions,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text(title),
          content: Text(message),
          actions: actions,
        );
      },
    );
  }

  void goBack() {
    if (!Navigator.canPop(context)) {
      return;
    }
    Navigator.pop(context);
  }

  void showActivityIndicator() {
    showLoadingDialog();
  }

  void hideActivityIndicator() {
    hideLoadingDialog();
  }

  BuildContext get buildContext => context;
}
