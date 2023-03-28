import 'dart:convert';

import 'package:mobile_app/network/http-client/http-client-fabric.dart';
import 'package:mobile_app/network/http-client/ihttp-client.dart';
import 'package:mobile_app/models/notification-model.dart';
import 'package:mobile_app/ui/pages/profile/notifications/notifications.dart';
import 'package:mobile_app/ui/extensions/custom-widget-extension.dart';

class NotificationsPresenter {
  IHttpClient client = HttpClientFactory.getHttpClient();

  NotificationsPageState controller;

  List<NotificationModel> notifications = new List<NotificationModel>();

  final int _limit = 20;
  int _currentPage = -1;
  bool isBusy = false;
  bool canContinue = true;

  Future<void> fetchNotifications() async {
    if (!canContinue) {
      // -ER- We don't try to fetch more notifications if any error happened once
      return;
    }

    if (isBusy) {
      return;
    }
    isBusy = true;

    try {
      _currentPage += 1;

      var rawJson = await client.getRawResponse("notification", "size=$_limit&page=$_currentPage");
      var serverJson = json.decode(rawJson);

      for (int i = 0; i < serverJson.length; i++) {
        notifications.add(NotificationModel.fromJson(serverJson[i]));
      }
    } catch (error) {
      _currentPage -= 1;
      canContinue = false;
      return Future.error(error);
    } finally {
      isBusy = false;
    }
  }

  Future<void> deleteNotification(int id) async {
    controller.showActivityIndicator();

    try {
      await client.deleteRawResponse("notification/$id");
      notifications.removeWhere((n) => n.id == id);
    } catch (error) {
      return Future.error(error);
    } finally {
      controller.hideActivityIndicator();
    }
  }
}
