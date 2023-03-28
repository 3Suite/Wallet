import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/constants/colors.dart';
import 'package:mobile_app/constants/models-storage.dart';
import 'package:mobile_app/localization/localization-constants.dart';
import 'package:mobile_app/models/card-model.dart';
import 'package:mobile_app/models/currency-model.dart';
import 'package:mobile_app/themes/themes.dart';
import 'package:mobile_app/ui/common-widgets/custom-button.dart';
import 'package:mobile_app/ui/common-widgets/selection-container-with-header.dart';
import 'package:mobile_app/ui/common-widgets/selection-page.dart';
import 'package:mobile_app/ui/common-widgets/text-field-with-header.dart';
import 'package:mobile_app/ui/pages/transfer/currency-exchange/currency-exchange-complete.dart';
import 'package:mobile_app/ui/pages/transfer/currency-exchange/currency-exchange-presenter.dart';

import 'package:mobile_app/ui/extensions/custom-widget-extension.dart';

class CurrencyExchange extends StatefulWidget {
  @override
  CurrencyExchangeState createState() => CurrencyExchangeState();
}

class CurrencyExchangeState extends State<CurrencyExchange> {
  // From block
  CardModel fromAccountType = ModelsStorage.cards.first;
  String amount = "";

  // To block
  CardModel toAccountType = ModelsStorage.cards.first;
  CurrencyModel toCurrency = ModelsStorage.currencies.firstWhere((element) => element.id == 25); // USD

  // Result
  String approximateAmount = "";

