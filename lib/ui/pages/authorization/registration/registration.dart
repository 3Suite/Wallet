import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/constants/colors.dart';
import 'package:mobile_app/localization/localization-constants.dart';
import 'package:mobile_app/themes/themes.dart';
import 'package:mobile_app/ui/common-widgets/custom-button.dart';
import 'package:mobile_app/ui/common-widgets/text-field-with-image.dart';
import 'package:mobile_app/ui/pages/authorization/code-entering/code-entering.dart';
import 'package:mobile_app/ui/pages/authorization/code-entering/registration-code-entering-presenter.dart';
import 'package:mobile_app/ui/pages/authorization/registration/registration-presenter.dart';
import 'package:mobile_app/utilities/hex-color.dart';
import 'package:mobile_app/ui/extensions/custom-widget-extension.dart';

class RegistrationPage extends StatefulWidget {
  @override
  RegistrationPageState createState() => RegistrationPageState();
}

class RegistrationPageState extends State<RegistrationPage> {
  String phone = "";
  String email = "";
  String password = "";
  String repeatedPassword = "";
  String code = "";

  final RegistrationPresenter presenter = RegistrationPresenter();

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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height / 10,
                      ),
                      alignment: Alignment.bottomCenter,
                      child: Image.asset(
                        "images/logo.png",
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      getTranslated(context, "registration"),
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
                        child: ListView(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
                            TextFieldWithImage(
                              text: phone,
                              textStyle: CustomThemes.authorizationTheme.textTheme.bodyText1,
                              placeholderText: getTranslated(context, "mobile-phone"),
                              placeholderStyle: CustomThemes.authorizationTheme.textTheme.subtitle2,
                              imagePath: "images/phone-icon.png",
                              textChanged: (phone) {
                                this.phone = phone;
                              },
                              keyboardType: TextInputType.phone,
                            ),
                            _getSeparator(),
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
                            _getSeparator(),
                            TextFieldWithImage(
                              text: password,
                              textStyle: CustomThemes.authorizationTheme.textTheme.bodyText1,
                              placeholderText: getTranslated(context, "password"),
                              placeholderStyle: CustomThemes.authorizationTheme.textTheme.subtitle2,
                              imagePath: "images/user-icon.png",
                              textChanged: (password) {
                                this.password = password;
                              },
                              isPassword: true,
                            ),
                            _getSeparator(),
                            TextFieldWithImage(
                              text: repeatedPassword,
                              textStyle: CustomThemes.authorizationTheme.textTheme.bodyText1,
                              placeholderText: getTranslated(context, "re-type-password"),
                              placeholderStyle: CustomThemes.authorizationTheme.textTheme.subtitle2,
                              imagePath: "images/user-icon.png",
                              textChanged: (repeatedPassword) {
                                this.repeatedPassword = repeatedPassword;
                              },
                              isPassword: true,
                            ),
                            _getSeparator(),
                            TextFieldWithImage(
                              text: code,
                              textStyle: CustomThemes.authorizationTheme.textTheme.bodyText1,
                              placeholderText: getTranslated(context, "referral-code"),
                              placeholderStyle: CustomThemes.authorizationTheme.textTheme.subtitle2,
                              imagePath: "images/user-icon.png",
                              textChanged: (code) {
                                this.code = code;
                              },
                              isPassword: true,
                            ),
                          ],
                        )),
                    SizedBox(height: 80),
                    Container(
                      margin: EdgeInsets.only(left: 30, right: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          CustomButton(
                            text: getTranslated(context, "sign-in"),
                            style: CustomThemes.authorizationTheme.textTheme.bodyText1,
                            tappedCallback: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          CustomButton(
                            text: getTranslated(context, "registration"),
                            style: CustomThemes.authorizationTheme.textTheme.subtitle1,
                            tappedCallback: () async {
                              print("Register");
                              await presenter.register(phone, email, password, repeatedPassword, code).then((value) {
                                var presenter = RegistrationCodeEnteringPresenter();
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => CodeEnteringPage(presenter: presenter),
                                  ),
                                );
                              }).catchError((error) {
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

  Widget _getSeparator() {
    return Container(
      margin: EdgeInsets.only(left: 15, right: 15),
      height: 1,
      color: HexColor("#DDDDDD").withOpacity(0.33),
    );
  }
}
