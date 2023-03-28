import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/constants/models-storage.dart';
import 'package:mobile_app/localization/localization-constants.dart';
import 'package:mobile_app/network/http-client/http-client-fabric.dart';
import 'package:mobile_app/network/http-client/ihttp-client.dart';
import 'package:mobile_app/ui/pages/kyc-verification/kyc-short-info-model.dart';
import 'package:mobile_app/ui/pages/kyc-verification/kyc-verification.dart';

import 'package:mobile_app/ui/extensions/custom-widget-extension.dart';

class KYCVerificationPresenter {
  KYCVerificationPageState controller;

  IHttpClient client = HttpClientFactory.getHttpClient();

  List<int> neededKYCIds = [
    1, // passport
    2, // utility bill
    3, // photo
    4 // national id
  ];

  List<KYCShortInfoModel> neededKYC = List<KYCShortInfoModel>();

  String translationKey = "msg.";

  Future<void> getAllKYC() async {
    var rawJson = await client.getRawResponse("kyc/lastSavedDocument");
    var serverJson = json.decode(rawJson);
    List<KYCShortInfoModel> kycList = new List<KYCShortInfoModel>();
    try {
      for (int i = 0; i < serverJson.length; i++) {
        kycList.add(KYCShortInfoModel.fromJson(serverJson[i]));
      }
      neededKYC = kycList;
    } catch (error) {
      return Future.error(error);
    }
  }

  Future<void> uploadImage(String id, File file) async {
    if (file == null) {
      return Future.error("Can't read file");
    }

    controller.showActivityIndicator();
    var rawJson;
    try {
      rawJson = await client.upload("kyc/$id", file);
    } catch (error) {
      controller.hideActivityIndicator();
      return Future.error(error);
    }
    if (rawJson == null) {
      controller.hideActivityIndicator();
      return Future.error("Internal error. Please contact support");
    }
    var answer;
    try {
      answer = rawJson;
    } catch (error) {
      controller.hideActivityIndicator();
      return Future.error(error);
    }
    if (answer == null) {
      controller.hideActivityIndicator();
      return Future.error("Your file is very large. Please contact support");
    }
    if (answer) {
      controller.hideActivityIndicator();
      controller.showErrorAlert(
        title: "",
        message: "Document uploaded successfully",
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            isDefaultAction: true,
            child: Text("Ok"),
            onPressed: () {
              controller.goBack();
            },
          ),
        ],
      );
      neededKYC = [];
    } else {
      controller.hideActivityIndicator();
      return Future.error("Your file is very large. Please contact support");
    }
  }

  String getKYCStatus(BuildContext context, int id) {
    if (neededKYC == null) {
      return "";
    }
    if (!neededKYC.map((e) => e.documentTypeId).contains(id)) {
      return getTranslated(context, "upload");
    }
    var kyc = neededKYC.firstWhere((element) => element.documentTypeId == id);
    if (kyc == null) {
      return "";
    }
    if (kyc.isApproved == false && kyc.isRejected == false) {
      return getTranslated(context, "pending");
    } else if (kyc.isApproved == true) {
      return getTranslated(context, "approved");
    } else if (kyc.isRejected == true) {
      return getTranslated(context, "rejected");
    }
    return "";
  }

  String getDescription(int id) {
    if (neededKYC == null) {
      return "";
    }
    if (!neededKYC.map((e) => e.documentTypeId).contains(id)) {
      return "";
    }
    var kyc = neededKYC.firstWhere((element) => element.documentTypeId == id);
    if (kyc == null) {
      return "";
    }
    if (kyc.isRejected == false) {
      return "";
    }
    var error = kyc.rejectReason;
    if (error.contains(translationKey)) {
      if (ModelsStorage.translations.keys.contains(error)) {
        return ModelsStorage.translations[error];
      }
      return "";
    }
    return error;
  }

  bool canUploadImage(int id) {
    if (neededKYC == null) {
      return false;
    }
    if (!neededKYC.map((e) => e.documentTypeId).contains(id)) {
      return true;
    }
    if (ModelsStorage.user.isDocsApproved()) {
      return false;
    }
    var kyc = neededKYC.firstWhere((element) => element.documentTypeId == id);
    if (kyc == null) {
      return false;
    }
    if (kyc.isRejected == true || (kyc.isApproved == null && kyc.isRejected == null)) {
      return true;
    }
    return false;
  }
}
