import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/constants/colors.dart';
import 'package:mobile_app/localization/localization-constants.dart';
import 'package:mobile_app/themes/themes.dart';
import 'package:mobile_app/ui/pages/profile/notifications/notifications-presenter.dart';

import 'package:mobile_app/ui/extensions/custom-widget-extension.dart';

class NotificationsPage extends StatefulWidget {
  @override
  NotificationsPageState createState() => NotificationsPageState();
}

class NotificationsPageState extends State<NotificationsPage> {
  final NotificationsPresenter presenter = NotificationsPresenter();
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    presenter.controller = this;

    presenter.fetchNotifications().then((value) {
      setState(() {});
    });
  }

  NotificationsPageState() {
    _scrollController.addListener(_scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.backgroundLightGrayColor,
        elevation: 0,
        title: Text(
          getTranslated(context, "notifications"),
          style: CustomThemes.darkGrayGreenTheme.textTheme.subtitle1,
        ),
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
            height: MediaQuery.of(context).size.height / 1.3,
            padding: EdgeInsets.only(left: 18, right: 18, top: 20),
            child: ListView.separated(
              controller: _scrollController,
              itemBuilder: (context, index) {
                return Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 100,
                        child: Text(
                          presenter.notifications[index].getTime(),
                          style: CustomThemes.darkGrayGreenTheme.textTheme.headline6,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Expanded(
                        child: Text(presenter.notifications[index].message, style: CustomThemes.darkGrayGreenTheme.textTheme.headline2, textAlign: TextAlign.center),
                      ),
                      SizedBox(width: 10),
                      InkWell(
                        onTap: () {
                          presenter.deleteNotification(presenter.notifications[index].id).then((value) {
                            setState(() {});
                          }).catchError(
                            (error) {
                              showErrorAlert(
                                message: error as String,
                                actions: <CupertinoDialogAction>[
                                  CupertinoDialogAction(
                                    isDefaultAction: true,
                                    child: Text("Ok"),
                                    onPressed: () {
                                      goBack();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Icon(
                          Icons.delete,
                          color: Colors.red[300],
                        ),
                      )
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10, top: 10),
                  child: Container(
                    height: 1,
                    color: CustomColors.darkGrayGreenColor.withOpacity(0.33),
                  ),
                );
              },
              itemCount: presenter.notifications.length,
            ),
          ),
        ),
      ),
    );
  }

  void _scrollListener() {
    var offset = _scrollController.offset;
    var contentSize = _scrollController.position.maxScrollExtent;
    var x = 100 * offset / contentSize;
    if (x >= 80) {
      presenter.fetchNotifications().then((value) {
        setState(() {});
      });
    }
  }
}
