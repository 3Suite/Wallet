import 'package:flutter/material.dart';
import 'package:mobile_app/constants/colors.dart';
import 'package:mobile_app/network/http-client/http-client-fabric.dart';
import 'package:mobile_app/ui/navigation-bar/bottom-navigation-bar.dart';
import 'package:mobile_app/ui/pages/authorization/sign-in/sign-in.dart';
import 'package:mobile_app/ui/pages/dashboard/dashboard-presenter.dart';
import 'package:mobile_app/utilities/hex-color.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoadingPage extends StatefulWidget {
  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = new AnimationController(vsync: this, duration: new Duration(seconds: 1));
    Tween tween = new Tween<double>(begin: 3.0, end: 235);
    animation = tween.animate(controller);

    animation.addListener(() {
      setState(() {});
    });

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        controller.forward();
      }
    });

    controller.forward();

    _checkToken();
  }

  @override
  void dispose() {
    controller.stop();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(
            color: CustomColors.backgroundColor,
            image: DecorationImage(
              image: AssetImage(
                "images/background-authorization.png",
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  SizedBox(height: 10),
                  Container(
                    alignment: Alignment.center,
                    child: Image.asset(
                      "images/logo.png",
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  Column(
                    //crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        height: 14,
                        width: 245,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: HexColor("#DDDDDD"),
                        ),
                        margin: EdgeInsets.only(left: 20, right: 20),
                        child: new Stack(
                          children: [
                            Positioned(
                              top: 3,
                              left: animation.value,
                              child: Container(
                                width: 10,
                                height: 8,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: HexColor("#404CB3"),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 30),
                      Text(
                        "${DateTime.now().year}. All rights reserved",
                        style: TextStyle(
                          color: CustomColors.darkGrayGreenColor,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _checkToken() async {
    // Check token. If it's valid try to retake it and then show the dashboard page to customer
    // If it's not valid show the sign in page to customer
    try {
      // Check current token
      var client = HttpClientFactory.getHttpClient();
      var rawJson = await client.getRawResponse("/wallet/all");
      if (rawJson == null) {
        NullThrownError();
      }

      // Token is valid. Let's fetch user profile and countries
      var dashboardPresenter = DashboardPresenter();
      await dashboardPresenter.fetchUser();
      await dashboardPresenter.fetchCountries();

      // Everything is ok, go to dashboard page
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (c) => BotttomNavigationBar()));
    } catch (e) {
      // Something went wrong. Show sign in page
      print(e);

      // -AK- Server send 500 on checking request, which help our to understand accessToken is valid or not,
      // so i always remove accessToken from preferences to avoid login error on sign-in
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (prefs.containsKey("accessToken")) {
        prefs.remove("accessToken");
      }
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (c) => SignInPage()));
    }
  }
}
