import 'package:flutter/material.dart';
import 'package:mobile_app/constants/colors.dart';

class SelectionContainerWithHeader extends StatelessWidget {
  final String header;
  final TextStyle headerStyle;
  final String text;
  final TextStyle textStyle;
  final String placeholderText;
  final TextStyle placeholderStyle;
  final double height;

  final Function() onTap;

  SelectionContainerWithHeader({
    this.header,
    this.headerStyle,
    this.text,
    this.textStyle,
    this.placeholderText,
    this.placeholderStyle,
    this.height = 40,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            header,
            style: headerStyle,
          ),
          SizedBox(height: 6),
          InkWell(
            onTap: () {
              onTap();
            },
            child: Container(
              height: height,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                  width: 1,
                  color: CustomColors.darkGreenColor,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      text.isEmpty ? placeholderText : text,
                      style: text.isEmpty ? placeholderStyle : textStyle,
                    ),
                  ),
                  Icon(
                    Icons.keyboard_arrow_down,
                    color: CustomColors.darkGreenColor,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
