import 'package:flutter/material.dart';
import 'package:mobile_app/constants/colors.dart';

class CustomThemes {
  static final ThemeData authorizationTheme = ThemeData(
    fontFamily: 'Nunito',
    textTheme: TextTheme(
      // For button and description theme
      bodyText1: TextStyle(
          backgroundColor: Colors.transparent,
          color: CustomColors.darkGreenColor,
          fontSize: 16
      ),

      // For title theme
      bodyText2: TextStyle(
        color: CustomColors.darkGreenColor,
        fontSize: 30,
      ),

      // For white button
      subtitle1: TextStyle(
        backgroundColor: CustomColors.darkGreenColor,
        color: Colors.white,
        fontSize: 16,
      ),

      // For placeholder theme in text field
      subtitle2: TextStyle(color: CustomColors.lightGreenColor, fontSize: 18),

      // For text theme in text field
      headline1: TextStyle(color: CustomColors.darkGreenColor, fontSize: 18),

      // For header theme in text field
      headline2: TextStyle(
        color: CustomColors.darkGreenColor, 
        fontSize: 12
      ),

      // For text in currency exchange complete
      headline3: TextStyle(
        color: CustomColors.superLightGreen,
        fontSize: 22,
      ),
    ),
  );

  static final ThemeData darkGrayGreenTheme = ThemeData(
    backgroundColor: Colors.transparent,
    accentColor: CustomColors.darkGrayGreenColor,
    fontFamily: 'Nunito',
    textTheme: TextTheme(
      // For placeholder theme in text field
      bodyText1:
          TextStyle(color: CustomColors.darkGrayGreenColor, fontSize: 14),
      // For headers like 'Transaction History'
      subtitle1: TextStyle(
        color: CustomColors.darkGrayGreenColor,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      // For headers like transaction name and notifications
      headline6: TextStyle(
        color: CustomColors.darkGrayGreenColor,
        fontSize: 15,
      ),
      // For subheaders like transaction source
      subtitle2: TextStyle(
        color: CustomColors.darkGrayGreenColor,
        fontSize: 12,
      ),
      // For transaction time
      headline5: TextStyle(
        color: CustomColors.lightGreenColor,
        fontSize: 11,
      ),
      // For sections in group list
      headline4: TextStyle(
        color: CustomColors.lightGreenColor,
        fontSize: 13,
      ),
      // For transaction detail
      headline3: TextStyle(
        color: Colors.black,
        fontSize: 18,
      ),
      // For cancel button
      headline1: TextStyle(
        color: CustomColors.darkBlueColor,
        fontSize: 20,
      ),

      // For notification message
      headline2: TextStyle(
        color: CustomColors.darkGrayGreenColor,
        fontSize: 15,
        fontWeight: FontWeight.w600,
      ),

      // For menu items
      bodyText2: TextStyle(
        color: CustomColors.darkGreenColor,
        fontSize: 20,
      ),
    ),
  );
}
