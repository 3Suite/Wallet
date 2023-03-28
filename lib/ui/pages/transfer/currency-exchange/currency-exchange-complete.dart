import 'package:flutter/material.dart';
import 'package:mobile_app/constants/colors.dart';
import 'package:mobile_app/localization/localization-constants.dart';
import 'package:mobile_app/themes/themes.dart';

class CurrencyExchangeCompletePage extends StatefulWidget {
  @override
  _CurrencyExchangeCompletePageState createState() => _CurrencyExchangeCompletePageState();
}

class _CurrencyExchangeCompletePageState extends State<CurrencyExchangeCompletePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.backgroundLightGrayColor,
        elevation: 0,
        title: Text(
          getTranslated(context, "currency-exchange"),
          style: CustomThemes.darkGrayGreenTheme.textTheme.subtitle1,
        ),
        iconTheme: IconThemeData(
          color: CustomColors.darkGrayGreenColor,
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Container(
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
                height: MediaQuery.of(context).size.height / 1.6,
                padding: EdgeInsets.only(left: 18, right: 18, top: 20),
                child: ListView(
                  scrollDirection: Axis.vertical,
                  children: [
                    Center(
                      child: Column(
                        children: [
                          SizedBox(height: 150),
                          Image.asset(
                            "images/logo.png",
                            fit: BoxFit.fitWidth,
                          ),
                          SizedBox(height: 70),
                          Text(
                            getTranslated(context, "currency-exchange-complete"),
                            textAlign: TextAlign.center,
                            style: CustomThemes.authorizationTheme.textTheme.headline3,
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
