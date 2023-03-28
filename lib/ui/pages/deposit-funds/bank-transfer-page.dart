import 'package:flutter/material.dart';
import 'package:mobile_app/constants/colors.dart';
import 'package:mobile_app/themes/themes.dart';
import 'package:mobile_app/view-models/bank-account-details-view-model.dart';

class BankTransferPage extends StatefulWidget {
  final BankAccountDetailsViewModel account;

  BankTransferPage({this.account});

  @override
  _BankTransferPageState createState() => _BankTransferPageState(account: account);
}

class _BankTransferPageState extends State<BankTransferPage> {
  final BankAccountDetailsViewModel account;

  _BankTransferPageState({this.account});

  @override
  Widget build(BuildContext context) {
    var appBar = AppBar(
      title: Text(
        "Bank Deposit Details",
        style: CustomThemes.darkGrayGreenTheme.textTheme.subtitle1,
      ),
      elevation: 0,
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(color: CustomColors.darkGrayGreenColor),
    );

    return Scaffold(
      appBar: appBar,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                getRow("Bank Name", account.bankName),
                getRow("Bank Swift", account.bankSwift),
                getRow("Bank Address", account.bankAddress),
                SizedBox(height: 1, child: Container(color: CustomColors.darkGrayGreenColor)),
                SizedBox(height: 10),
                getRow("Name", account.holderName),
                getRow("IBAN", account.iban),
                getRow("Amount", account.formattedAmount),
                account.refNumber.isNotEmpty ? getRow("Ref Number", account.refNumber) : SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getRow(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: CustomThemes.darkGrayGreenTheme.textTheme.bodyText1,
        ),
        Text(
          value,
          style: CustomThemes.darkGrayGreenTheme.textTheme.bodyText2,
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
