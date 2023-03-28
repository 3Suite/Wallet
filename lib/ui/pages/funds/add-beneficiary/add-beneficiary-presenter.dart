import 'dart:convert';

import 'package:mobile_app/network/http-client/http-client-fabric.dart';
import 'package:mobile_app/network/http-client/ihttp-client.dart';
import 'package:mobile_app/ui/pages/funds/add-beneficiary/add-beneficiary.dart';
import 'package:mobile_app/ui/extensions/custom-widget-extension.dart';

class AddBeneficiaryPresenter {
  AddBeneficiaryPageState controller;

  IHttpClient client = HttpClientFactory.getHttpClient();

  Future<void> addBeneficiary(
    String firstName,
    String countryId,
    String address,
    String state,
    String swiftCode,
    String iban,
    bool favourite,
  ) async {
    if (countryId.isEmpty) {
      return Future.error("Please, select country");
    }

    if (swiftCode.isEmpty) {
      return Future.error("Please, fill swift code");
    }

    if (iban.isEmpty) {
      return Future.error("Please, fill IBAN number");
    }

    controller.showActivityIndicator();

    Map<String, dynamic> data = {
      "firstName": firstName,
      "countryId": countryId,
      "address": address,
      "state": state,
      "swiftCode": swiftCode,
      "iban": iban,
    };

    var rawJson = await client.postRawResponse("beneficiaries", data);

    if (rawJson == null) {
      controller.hideActivityIndicator();
      return Future.error("Internal error. Please contact support");
    }

    var serverJson = json.decode(rawJson);

    var status = false;
    try {
      status = serverJson;
    } catch (error) {
      controller.hideActivityIndicator();
      return Future.error(error);
    }

    if (status) {
      controller.hideActivityIndicator();
    } else {
      controller.hideActivityIndicator();
      return Future.error("Internal error. Please contact support");
    }
  }
}
