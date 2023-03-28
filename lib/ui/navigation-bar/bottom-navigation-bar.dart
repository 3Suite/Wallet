import 'package:flutter/material.dart';
import 'package:mobile_app/constants/colors.dart';
import 'package:mobile_app/localization/localization-constants.dart';
import 'package:mobile_app/ui/pages/dashboard/dashboard-page.dart';
import 'package:mobile_app/ui/pages/deposit-funds/deposit-funds-page.dart';
import 'package:mobile_app/ui/pages/profile/user-profile/user-profile.dart';
import 'package:mobile_app/ui/pages/transfer/currency-exchange/currency-exchange.dart';
import 'package:mobile_app/ui/pages/send-funds/send-funds-page.dart';

class BarItem {
  final String title;
  final String imagePath;

  BarItem({this.title, this.imagePath});
}

class BotttomNavigationBar extends StatefulWidget {
  @override
  _BotttomNavigationBarState createState() => _BotttomNavigationBarState();
}

class _BotttomNavigationBarState extends State<BotttomNavigationBar> {
  var selectedItemIndex = 0;

  List<Widget> pages = [
    DashboardPage(),
    SendFundsPage(),
    DepositFundsPage(),
    CurrencyExchange(),
    UserProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    List<BarItem> barItems = [
      BarItem(
          title: getTranslated(context, "dashboard"),
          imagePath: "images/dashboard-icon.png"),
      BarItem(
          title: getTranslated(context, "send-funds"),
          imagePath: "images/funds-icon.png"),
      BarItem(
          title: getTranslated(context, "deposit"),
          imagePath: "images/deposit-icon.png"),
      BarItem(
          title: getTranslated(context, "exchange"),
          imagePath: "images/transfer-icon.png"),
      BarItem(
          title: getTranslated(context, "my-profile"),
          imagePath: "images/profile-icon.png"),
    ];

    List<Widget> _buildBarItems() {
      List<Widget> _barItems = List();

      for (int i = 0; i < barItems.length; i++) {
        BarItem item = barItems[i];
        bool isSelected = selectedItemIndex == i;

        _barItems.add(
          InkWell(
            splashColor: Colors.transparent,
            onTap: () {
              setState(() {
                selectedItemIndex = i;
              });
            },
            child: Container(
              width: MediaQuery.of(context).size.width / 5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 25,
                    child: Image.asset(
                      item.imagePath,
                      color: isSelected
                          ? CustomColors.darkGreenColor
                          : CustomColors.lightGreenColor,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    item.title,
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 11,
                      color: isSelected
                          ? CustomColors.darkGreenColor
                          : CustomColors.lightGreenColor,
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ),
        );
      }
      return _barItems;
    }

    return Scaffold(
      extendBody: true,
      body: AnimatedContainer(
        curve: Curves.easeInOut,
        duration: const Duration(milliseconds: 2000),
        child: pages[selectedItemIndex],
      ),
      bottomNavigationBar: Container(
        alignment: Alignment.bottomCenter,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 10,
        margin: EdgeInsets.only(top: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 20,
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: _buildBarItems(),
        ),
      ),
    );
  }
}
