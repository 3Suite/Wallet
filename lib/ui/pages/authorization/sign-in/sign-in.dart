import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/constants/colors.dart';
import 'package:mobile_app/localization/localization-constants.dart';
import 'package:mobile_app/themes/themes.dart';
import 'package:mobile_app/ui/common-widgets/custom-button.dart';
import 'package:mobile_app/ui/common-widgets/text-field-with-image.dart';
import 'package:mobile_app/ui/navigation-bar/bottom-navigation-bar.dart';
import 'package:mobile_app/ui/pages/authorization/registration/registration.dart';
import 'package:mobile_app/ui/pages/authorization/sign-in/sign-in-presenter.dart';
import 'package:mobile_app/ui/pages/forgot-password/forgot-password.dart';
import 'package:mobile_app/utilities/hex-color.dart';
import 'package:mobile_app/ui/extensions/custom-widget-extension.dart';

class SignInPage extends StatefulWidget {
  @override
  SignInPageState createState() => SignInPageState();
}

class SignInPageState extends State<SignInPage> {
  String email = "";
  String password = "";

  final SignInPresenter presenter = SignInPresenter();

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
                    Text(
                      getTranslated(context, "sign-in"),
                      style: CustomThemes.authorizationTheme.textTheme.bodyText2,
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
                      height: 130,
                      child: ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            return TextFieldWithImage(
                              text: email,
                              textStyle: CustomThemes.authorizationTheme.textTheme.bodyText1,
                              placeholderText: getTranslated(context, "email"),
                              placeholderStyle: CustomThemes.authorizationTheme.textTheme.subtitle2,
                              imagePath: "images/email-icon.png",
                              textChanged: (email) {
                                this.email = email;
                              },
                              keyboardType: TextInputType.emailAddress,
                            );
                          } else {
                            return TextFieldWithImage(
                              text: password,
                              textStyle: CustomThemes.authorizationTheme.textTheme.bodyText1,
                              placeholderText: getTranslated(context, "password"),
                              placeholderStyle: CustomThemes.authorizationTheme.textTheme.subtitle2,
                              imagePath: "images/password-icon.png",
                              textChanged: (password) {
                                this.password = password;
                              },
                              isPassword: true,
                            );
                          }
                        },
                        separatorBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.only(left: 15, right: 15),
                            height: 1,
                            color: HexColor("#DDDDDD").withOpacity(0.33),
                          );
                        },
                        itemCount: 2,
                      ),
                    ),
                    SizedBox(height: 15),
                    Container(
                      margin: EdgeInsets.only(left: 30),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ForgotPasswordPage(),
                            ),
                          );
                        },
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            getTranslated(context, "forgot-password"),
                            style: CustomThemes.authorizationTheme.textTheme.bodyText1,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 80),
                    Container(
                      margin: EdgeInsets.only(left: 30, right: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          CustomButton(
                            text: getTranslated(context, "registration"),
                            style: CustomThemes.authorizationTheme.textTheme.bodyText1,
                            tappedCallback: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => RegistrationPage(),
                                ),
                              );
                            },
                          ),
                          CustomButton(
                            text: getTranslated(context, "sign-in"),
                            style: CustomThemes.authorizationTheme.textTheme.subtitle1,
                            tappedCallback: () async {
                              print("Sign in");
                              await presenter.authorization(email, password).then((value) {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => BotttomNavigationBar(),
                                    ),
                                    (route) => false);
                              }).catchError((error) {
                                var errorMessage = "";
                                try {
                                  errorMessage = json.decode(error)["message"];
                                } catch (e) {
                                  errorMessage = error as String;
                                }
                                hideActivityIndicator();
                                showErrorAlert(
                                  message: errorMessage,
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
