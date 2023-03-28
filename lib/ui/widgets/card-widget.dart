import 'package:flutter/material.dart';
import 'package:mobile_app/localization/localization-constants.dart';
import 'package:mobile_app/utilities/hex-color.dart';
import 'package:mobile_app/view-models/card-view-model.dart';

class CardWidget extends StatefulWidget {
  static const double cardWidth = 300;
  static const double cardHeight = 175;

  final CardViewModel card;

  CardWidget({@required this.card});

  @override
  _CardWidgetState createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: CardWidget.cardHeight,
      width: CardWidget.cardWidth,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            HexColor("#243972"),
            HexColor("#14234A"),
          ],
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(26),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // ----- Card name and balance -----
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[getCurrency(), getBalance()],
              ),
            ),
            // ------ Owner name -----
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[getName()],
            ),
            // ------ Card number -----
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[getCardNumber()],
            ),
          ],
        ),
      ),
    );
  }

  Widget getCardNumber() {
    var length = widget.card.number.length;
    return Text(
      widget.card.number.toUpperCase(),
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.grey, fontSize: length < 42 ? 16 : 10),
      maxLines: 1,
    );
  }

  Widget getCurrency() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          widget.card.currency.toUpperCase(),
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 5),
        Image(
          image: AssetImage('images/chip.png'),
        ),
      ],
    );
  }

  Widget getBalance() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Text(
          getTranslated(context, "available-balance"),
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 13,
          ),
        ),
        SizedBox(height: 5),
        Text(
          widget.card.balance,
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget getName() {
    return Text(
      widget.card.ownerName,
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
