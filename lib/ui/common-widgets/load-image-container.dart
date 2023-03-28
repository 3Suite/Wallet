import 'package:flutter/material.dart';
import 'package:mobile_app/constants/colors.dart';

class LoadImageContainer extends StatefulWidget {
  final String header;
  final TextStyle headerStyle;
  final String status;
  final String description;
  final TextStyle descriptionStyle;
  final Function() tap;

  LoadImageContainer({
    this.header,
    this.headerStyle,
    this.status,
    this.description,
    this.descriptionStyle,
    this.tap,
  });

  @override
  _LoadImageContainerState createState() => _LoadImageContainerState();
}

class _LoadImageContainerState extends State<LoadImageContainer> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.tap();
      },
      child: Container(
        height: 140,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.header,
              style: widget.headerStyle,
            ),
            Container(
              height: 40,
              width: 140,
              decoration: BoxDecoration(
                  color: CustomColors.darkGrayGreenColor,
                  borderRadius: BorderRadius.circular(4),
                ),
              child: Center(
                child: Text(
                  widget.status,
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              )
            ),
            Text(
              widget.description,
              style: widget.descriptionStyle,
            )
          ],
        ),
      ),
    );
  }
}
