import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/constants/colors.dart';
import 'package:mobile_app/constants/models-storage.dart';
import 'package:mobile_app/localization/localization-constants.dart';
import 'package:mobile_app/models/card-model.dart';
import 'package:mobile_app/themes/themes.dart';
import 'package:mobile_app/ui/common-widgets/selection-container-with-header.dart';
import 'package:mobile_app/ui/common-widgets/selection-page.dart';
import 'package:qr_flutter/qr_flutter.dart';

class EVouchersPage extends StatefulWidget {
  @override
  _EVouchersPageState createState() => _EVouchersPageState();
}

class _EVouchersPageState extends State<EVouchersPage> {
  CardModel accountType = ModelsStorage.cards.first;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.backgroundLightGrayColor,
        elevation: 0,
        title: Text(
          getTranslated(context, "e-vouchers"),
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
                SizedBox(height: 10),
                SelectionContainerWithHeader(
                  header: getTranslated(context, "select-account-type"),
                  headerStyle:
                      CustomThemes.authorizationTheme.textTheme.headline2,
                  text: accountType == null ? "" : accountType.value,
                  textStyle:
                      CustomThemes.authorizationTheme.textTheme.bodyText1,
                  placeholderText: getTranslated(context, "account-type"),
                  placeholderStyle:
                      CustomThemes.darkGrayGreenTheme.textTheme.headline6,
                  onTap: () {
                    var page = SelectionPage(
                      title: getTranslated(context, "select-account-type"),
                      values: ModelsStorage.cards,
                      selectedValue: accountType == null
                          ? CardModel(0, 0, "", 0, 0, false, "")
                          : accountType,
                      wasSelected: (accountType) async {
                        setState(
                          () {
                            this.accountType = accountType;
                          },
                        );
                      },
                    );
                    Navigator.of(context).push(
                      CupertinoPageRoute(
                        fullscreenDialog: true,
                        builder: (context) => page,
                      ),
                    );
                  },
                ),
                Column(
                  children: [
                    SizedBox(height: 10),
                    Container(
                      child: Column(
                        children: [
                          Text(
                            getTranslated(context, "voucher-description"),
                            style: CustomThemes
                                .authorizationTheme.textTheme.bodyText1,
                          ),
                          Text(
                            "50 EURO",
                            style: CustomThemes
                                .authorizationTheme.textTheme.bodyText2,
                          ),
                          Container(
                            height: 200,
                            width: 200,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                width: 1,
                                color: CustomColors.darkGrayGreenColor,
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                QrImage(
                                  data: "https://app.3suite.com/",
                                  version: QrVersions.auto,
                                  size: 150.0,
                                ),
                                Container(
                                  height: 1,
                                  color: Colors.black,
                                ),
                                Text(
                                  "2312312312312312",
                                  style: CustomThemes
                                      .authorizationTheme.textTheme.bodyText1,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 30),
                    Container(
                      child: Column(
                        children: [
                          Text(
                            "50 USD Voucher",
                            style: CustomThemes
                                .authorizationTheme.textTheme.bodyText1,
                          ),
                          Text(
                            "50 USD Voucher",
                            style: CustomThemes
                                .authorizationTheme.textTheme.bodyText2,
                          ),
                          Container(
                            height: 200,
                            width: 200,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                width: 1,
                                color: CustomColors.darkGrayGreenColor,
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                QrImage(
                                  data: "https://app.3suite.com/",
                                  version: QrVersions.auto,
                                  size: 150.0,
                                ),
                                Container(
                                  height: 1,
                                  color: Colors.black,
                                ),
                                Text(
                                  "2312312312312312",
                                  style: CustomThemes
                                      .authorizationTheme.textTheme.bodyText1,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
