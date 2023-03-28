import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:mobile_app/constants/models-storage.dart';
import 'package:mobile_app/localization/localization-constants.dart';
import 'package:mobile_app/models/country-model.dart';
import 'package:mobile_app/themes/themes.dart';
import 'package:mobile_app/constants/colors.dart';
import 'package:mobile_app/ui/common-widgets/custom-button.dart';
import 'package:mobile_app/ui/common-widgets/selection-container-with-header.dart';
import 'package:mobile_app/ui/common-widgets/selection-page.dart';
import 'package:mobile_app/ui/common-widgets/text-field-with-header.dart';
import 'package:mobile_app/ui/pages/profile/user-profile/user-profile-presenter.dart';
import 'package:mobile_app/ui/pages/user-menu/user-menu.dart';
import 'package:mobile_app/utilities/hex-color.dart';

class UserProfilePage extends StatefulWidget {
  @override
  UserProfilePageState createState() => UserProfilePageState();
}

class UserProfilePageState extends State<UserProfilePage> {
  String firstName = "";
  String secondName = "";
  CountryModel country;
  String city = "";
  String address = "";
  String email = "";
  String phone = "";
  DateTime birthDate;

  final UserProfilePresenter presenter = UserProfilePresenter();

  @override
  void initState() {
    super.initState();

    presenter.controller = this;

    if (ModelsStorage.user != null) {
      if (ModelsStorage.user.firstName.isNotEmpty) {
        firstName = ModelsStorage.user.firstName;
      }
      if (ModelsStorage.user.secondName.isNotEmpty) {
        secondName = ModelsStorage.user.secondName;
      }
      if (ModelsStorage.user.countryId != null && ModelsStorage.countries != null) {
        country = ModelsStorage.countries.firstWhere((element) => element.id == ModelsStorage.user.countryId);
      }
      if (ModelsStorage.user.city.isNotEmpty) {
        city = ModelsStorage.user.city;
      }
      if (ModelsStorage.user.address.isNotEmpty) {
        address = ModelsStorage.user.address;
      }
      if (ModelsStorage.user.email.isNotEmpty) {
        email = ModelsStorage.user.email;
      }
      if (ModelsStorage.user.phone.isNotEmpty) {
        phone = ModelsStorage.user.phone;
      }
      if (ModelsStorage.user.birthDate.isNotEmpty) {
        birthDate = DateFormat('dd/MM/yyyy').parse(ModelsStorage.user.birthDate);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.backgroundLightGrayColor,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserMenuPage(),
                  ),
                );
              },
              child: Image.asset("images/menu-icon.png"),
            ),
            Container(
              child: Row(
                children: [
                  Text(
                    getTranslated(context, "my-profile"),
                    style: CustomThemes.darkGrayGreenTheme.textTheme.subtitle1,
                  ),
                  SizedBox(width: 5),
                  ModelsStorage.user.isDocsApproved()
                      ? Icon(
                          Icons.check_circle,
                          color: HexColor("#3BAC2D"),
                        )
                      : Icon(
                          Icons.cancel,
                          color: HexColor("#C52D2B"),
                        ),
                  Text(
                    " - " + getTranslated(context, "verified"),
                    style: CustomThemes.darkGrayGreenTheme.textTheme.subtitle1,
                  )
                ],
              ),
            ),
            Container(),
          ],
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
            height: MediaQuery.of(context).size.height / 1.3,
            padding: EdgeInsets.only(left: 18, right: 18, top: 20),
            child: ListView(
              scrollDirection: Axis.vertical,
              children: [
                TextFieldWithHeader(
                  header: getTranslated(context, "first-name"),
                  headerStyle: CustomThemes.authorizationTheme.textTheme.headline2,
                  text: firstName,
                  textStyle: CustomThemes.authorizationTheme.textTheme.bodyText1,
                  placeholderText: "Enter First Name",
                  placeholderStyle: CustomThemes.darkGrayGreenTheme.textTheme.headline6,
                  textChanged: (firstName) {
                    this.firstName = firstName;
                  },
                ),
                SizedBox(height: 15),
                TextFieldWithHeader(
                  header: getTranslated(context, "last-name"),
                  headerStyle: CustomThemes.authorizationTheme.textTheme.headline2,
                  text: secondName,
                  textStyle: CustomThemes.authorizationTheme.textTheme.bodyText1,
                  placeholderText: getTranslated(context, "enter-last-name"),
                  placeholderStyle: CustomThemes.darkGrayGreenTheme.textTheme.headline6,
                  textChanged: (secondName) {
                    this.secondName = secondName;
                  },
                ),
                SizedBox(height: 15),
                SelectionContainerWithHeader(
                    header: getTranslated(context, "country"),
                    headerStyle: CustomThemes.authorizationTheme.textTheme.headline2,
                    text: country == null ? "" : country.niceName,
                    textStyle: CustomThemes.authorizationTheme.textTheme.bodyText1,
                    placeholderText: getTranslated(context, "select-country"),
                    placeholderStyle: CustomThemes.darkGrayGreenTheme.textTheme.headline6,
                    onTap: () {
                      var page = SelectionPage(
                        title: getTranslated(context, "select-country"),
                        values: ModelsStorage.countries,
                        selectedValue: country == null ? CountryModel() : country,
                        wasSelected: (selectedCountry) {
                          setState(() {
                            this.country = selectedCountry as CountryModel;
                          });
                        },
                      );
                      Navigator.of(context).push(
                        CupertinoPageRoute(
                          fullscreenDialog: true,
                          builder: (context) => page,
                        ),
                      );
                    }),
                SizedBox(height: 15),
                SelectionContainerWithHeader(
                    header: getTranslated(context, "date-of-birth-title"),
                    headerStyle: CustomThemes.authorizationTheme.textTheme.headline2,
                    text: _getStringDateTime(birthDate),
                    textStyle: CustomThemes.authorizationTheme.textTheme.bodyText1,
                    placeholderText: getTranslated(context, "date-of-birth-placeholder"),
                    placeholderStyle: CustomThemes.darkGrayGreenTheme.textTheme.headline6,
                    onTap: () {
                      DatePicker.showDatePicker(
                        context,
                        showTitleActions: true,
                        theme: DatePickerTheme(),
                        onConfirm: (date) {
                          setState(() {
                            birthDate = date;
                          });
                        },
                        currentTime: birthDate,
                      );
                    }),
                SizedBox(height: 15),
                TextFieldWithHeader(
                  header: getTranslated(context, "city"),
                  headerStyle: CustomThemes.authorizationTheme.textTheme.headline2,
                  text: city,
                  textStyle: CustomThemes.authorizationTheme.textTheme.bodyText1,
                  placeholderText: getTranslated(context, "enter-city"),
                  placeholderStyle: CustomThemes.darkGrayGreenTheme.textTheme.headline6,
                  textChanged: (city) {
                    this.city = city;
                  },
                ),
                SizedBox(height: 15),
                TextFieldWithHeader(
                  header: getTranslated(context, "address"),
                  headerStyle: CustomThemes.authorizationTheme.textTheme.headline2,
                  text: address,
                  textStyle: CustomThemes.authorizationTheme.textTheme.bodyText1,
                  placeholderText: getTranslated(context, "enter-address"),
                  placeholderStyle: CustomThemes.darkGrayGreenTheme.textTheme.headline6,
                  textChanged: (address) {
                    this.address = address;
                  },
                ),
                SizedBox(height: 15),
                TextFieldWithHeader(
                  header: getTranslated(context, "email"),
                  headerStyle: CustomThemes.authorizationTheme.textTheme.headline2,
                  text: email,
                  textStyle: CustomThemes.authorizationTheme.textTheme.bodyText1,
                  placeholderText: getTranslated(context, "enter-your-email"),
                  placeholderStyle: CustomThemes.darkGrayGreenTheme.textTheme.headline6,
                  textChanged: (email) {
                    this.email = email;
                  },
                  isDisable: ModelsStorage.user.email.isNotEmpty,
                ),
                SizedBox(height: 15),
                TextFieldWithHeader(
                  header: getTranslated(context, "mobile-phone"),
                  headerStyle: CustomThemes.authorizationTheme.textTheme.headline2,
                  text: phone,
                  textStyle: CustomThemes.authorizationTheme.textTheme.bodyText1,
                  placeholderText: getTranslated(context, "enter-mobile-phone"),
                  placeholderStyle: CustomThemes.darkGrayGreenTheme.textTheme.headline6,
                  textChanged: (phone) {
                    this.phone = phone;
                  },
                  keyboardType: TextInputType.phone,
                  isDisable: ModelsStorage.user.phone.isNotEmpty,
                ),
                SizedBox(height: 20),
                Center(
                  child: CustomButton(
                    text: getTranslated(context, "save").toUpperCase(),
                    style: CustomThemes.authorizationTheme.textTheme.subtitle1,
                    tappedCallback: () async {
                      print("Save");
                      await presenter.updateUserProfile(
                        firstName,
                        secondName,
                        country,
                        city,
                        address,
                        birthDate,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _getStringDateTime(DateTime date) {
    if (date == null) {
      return "";
    }
    var result = DateFormat("${DateFormat.ABBR_WEEKDAY}, ${DateFormat.ABBR_MONTH} ${DateFormat.DAY}, ${DateFormat.YEAR}").format(date);
    return result;
  }
}
