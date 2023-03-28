import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:mobile_app/models/country-model.dart';
import 'package:mobile_app/network/http-client/http-client-fabric.dart';
import 'package:mobile_app/network/http-client/ihttp-client.dart';
import 'package:mobile_app/ui/pages/dashboard/dashboard-presenter.dart';
import 'package:mobile_app/ui/pages/profile/user-profile/user-profile.dart';
import 'package:mobile_app/ui/extensions/custom-widget-extension.dart';

class UserProfilePresenter {
  UserProfilePageState controller;

  IHttpClient client = HttpClientFactory.getHttpClient();
  var presenter = DashboardPresenter();

  Future<void> updateUserProfile(
    String firstName,
    String secondName,
    CountryModel country,
    String city,
    String address,
    DateTime birthDate,
  ) async {
    controller.showActivityIndicator();

    Map<String, dynamic> data = {
      "firstName": firstName,
      "secondName": secondName,
      "city": city,
      "address": address,
    };

    if (country != null) {
      data["countryId"] = country.id;
    }

    if (birthDate != null) {
      var dateString = convertDateToStringForServer(birthDate);
      data["birthDate"] = dateString;
    }

    var rawJson = await client.postRawResponse("profile/write", data);

    if (rawJson == null) {
      controller.hideActivityIndicator();
      return Future.error("Internal error. Please contact support");
    }

    var serverJson = json.decode(rawJson);

    bool status = false;
    try {
      status = serverJson["st"] == 1 ? true : false;
    } catch (error) {
      controller.hideActivityIndicator();
      return Future.error(error);
    }

    if (status) {
      presenter.fetchUser().then((value) {
        controller.hideActivityIndicator();
      }).catchError((error) {
        controller.hideActivityIndicator();
        return Future.error(error);
      });
    } else {
      controller.hideActivityIndicator();
      return Future.error("Internal error. Please contact support");
    }
  }

  String convertDateToStringForServer(DateTime date) {
    DateFormat dateFormat = DateFormat("dd/MM/yyyy");
    return dateFormat.format(date);
  }
}
