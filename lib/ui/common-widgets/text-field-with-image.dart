import 'package:flutter/material.dart';

class TextFieldWithImage extends StatelessWidget {
  final String text;
  final TextStyle textStyle;
  final String placeholderText;
  final TextStyle placeholderStyle;
  final String imagePath;
  final double height;

  final Function(String) textChanged;

  final TextInputType keyboardType;

  final bool isPassword;

  TextFieldWithImage({
    this.text,
    this.textStyle,
    this.placeholderText,
    this.placeholderStyle,
    this.imagePath,
    this.height = 55,
    this.textChanged,
    this.keyboardType = TextInputType.text,
    this.isPassword = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(width: 10),
          Image.asset(
            imagePath,
          ),
          Expanded(
            child: TextField(
              controller: TextEditingController(text: text),
              keyboardType: keyboardType,
              style: textStyle,
              obscureText: isPassword,
              decoration: InputDecoration(
                hintText: placeholderText,
                hintStyle: placeholderStyle,
                filled: true,
                fillColor: Colors.transparent,
                border: InputBorder.none,
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
