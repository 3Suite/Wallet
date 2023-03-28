import 'package:flutter/material.dart';
import 'package:mobile_app/localization/localization-constants.dart';
import 'package:mobile_app/models/card-model.dart';
import 'package:mobile_app/models/transaction-model.dart';
import 'package:mobile_app/themes/themes.dart';
import 'package:mobile_app/ui/widgets/card-widget.dart';
import 'package:mobile_app/utilities/hex-color.dart';
import 'package:mobile_app/view-models/card-view-model.dart';
import 'package:mobile_app/view-models/detailed-transaction-view-model.dart';

class TransactionPage extends StatefulWidget {
  final CardModel card;
  final TransactionModel transaction;

  TransactionPage({@required this.card, @required this.transaction});

  @override
  _TransactionPageState createState() => _TransactionPageState(
        card: card,
        transaction: DetailedTransactionViewModel.withTransaction(transaction),
      );
}

class _TransactionPageState extends State<TransactionPage> {
  final CardModel card;
  final DetailedTransactionViewModel transaction;

  _TransactionPageState({@required this.card, @required this.transaction});

  @override
  Widget build(BuildContext context) {
    var appBar = AppBar(
      title: Text(
        getTranslated(context, "dashboard"),
        style: CustomThemes.darkGrayGreenTheme.textTheme.subtitle1,
      ),
      elevation: 0,
      backgroundColor: Colors.white,
      iconTheme:
          IconThemeData(color: CustomThemes.darkGrayGreenTheme.accentColor),
    );

    var cardWidget = CardWidget(card: CardViewModel.withCard(card: card));

    return Scaffold(
      appBar: appBar,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 56, right: 56),
              child: cardWidget,
            ),
            Expanded(
              child: Container(
                margin:
                    EdgeInsets.only(left: 16, top: 35, right: 16, bottom: 35),
                padding: EdgeInsets.all(30),
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
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        getTranslated(context, "transaction-details"),
                        style:
                            CustomThemes.darkGrayGreenTheme.textTheme.subtitle1,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 15),
                      SizedBox(
                        height: 1,
                        child: Container(
                          color: CustomThemes.darkGrayGreenTheme.accentColor,
                        ),
                      ),
                      SizedBox(height: 50),
                      getRowKeyValueWidget(
                          getTranslated(context, "date-of-transaction"), transaction.dateAndTime),
                      getColumnKeyValueWidget(getTranslated(context, "transaction-id"), transaction.id),
                      getColumnKeyValueWidget(
                          getTranslated(context, "type-of-transaction"), transaction.type),
                      getColumnKeyValueWidget(
                          getTranslated(context, "beneficiary-name"), transaction.beneficieryName),

                      // -ER- Unknown field. Not used.
                      // getColumnKeyValueWidget(
                      // "Account IBAN", transaction.accountIban),
                      getRowKeyValueWidget(getTranslated(context, "amount"), transaction.amount),
                      getRowKeyValueWidget(
                        getTranslated(context, "transaction"),
                        transaction.status,
                        color: HexColor("#15752D"),
                      ),

                      transaction.filePath == null || transaction.filePath.isEmpty 
                      ? Container() 
                      : getColumnKeyValueWidget(
                          getTranslated(context, "file-name"), 
                          transaction.filePath
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget getColumnKeyValueWidget(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          "$title:",
          style: CustomThemes.darkGrayGreenTheme.textTheme.headline3,
        ),
        Text(
          value,
          style: CustomThemes.darkGrayGreenTheme.textTheme.headline3,
        ),
      ],
    );
  }

  Widget getRowKeyValueWidget(
    String title,
    String value, {
    Color color = Colors.black,
  }) {
    var valueStyle = CustomThemes.darkGrayGreenTheme.textTheme.headline3;
    valueStyle.apply(color: color);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "$title:",
          style: CustomThemes.darkGrayGreenTheme.textTheme.headline3,
        ),
        Text(
          value,
          style: valueStyle,
        ),
      ],
    );
  }
}
