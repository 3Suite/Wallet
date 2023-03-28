import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_app/constants/models-storage.dart';
import 'package:mobile_app/models/card-model.dart';
import 'package:mobile_app/models/provider-model.dart';
import 'package:mobile_app/localization/localization-constants.dart';
import 'package:mobile_app/themes/themes.dart';
import 'package:mobile_app/ui/common-widgets/text-field-with-header.dart';

class EnterAmountWidget extends StatefulWidget {
  final _EnterAmountWidgetState _state = _EnterAmountWidgetState();
  final void Function(double) amountChangedCallback;

  EnterAmountWidget({this.amountChangedCallback});

  @override
  _EnterAmountWidgetState createState() => _state;

  void updateProvider(ProviderModel provider) {
    _state.updateProvider(provider);
  }

  void updateCard(CardModel card) {
    _state.updateCard(card);
  }
}

class _EnterAmountWidgetState extends State<EnterAmountWidget> {
  String amount = "";
  double fees = 0;
  String completion = "";
  double receiveAmount = 0;
  String currencySymbol = "";

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // ----- Fees -----
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              getTranslated(context, "fees") + ":",
              style: CustomThemes.darkGrayGreenTheme.textTheme.headline3,
            ),
            SizedBox(width: 30),
            Text(
              NumberFormat.percentPattern().format(fees),
              style: CustomThemes.darkGrayGreenTheme.textTheme.headline3,
            )
          ],
        ),
        // ----- Completion -----
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Completion: ",
              style: CustomThemes.darkGrayGreenTheme.textTheme.headline3,
            ),
            Text(
              "3-5 " + getTranslated(context, "days"),
              style: CustomThemes.darkGrayGreenTheme.textTheme.headline3,
            ),
          ],
        ),
        // ----- Amount -----
        SizedBox(height: 30),
        TextFieldWithHeader(
          headerStyle: CustomThemes.authorizationTheme.textTheme.headline2,
          textStyle: CustomThemes.authorizationTheme.textTheme.headline1,
          placeholderStyle: CustomThemes.authorizationTheme.textTheme.subtitle2,
          header: getTranslated(context, "amount"),
          placeholderText: getTranslated(context, "enter-amount"),
          text: amount,
          keyboardType: TextInputType.numberWithOptions(
            signed: false,
            decimal: true,
          ),
          height: 58,
          textChanged: (text) {
            if (text.isEmpty) {
              amount = "";
              setState(() {
                receiveAmount = 0;
              });
              widget.amountChangedCallback(0);
              return;
            }

            if (text.endsWith(".")) {
              return;
            }

            var newAmount = double.tryParse(text);
            if (newAmount == null) {
              // -ER- Set old value
              setState(() {
                amount = amount;
              });
              return;
            }
            amount = NumberFormat.decimalPattern().format(newAmount);

            if (amount.contains(".")) {
              // Need to parse
              var parts = amount.split(".");
              if (parts.length > 1) {
                var lastPart = parts[1];
                if (lastPart.length > 2) {
                  lastPart = lastPart.substring(0, 2);
                  amount = "${parts[0]}.$lastPart";
                }
              }
            }

            setState(() {
              receiveAmount = newAmount - newAmount * fees;
            });
            widget.amountChangedCallback(newAmount);
          },
        ),
        // ----- Receive Amount -----
        SizedBox(height: 20),
        Row(
          children: [
            Text(
              getTranslated(context, "receive-amount") + ": ",
              style: CustomThemes.darkGrayGreenTheme.textTheme.headline3,
            ),
            Text(
              NumberFormat.currency(symbol: currencySymbol).format(receiveAmount),
              style: CustomThemes.darkGrayGreenTheme.textTheme.headline3,
            ),
          ],
        ),
        // ----- Button `Deposit` -----
        // -ER- Empty for now for union with card number widget
        Row(),
      ],
    );
  }

  void updateProvider(ProviderModel provider) {
    setState(() {
      fees = provider.fee;
      completion = provider.terms;
    });
  }

  void updateCard(CardModel card) {
    var currency = ModelsStorage.currencies.firstWhere((c) => c.id == card.currencyId, orElse: () => null);
    if (currency == null) {
      return;
    }
    setState(() {
      currencySymbol = currency.getCurrencySign();
    });
  }
}
