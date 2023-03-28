import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/constants/colors.dart';
import 'package:mobile_app/localization/localization-constants.dart';
import 'package:mobile_app/themes/themes.dart';
import 'package:mobile_app/ui/common-widgets/custom-button.dart';
import 'package:mobile_app/ui/common-widgets/text-field-with-image.dart';
import 'package:mobile_app/ui/pages/forgot-password/forgot-password-presenter.dart';
import 'package:mobile_app/ui/extensions/custom-widget-extension.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  ForgotPasswordPageState createState() => ForgotPasswordPageState();
}

class ForgotPasswordPageState extends State<ForgotPasswordPage> {
  String email = "";

  ForgotPasswordPresenter presenter = ForgotPasswordPresenter();

  @override
  void initState() {
    super.initState();

    presenter.controller = this;

  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(
            color: CustomColors.backgroundColor,
            image: DecorationImage(
              image: AssetImage(
                "images/background-authorization.png",
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SafeArea(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(new FocusNode());
              },
              child: Container(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height / 6,
                      ),
                      alignment: Alignment.bottomCenter,
                      child: Image.asset(
                        "images/logo.png",
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: Text(
                        getTranslated(context, "forgot-password-title"),
                        style: CustomThemes.authorizationTheme.textTheme.bodyText2,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 50),
                    Container(
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
                      margin: EdgeInsets.only(left: 30, right: 30),
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      height: 70,
                      child: ListView(
                        children: [
                          TextFieldWithImage(
                            text: email,
                            textStyle: CustomThemes.authorizationTheme.textTheme.bodyText1,
                            placeholderText: getTranslated(context, "email"),
                            placeholderStyle: CustomThemes.authorizationTheme.textTheme.subtitle2,
                            imagePath: "images/email-icon.png",
                            textChanged: (email) {
                              this.email = email;
                            },
                            keyboardType: TextInputType.emailAddress,
                          ),
                          SizedBox(height: 15)
                        ],
                      ),
                    ),
                    SizedBox(height: 70),
                    Container(
                      margin: EdgeInsets.only(left: 30, right: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          CustomButton(
                            text: getTranslated(context, "sign-in"),
                            style: CustomThemes.authorizationTheme.textTheme.bodyText1,
                            tappedCallback: () {
                              Navigator.pop(context);
                            },
                          ),
                          CustomButton(
                            text: getTranslated(context, "restore").toUpperCase(),
                            style: CustomThemes.authorizationTheme.textTheme.subtitle1,
                            tappedCallback: () async {
                              print("Restore");
                              await presenter.restorePassword(email, context).catchError((error) {
                                hideActivityIndicator();
                                showErrorAlert(
                                  message: error,
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
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
