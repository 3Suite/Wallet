import 'package:flutter/material.dart';
import 'package:mobile_app/constants/colors.dart';
import 'package:mobile_app/themes/themes.dart';
import 'package:mobile_app/utilities/hex-color.dart';

abstract class SelectionModel {
  int id;
  String get value;
}

class SelectionPage extends StatefulWidget {
  final String title;
  final List<SelectionModel> values;
  final SelectionModel selectedValue;

  final Function(SelectionModel) wasSelected;

  SelectionPage({
    this.title,
    this.values,
    this.selectedValue,
    this.wasSelected,
  });

  @override
  _SelectionPageState createState() => _SelectionPageState();
}

class _SelectionPageState extends State<SelectionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          widget.title,
          style: CustomThemes.darkGrayGreenTheme.textTheme.subtitle1,
        ),
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.only(left: 20, right: 10),
        child: ListView.separated(
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  widget.wasSelected(widget.values[index]);
                  Navigator.pop(context);
                },
                child: Container(
                  height: 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.values[index].value,
                        style: CustomThemes.authorizationTheme.textTheme.bodyText1,
                      ),
                      widget.values[index].id == widget.selectedValue.id
                          ? Icon(
                              Icons.check,
                              color: CustomColors.darkGreenColor,
                            )
                          : Container(),
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.only(left: 15, right: 15),
                height: 1,
                color: HexColor("#DDDDDD").withOpacity(0.33),
              );
            },
            itemCount: widget.values.length,
        ),
      ),
    );
  }
}
