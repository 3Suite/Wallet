import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/constants/colors.dart';
import 'package:mobile_app/localization/localization-constants.dart';
import 'package:mobile_app/themes/themes.dart';
import 'package:mobile_app/ui/common-widgets/custom-button.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:mobile_app/ui/extensions/custom-widget-extension.dart';

import 'icode-entering-presenter.dart';

class CodeEnteringPage extends StatefulWidget {
  final ICodeEnteringPresenter presenter;

  CodeEnteringPage({@required this.presenter});

  @override
  CodeEnteringPageState createState() => CodeEnteringPageState();
}

class CodeEnteringPageState extends State<CodeEnteringPage> {
  String code = "";

  @override
  void initState() {
    super.initState();

    widget.presenter.controller = this;
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
                    SizedBox(height: 30),
                    Text(
                      getTranslated(context, "enter-sms-code"),
                      style: CustomThemes.authorizationTheme.textTheme.bodyText2,
                    ),
                    SizedBox(height: 10),
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
                      padding: EdgeInsets.only(top: 80, bottom: 10),
                      height: 220,
                      child: PinCodeTextField(
                        appContext: context,
                        length: 4,
                        keyboardType: TextInputType.number,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 96,
                        ),
                        pinTheme: PinTheme(
                          activeColor: CustomColors.darkGreenColor,
                          inactiveColor: Colors.black,
                          selectedColor: Colors.grey,
                          fieldWidth: 70,
                          fieldHeight: 100,
                        ),
                        controller: TextEditingController(text: code),
                        onCompleted: (code) {
                          this.code = code;
                        },
                        onChanged: (code) {
                          // Nothing...
                        },
                      ),
                    ),
                    SizedBox(height: 80),
                    Column(
                      children: [
                        CustomButton(
                          text: widget.presenter.getButtonName(context),
                          style: CustomThemes.authorizationTheme.textTheme.subtitle1,
                          tappedCallback: () async {
                            await widget.presenter.sendCode(context, code).catchError((error) {
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
                        SizedBox(height: 10),
                        widget.presenter.getAdditionalButton(context),
                      ],
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
