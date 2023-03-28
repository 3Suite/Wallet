import 'package:flutter/material.dart';
import 'package:mobile_app/constants/colors.dart';
import 'package:mobile_app/localization/localization-constants.dart';
import 'package:mobile_app/main.dart';
import 'package:mobile_app/themes/themes.dart';
import 'package:mobile_app/ui/pages/kyc-verification/kyc-verification.dart';
import 'package:mobile_app/ui/pages/profile/change-password/change-password.dart';
import 'package:mobile_app/ui/pages/profile/notifications/notifications.dart';
import 'package:mobile_app/ui/pages/user-menu/language.dart';
import 'package:mobile_app/ui/pages/user-menu/user-menu-presenter.dart';

class UserMenuPage extends StatefulWidget {
  @override
  UserMenuPageState createState() => UserMenuPageState();
}

class UserMenuPageState extends State<UserMenuPage> {
  final UserMenuPresenter presenter = UserMenuPresenter();

  @override
  void initState() {
    super.initState();

    presenter.controller = this;
  }

  void _changeLanguage(Language language) {
    Locale locale;
    switch (language.languageCode) {
      case 'en':
        locale = Locale(language.languageCode, 'US');
        break;

      case 'es':
        locale = Locale(language.languageCode, 'ES');
        break;
    }

    MyApp.setLocale(context, locale);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.backgroundLightGrayColor,
        elevation: 0,
        title: Text(
          getTranslated(context, "user-menu"),
          style: CustomThemes.darkGrayGreenTheme.textTheme.subtitle1,
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 18),
            child: DropdownButton(
              onChanged: (Language language) {
                _changeLanguage(language);
              },
              underline: SizedBox(),
              icon: Icon(
                Icons.language,
                color: CustomColors.darkGreenColor,
              ),
              items: Language.languages()
                  .map<DropdownMenuItem<Language>>(
                    (language) => DropdownMenuItem(
                      value: language,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            language.name,
                            style: CustomThemes.darkGrayGreenTheme.textTheme.subtitle1,
                          ),
                          Text(
                            language.flag,
                          )
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
        iconTheme: IconThemeData(
          color: CustomColors.darkGrayGreenColor,
        ),
      ),
      body: Container(
        color: CustomColors.backgroundLightGrayColor,
        child: Container(
          margin: EdgeInsets.only(left: 18, right: 18, top: 20),
          padding: EdgeInsets.only(top: 10, bottom: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 5,
                blurRadius: 20,
              )
            ],
          ),
          child: Container(
            height: 200,
            padding: EdgeInsets.only(left: 18, right: 18, top: 20),
            child: ListView(
              physics: const NeverScrollableScrollPhysics(),
              children: [
                Center(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => KYCVerificationPage(),
                        ),
                      );
                    },
                    child: Text(
                      getTranslated(context, "kyc-verification"),
                      style: CustomThemes.darkGrayGreenTheme.textTheme.bodyText2,
                    ),
                  ),
                ),
                _getSeparator(),
                Center(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChangePasswordPage(),
                        ),
                      );
                    },
                    child: Text(
                      getTranslated(context, "change-password"),
                      style: CustomThemes.darkGrayGreenTheme.textTheme.bodyText2,
                    ),
                  ),
                ),
                _getSeparator(),
                Center(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NotificationsPage(),
                        ),
                      );
                    },
                    child: Text(
                      getTranslated(context, "notifications"),
                      style: CustomThemes.darkGrayGreenTheme.textTheme.bodyText2,
                    ),
                  ),
                ),
                _getSeparator(),
                InkWell(
                  onTap: () {
                    presenter.logout(context);
                  },
                  child: Center(
                    child: Text(getTranslated(context, "logout"),
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 20,
                        )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _getSeparator() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, top: 10),
      child: Container(
        height: 1,
        color: CustomColors.darkGrayGreenColor.withOpacity(0.33),
      ),
    );
  }
}