  final CurrencyExchangePresenter presenter = CurrencyExchangePresenter();

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
          getTranslated(context, "currency-exchange"),
          style: CustomThemes.darkGrayGreenTheme.textTheme.subtitle1,
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
                  Text(
                    getTranslated(context, "from"),
                    style: CustomThemes.authorizationTheme.textTheme.headline1,
                  ),
                  SizedBox(height: 10),
                  SelectionContainerWithHeader(
                      header: getTranslated(context, "select-account-type"),
                      headerStyle: CustomThemes.authorizationTheme.textTheme.headline2,
                      text: fromAccountType == null ? "" : fromAccountType.value,
                      textStyle: CustomThemes.authorizationTheme.textTheme.bodyText1,
                      placeholderText: getTranslated(context, "select-account-type"),
                      placeholderStyle: CustomThemes.darkGrayGreenTheme.textTheme.headline6,
                      onTap: () {
                        var page = SelectionPage(
                          title: getTranslated(context, "select-account-type"),
                          values: ModelsStorage.cards,
                          selectedValue: fromAccountType == null ? CardModel(0, 0, "", 0, 0, false, "") : fromAccountType,
                          wasSelected: (fromAccountType) async {
                            setState(() {
                              this.fromAccountType = fromAccountType;
                            });
                            await presenter
                                .getApproximateAmount(
                              this.fromAccountType.currencyId,
                              toCurrency.id,
                              int.parse(amount),
                            )
                                .then((value) {
                              setState(() {
                                approximateAmount = value;
                              });
                            }).catchError((error) {
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
                        );
                        Navigator.of(context).push(
                          CupertinoPageRoute(
                            fullscreenDialog: true,
                            builder: (context) => page,
                          ),
                        );
                      }),
                  SizedBox(height: 15),
                  Row(
                    children: [
                      Flexible(
                        child: TextFieldWithHeader(
                          header: getTranslated(context, "amount"),
                          headerStyle: CustomThemes.authorizationTheme.textTheme.headline2,
                          text: amount,
                          textStyle: CustomThemes.authorizationTheme.textTheme.bodyText1,
                          placeholderText: getTranslated(context, "enter-amount"),
                          placeholderStyle: CustomThemes.darkGrayGreenTheme.textTheme.headline6,
                          textChanged: (amount) async {
                            this.amount = amount;
                            await presenter
                                .getApproximateAmount(
                              fromAccountType.currencyId,
                              toCurrency.id,
                              int.parse(amount),
                            )
                                .then((value) {
                              setState(() {
                                approximateAmount = value;
                              });
                            }).catchError((error) {
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
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20, left: 10),
                        child: Text(
                          ModelsStorage.currencies.firstWhere((element) => element.id == fromAccountType.currencyId).currency,
                          style: CustomThemes.authorizationTheme.textTheme.bodyText1,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    getTranslated(context, "to"),
                    style: CustomThemes.authorizationTheme.textTheme.headline1,
                  ),
                  SizedBox(height: 10),
                  SelectionContainerWithHeader(
                      header: getTranslated(context, "currency"),
                      headerStyle: CustomThemes.authorizationTheme.textTheme.headline2,
                      text: toCurrency == null ? "" : toCurrency.currency,
                      textStyle: CustomThemes.authorizationTheme.textTheme.bodyText1,
                      placeholderText: getTranslated(context, "select-currency"),
                      placeholderStyle: CustomThemes.darkGrayGreenTheme.textTheme.headline6,
                      onTap: () {
                        var page = SelectionPage(
                          title: getTranslated(context, "select-currency"),
                          values: ModelsStorage.currencies.where((element) => element.id != fromAccountType.currencyId).toList(),
                          selectedValue: toCurrency,
                          wasSelected: (toCurrency) async {
                            setState(() {
                              this.toCurrency = toCurrency;
                              this.toAccountType = ModelsStorage.cards.firstWhere((element) => element.currencyId == toCurrency.id);
                            });
                            await presenter
                                .getApproximateAmount(
                              fromAccountType.currencyId,
                              toCurrency.id,
                              int.parse(amount),
                            )
                                .then((value) {
                              print(value);
                              setState(() {
                                approximateAmount = value;
                              });
                            }).catchError((error) {
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
                        );
                        Navigator.of(context).push(
                          CupertinoPageRoute(
                            fullscreenDialog: true,
                            builder: (context) => page,
                          ),
                        );
                      }),
                  SizedBox(height: 15),
                  SelectionContainerWithHeader(
                      header: getTranslated(context, "select-account-type"),
                      headerStyle: CustomThemes.authorizationTheme.textTheme.headline2,
                      text: toAccountType == null ? "" : toAccountType.value,
                      textStyle: CustomThemes.authorizationTheme.textTheme.bodyText1,
                      placeholderText: getTranslated(context, "account-type"),
                      placeholderStyle: CustomThemes.darkGrayGreenTheme.textTheme.headline6,
                      onTap: () {
                        var page = SelectionPage(
                          title: getTranslated(context, "select-account-type"),
                          values: ModelsStorage.cards,
                          selectedValue: toAccountType == null ? CardModel(0, 0, "", 0, 0, false, "") : toAccountType,
                          wasSelected: (toAccountType) {
                            setState(() {
                              this.toAccountType = toAccountType;
                            });
                          },
                        );
                        Navigator.of(context).push(
                          CupertinoPageRoute(
                            fullscreenDialog: true,
                            builder: (context) => page,
                          ),
                        );
                      }),
                  SizedBox(height: 15),
                  Row(
                    children: [
                      Flexible(
                        child: TextFieldWithHeader(
                          header: getTranslated(context, "approximate-amount"),
                          headerStyle: CustomThemes.authorizationTheme.textTheme.headline2,
                          text: approximateAmount,
                          textStyle: CustomThemes.authorizationTheme.textTheme.bodyText1,
                          placeholderText: "0.00",
                          placeholderStyle: CustomThemes.darkGrayGreenTheme.textTheme.headline6,
                          textChanged: (approximateAmount) {
                            this.approximateAmount = approximateAmount;
                          },
                          keyboardType: TextInputType.number,
                          isDisable: true,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20, left: 10),
                        child: Text(
                          toCurrency.currency,
                          style: CustomThemes.authorizationTheme.textTheme.bodyText1,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: CustomButton(
                      text: getTranslated(context, "process-transfer"),
                      style: CustomThemes.authorizationTheme.textTheme.subtitle1,
                      tappedCallback: () async {
                        var amounValue = int.tryParse(amount);
                        await presenter.processTransfer(fromAccountType.id, toAccountType.id, amounValue);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void transferFinishedSuccessfully() {
    hideActivityIndicator();
    Navigator.of(context).push(
      CupertinoPageRoute(
        fullscreenDialog: true,
        builder: (context) => CurrencyExchangeCompletePage(),
      ),
    );
  }
}
