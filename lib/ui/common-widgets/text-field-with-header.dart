import 'package:flutter/material.dart';
import 'package:mobile_app/constants/colors.dart';

class TextFieldWithHeader extends StatelessWidget {
  final String header;
  final TextStyle headerStyle;
  final String text;
  final TextStyle textStyle;
  final String placeholderText;
  final TextStyle placeholderStyle;
  final double height;

  final bool isPassword;

  final bool isDisable;

  final Function(String) textChanged;

  final TextInputType keyboardType;

  TextFieldWithHeader({
    @required this.header,
    @required this.headerStyle,
    @required this.textStyle,
    @required this.placeholderStyle,
    this.text,
    this.placeholderText,
    this.height = 58,
    this.textChanged,
    this.keyboardType = TextInputType.text,
    this.isPassword = false,
    this.isDisable = false,
  });

  @override
  Widget build(BuildContext context) {
    var controller = TextEditingController(text: text);
    controller.selection = TextSelection.fromPosition(TextPosition(offset: controller.text.length));
    return Container(
      height: height,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            header,
            style: headerStyle,
          ),
          SizedBox(height: 6),
          Expanded(
            child: TextField(
              readOnly: isDisable,
              obscureText: isPassword,
              controller: controller,
              textAlignVertical: TextAlignVertical.center,
              keyboardType: keyboardType,
              style: textStyle,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10),
                hintText: placeholderText,
                hintStyle: placeholderStyle,
                filled: true,
                fillColor: isDisable ? Colors.grey[200] : Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide(
                    width: 1,
                    color: CustomColors.lightGreenColor,
                    style: BorderStyle.none,
                  ),
                ),
              ),
              onChanged: (value) {
                textChanged(value);
              },
            ),
          ),
        ],
      ),
    );
  }
}
