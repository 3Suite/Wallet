import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/constants/colors.dart';
import 'package:mobile_app/localization/localization-constants.dart';
import 'package:mobile_app/themes/themes.dart';
import 'package:mobile_app/ui/common-widgets/custom-button.dart';
import 'package:mobile_app/ui/common-widgets/text-field-with-header.dart';
import 'package:mobile_app/ui/pages/profile/change-password/change-password-presenter.dart';

import 'package:mobile_app/ui/extensions/custom-widget-extension.dart';

class ChangePasswordPage extends StatefulWidget {
  @override
  ChangePasswordPageState createState() => ChangePasswordPageState();
}

class ChangePasswordPageState extends State<ChangePasswordPage> {
  String oldPassword = "";
  String newPassword = "";
  String repeatedNewPassword = "";

  final ChangePasswordPresenter presenter = ChangePasswordPresenter();

  @override
  void initState() {
    super.initState();

    presenter.controller = this;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.backgroundLightGrayColor,
        elevation: 0,
        title: Text(
          getTranslated(context, "change-password"),
          style: CustomThemes.darkGrayGreenTheme.textTheme.subtitle1,
        ),
        iconTheme: IconThemeData(
          color: CustomColors.darkGrayGreenColor,
        ),
      ),
      body: Container(
        color: CustomColors.backgroundLightGrayColor,
        child: Container(
          margin: EdgeInsets.only(left: 18, right: 18, top: 20),
          padding: EdgeInsets.only(top: 10, bottom: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 5,
                blurRadius: 20,
              )
            ],
          ),
          child: Container(
            height: MediaQuery.of(context).size.height / 2.8,
            padding: EdgeInsets.only(left: 18, right: 18, top: 20),
            child: ListView(
              scrollDirection: Axis.vertical,
              children: [
                TextFieldWithHeader(
                  header: getTranslated(context, "old-password"),
                  headerStyle: CustomThemes.authorizationTheme.textTheme.headline2,
                  text: oldPassword,
                  textStyle: CustomThemes.authorizationTheme.textTheme.bodyText1,
                  placeholderText: getTranslated(context, "enter-old-password"),
                  placeholderStyle: CustomThemes.darkGrayGreenTheme.textTheme.headline6,
                  textChanged: (oldPassword) {
                    this.oldPassword = oldPassword;
                  },
                  isPassword: true,
                ),
                SizedBox(height: 15),
                TextFieldWithHeader(
                  header: getTranslated(context, "new-password"),
                  headerStyle: CustomThemes.authorizationTheme.textTheme.headline2,
                  text: newPassword,
                  textStyle: CustomThemes.authorizationTheme.textTheme.bodyText1,
                  placeholderText: getTranslated(context, "enter-new-password"),
                  placeholderStyle: CustomThemes.darkGrayGreenTheme.textTheme.headline6,
                  textChanged: (newPassword) {
                    this.newPassword = newPassword;
                  },
                  isPassword: true,
                ),
                SizedBox(height: 15),
                TextFieldWithHeader(
                  header: getTranslated(context, "re-type-password"),
                  headerStyle: CustomThemes.authorizationTheme.textTheme.headline2,
                  text: repeatedNewPassword,
                  textStyle: CustomThemes.authorizationTheme.textTheme.bodyText1,
                  placeholderText: getTranslated(context, "re-type-password"),
                  placeholderStyle: CustomThemes.darkGrayGreenTheme.textTheme.headline6,
                  textChanged: (repeatedNewPassword) {
                    this.repeatedNewPassword = repeatedNewPassword;
                  },
                  isPassword: true,
                ),
                SizedBox(height: 20),
                Center(
                  child: CustomButton(
                    text: getTranslated(context, "save").toUpperCase(),
                    style: CustomThemes.authorizationTheme.textTheme.subtitle1,
                    tappedCallback: () async {
                      print("Save");
                      await presenter.changePassword(oldPassword, newPassword, repeatedNewPassword).then((value) {
                        goBack();
                      }).catchError((error) {
                        showErrorAlert(
                          message: error as String,
                          actions: <CupertinoDialogAction>[
                            CupertinoDialogAction(
                              isDefaultAction: true,
                              child: Text("Ok"),
                              onPressed: () {
                                goBack();
                              },
                            ),
                          ],
                        );
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
