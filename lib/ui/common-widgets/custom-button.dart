import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final TextStyle style;
  final String text;
  final double height;
  final double width;
  final void Function() tappedCallback;

  CustomButton({
    this.text,
    this.style,
    this.height = 48,
    this.width = 167,
    this.tappedCallback,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: tappedCallback,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: style.backgroundColor,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(
          child: Text(
            text,
            style: style,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

class CustomButton3 extends StatelessWidget {
  final TextStyle style;
  final String text;
  final double height;
  final void Function() tappedCallback;

  CustomButton3({
    this.text,
    this.style,
    this.height = 48,
    this.tappedCallback,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: tappedCallback,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Container(
          height: height,
          alignment: Alignment.center,
          color: style.backgroundColor,
          child: Text(
            text,
            style: style,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
