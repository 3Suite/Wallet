import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/constants/colors.dart';
import 'package:mobile_app/constants/models-storage.dart';
import 'package:mobile_app/localization/localization-constants.dart';
import 'package:mobile_app/models/country-model.dart';
import 'package:mobile_app/themes/themes.dart';
import 'package:mobile_app/ui/common-widgets/custom-button.dart';
import 'package:mobile_app/ui/common-widgets/selection-container-with-header.dart';
import 'package:mobile_app/ui/common-widgets/selection-page.dart';
import 'package:mobile_app/ui/common-widgets/text-field-with-header.dart';
import 'package:mobile_app/ui/extensions/custom-widget-extension.dart';

import 'add-beneficiary-presenter.dart';

class AddBeneficiaryPage extends StatefulWidget {
  @override
  AddBeneficiaryPageState createState() => AddBeneficiaryPageState();
}

class AddBeneficiaryPageState extends State<AddBeneficiaryPage> {
  String firstName = "";
  CountryModel country;
  String address = "";
  String state = "";
  String swiftCode = "";
  String iban = "";
  bool favourite = false;

  final AddBeneficiaryPresenter presenter = AddBeneficiaryPresenter();

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
          getTranslated(context, "add-beneficiary"),
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
            height: MediaQuery.of(context).size.height / 1.3,
            padding: EdgeInsets.only(left: 18, right: 18, top: 20),
            child: ListView(
              scrollDirection: Axis.vertical,
              children: [
                TextFieldWithHeader(
                  header: getTranslated(context, "beneficiary-name"),
                  headerStyle:
                      CustomThemes.authorizationTheme.textTheme.headline2,
                  text: firstName,
                  textStyle:
                      CustomThemes.authorizationTheme.textTheme.bodyText1,
                  placeholderText:
                      getTranslated(context, "enter-beneficiary-name"),
                  placeholderStyle:
                      CustomThemes.darkGrayGreenTheme.textTheme.headline6,
                  textChanged: (firstName) {
                    this.firstName = firstName;
                  },
                ),
                SizedBox(height: 15),
                SelectionContainerWithHeader(
                    header: getTranslated(context, "country"),
                    headerStyle:
                        CustomThemes.authorizationTheme.textTheme.headline2,
                    text: country == null ? "" : country.niceName,
                    textStyle:
                        CustomThemes.authorizationTheme.textTheme.bodyText1,
                    placeholderText: getTranslated(context, "select-country"),
                    placeholderStyle:
                        CustomThemes.darkGrayGreenTheme.textTheme.headline6,
                    onTap: () {
                      var page = SelectionPage(
                        title: getTranslated(context, "select-country"),
                        values: ModelsStorage.countries,
                        selectedValue:
                            country == null ? CountryModel() : country,
                        wasSelected: (selectedCountry) {
                          setState(() {
                            this.country = selectedCountry as CountryModel;
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
                TextFieldWithHeader(
                  header: getTranslated(context, "address"),
                  headerStyle:
                      CustomThemes.authorizationTheme.textTheme.headline2,
                  text: address,
                  textStyle:
                      CustomThemes.authorizationTheme.textTheme.bodyText1,
                  placeholderText: getTranslated(context, "enter-address"),
                  placeholderStyle:
                      CustomThemes.darkGrayGreenTheme.textTheme.headline6,
                  textChanged: (address) {
                    this.address = address;
                  },
                ),
                SizedBox(height: 15),
                TextFieldWithHeader(
                  header: getTranslated(context, "state"),
                  headerStyle:
                      CustomThemes.authorizationTheme.textTheme.headline2,
                  text: state,
                  textStyle:
                      CustomThemes.authorizationTheme.textTheme.bodyText1,
                  placeholderText: getTranslated(context, "enter-state"),
                  placeholderStyle:
                      CustomThemes.darkGrayGreenTheme.textTheme.headline6,
                  textChanged: (state) {
                    this.state = state;
                  },
                ),
                SizedBox(height: 15),
                TextFieldWithHeader(
                  header: getTranslated(context, "swift-code"),
                  headerStyle:
                      CustomThemes.authorizationTheme.textTheme.headline2,
                  text: swiftCode,
                  textStyle:
                      CustomThemes.authorizationTheme.textTheme.bodyText1,
                  placeholderText: getTranslated(context, "enter-swift-code"),
                  placeholderStyle:
                      CustomThemes.darkGrayGreenTheme.textTheme.headline6,
                  textChanged: (swiftCode) {
                    this.swiftCode = swiftCode;
                  },
                ),
                SizedBox(height: 15),
                TextFieldWithHeader(
                  header: getTranslated(context, "iban"),
                  headerStyle:
                      CustomThemes.authorizationTheme.textTheme.headline2,
                  text: iban,
                  textStyle:
                      CustomThemes.authorizationTheme.textTheme.bodyText1,
                  placeholderText: getTranslated(context, "enter-iban-number"),
                  placeholderStyle:
                      CustomThemes.darkGrayGreenTheme.textTheme.headline6,
                  textChanged: (iban) {
                    this.iban = iban;
                  },
                ),
                SizedBox(height: 15),
                Row(
                  children: [
                    Container(
                      child: Checkbox(
                        activeColor: CustomColors.darkGreenColor,
                        value: favourite,
                        onChanged: (addToFavorites) {
                          setState(() {
                            this.favourite = addToFavorites;
                          });
                        },
                      ),
                    ),
                    Text(
                      getTranslated(context, "add-to-favorites"),
                      style:
                          CustomThemes.authorizationTheme.textTheme.bodyText1,
                    ),
                  ],
                ),
                SizedBox(height: 20),
                CustomButton(
                  text: getTranslated(context, "add"),
                  style: CustomThemes.authorizationTheme.textTheme.subtitle1,
                  tappedCallback: () async {
                    print("Add");
                    await presenter
                        .addBeneficiary(
                            firstName,
                            country == null ? "" : country.id.toString(),
                            address,
                            state,
                            swiftCode,
                            iban,
                            favourite)
                        .then((value) {
                      Navigator.pop(context);
                    }).catchError(
                      (error) {
                        var errorMessage = "";
                        try {
                          errorMessage = json.decode(error)["message"];
                        } catch (e) {
                          errorMessage = error as String;
                        }
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
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
