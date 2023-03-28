import 'package:flutter/material.dart';
import 'package:mobile_app/constants/colors.dart';
import 'package:mobile_app/themes/themes.dart';
import 'package:mobile_app/utilities/hex-color.dart';
import 'package:mobile_app/view-models/transaction-view-model.dart';

class TransactionCell extends StatelessWidget {
  static double height = 65;
  static double imageWidth = 36;

  final TransactionViewModel transaction;

  TransactionCell({@required this.transaction});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          // ----- Transaction info -----
          Container(
            width: imageWidth,
            height: imageWidth,
            decoration: BoxDecoration(
              color: HexColor("#F1F3F6"),
              borderRadius: BorderRadius.circular(imageWidth / 2),
            ),
            child: Image(
              image: AssetImage(transaction.image),
            ),
          ),
          // ----- Transaction name and source -----
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 10, right: 10, top: 9),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    transaction.title,
                    maxLines: 1,
                    style: CustomThemes.darkGrayGreenTheme.textTheme.headline6,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    transaction.source,
                    maxLines: 1,
                    style: CustomThemes.darkGrayGreenTheme.textTheme.subtitle2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
          // ----- Transaction time and balance -----
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text(
                transaction.time,
                style: CustomThemes.darkGrayGreenTheme.textTheme.headline5,
              ),
              Text(
                transaction.formatBalance(),
                style: getBalanceStyle(transaction.balance),
              ),
            ],
          )
        ],
      ),
    );
  }

  TextStyle getBalanceStyle(double balance) {
    Color color;
    if (balance < 0) {
      color = CustomColors.negativeBalanceColor;
    } else {
      color = CustomColors.positiveBalanceColor;
    }
    return TextStyle(color: color, fontSize: 16);
  }
}
