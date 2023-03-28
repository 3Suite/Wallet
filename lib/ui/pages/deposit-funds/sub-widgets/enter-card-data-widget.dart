import 'package:flutter/material.dart';
import 'package:mobile_app/localization/localization-constants.dart';
import 'package:mobile_app/themes/themes.dart';
import 'package:mobile_app/ui/common-widgets/custom-button.dart';
import 'package:mobile_app/ui/common-widgets/text-field-with-header.dart';

class CardData {
  String number;
  String name;
  String date;
  String cvv;

  CardData.emptyCard() {
    number = "";
    name = "";
    date = "";
    cvv = "";
  }
}

class EnterCardDataWidget extends StatefulWidget {
  final void Function(CardData) cardDataEnteredCallback;

  EnterCardDataWidget({@required this.cardDataEnteredCallback});

  @override
  _EnterCardDataWidgetState createState() => _EnterCardDataWidgetState(cardDataEnteredCallback: cardDataEnteredCallback);
}

class _EnterCardDataWidgetState extends State<EnterCardDataWidget> {
  final void Function(CardData) cardDataEnteredCallback;

  _EnterCardDataWidgetState({@required this.cardDataEnteredCallback});

  CardData card = CardData.emptyCard();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextFieldWithHeader(
          header: getTranslated(context, "name-on-card"),
          headerStyle: CustomThemes.darkGrayGreenTheme.textTheme.subtitle2,
          textStyle: CustomThemes.darkGrayGreenTheme.textTheme.headline4,
          placeholderStyle: CustomThemes.darkGrayGreenTheme.textTheme.headline4,
          placeholderText: getTranslated(context, "name-on-card"),
          text: card.name,
          textChanged: (name) {
            card.name = name;
          },
        ),
        SizedBox(height: 20),
        TextFieldWithHeader(
          header: getTranslated(context, "card-number"),
          headerStyle: CustomThemes.darkGrayGreenTheme.textTheme.subtitle2,
          textStyle: CustomThemes.darkGrayGreenTheme.textTheme.headline4,
          placeholderStyle: CustomThemes.darkGrayGreenTheme.textTheme.headline4,
          placeholderText: "xxxx - xxxx - xxxx- xxxx",
          text: card.number,
          textChanged: (cardNumber) {
            card.number = cardNumber;
          },
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 2,
              child: TextFieldWithHeader(
                header: getTranslated(context, "expiry-date"),
                headerStyle: CustomThemes.darkGrayGreenTheme.textTheme.subtitle2,
                textStyle: CustomThemes.darkGrayGreenTheme.textTheme.headline4,
                placeholderStyle: CustomThemes.darkGrayGreenTheme.textTheme.headline4,
                placeholderText: "xx/xx",
                text: card.date,
                textChanged: (date) {
                  card.date = date;
                },
              ),
            ),
            Expanded(flex: 1, child: Container()),
            Expanded(
              flex: 2,
              child: TextFieldWithHeader(
                header: "CVV",
                headerStyle: CustomThemes.darkGrayGreenTheme.textTheme.subtitle2,
                textStyle: CustomThemes.darkGrayGreenTheme.textTheme.headline4,
                placeholderStyle: CustomThemes.darkGrayGreenTheme.textTheme.headline4,
                placeholderText: "***",
                text: card.cvv,
                textChanged: (cvv) {
                  card.cvv = cvv;
                },
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
        CustomButton(
          text: getTranslated(context, "process"),
          style: CustomThemes.authorizationTheme.textTheme.subtitle1,
          tappedCallback: () {
            if (cardDataEnteredCallback == null) {
              return;
            }
            cardDataEnteredCallback(card);
          },
        ),
      ],
    );
  }
}
