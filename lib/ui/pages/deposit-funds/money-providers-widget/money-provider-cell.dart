import 'package:flutter/material.dart';
import 'package:mobile_app/themes/themes.dart';
import 'package:mobile_app/utilities/hex-color.dart';
import 'package:mobile_app/view-models/money-provider-view-model.dart';

class MoneyProviderCell extends StatelessWidget {
  final MoneyProviderViewModel provider;
  final bool isSelected;

  MoneyProviderCell({@required this.provider, @required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 96,
      height: 130,
      decoration: BoxDecoration(
        color: isSelected ? HexColor("#C9D0E6") : Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 5,
            blurRadius: 10,
          )
        ],
      ),
      child: Column(
        children: [
          Image(
            height: 96,
            width: 96,
            image: AssetImage(
              provider.image,
            ),
            fit: BoxFit.fitHeight,
          ),
          Text(
            provider.name,
            style: CustomThemes.darkGrayGreenTheme.textTheme.headline4,
          ),
        ],
      ),
    );
  }
}
