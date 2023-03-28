import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_app/constants/colors.dart';
import 'package:mobile_app/localization/localization-constants.dart';
import 'package:mobile_app/themes/themes.dart';
import 'package:mobile_app/ui/common-widgets/load-image-container.dart';
import 'package:mobile_app/ui/pages/kyc-verification/kyc-verification-presenter.dart';
import 'package:mobile_app/ui/extensions/custom-widget-extension.dart';

class KYCVerificationPage extends StatefulWidget {
  @override
  KYCVerificationPageState createState() => KYCVerificationPageState();
}

class KYCVerificationPageState extends State<KYCVerificationPage> {
  final picker = ImagePicker();

  final KYCVerificationPresenter presenter = KYCVerificationPresenter();

  @override
  void initState() {
    super.initState();

    presenter.controller = this;

    presenter.getAllKYC().then((value) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.backgroundLightGrayColor,
        elevation: 0,
        title: Text(
          getTranslated(context, "kyc-verification"),
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
            height: MediaQuery.of(context).size.height / 2.5,
            padding: EdgeInsets.only(left: 18, right: 18, top: 20),
            child: ListView(
              scrollDirection: Axis.vertical,
              children: [
                Text(
                  getTranslated(context, "upload-kyc-information-for-verification"),
                  style: CustomThemes.authorizationTheme.textTheme.headline1,
                ),
                SizedBox(height: 5),
                Text(
                  getTranslated(context, "max-size"),
                  style: TextStyle(
                    fontFamily: "Nunito",
                    fontWeight: FontWeight.w600,
                    color: CustomColors.darkGreenColor,
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    LoadImageContainer(
                      header: getTranslated(context, "passport-frontpage"),
                      headerStyle: CustomThemes.authorizationTheme.textTheme.headline2,
                      status: presenter.getKYCStatus(context, 1),
                      description: presenter.getDescription(1),
                      descriptionStyle: CustomThemes.authorizationTheme.textTheme.headline2,
                      tap: () async {
                        if (!presenter.canUploadImage(1)) {
                          return;
                        }
                        var pickedFile = await picker.getImage(
                          source: ImageSource.camera,
                          imageQuality: 60,
                          preferredCameraDevice: CameraDevice.rear,
                        );

                        if (pickedFile == null) {
                          return;
                        }
                        var file = File(pickedFile.path);
                        if (file == null) {
                          return;
                        }
                        var size = await file.length();
                        print("### File size = $size");
                        presenter.uploadImage("1", file).then((value) {
                          presenter.getAllKYC().then((value) {
                            setState(() {});
                          }).catchError((error) {
                            showErrorAlert(
                              message: error,
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
                          });
                        }).catchError((error) {
                          showErrorAlert(
                            message: error,
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
                        });
                      },
                    ),
                    LoadImageContainer(
                      header: getTranslated(context, "utility-bill"),
                      headerStyle: CustomThemes.authorizationTheme.textTheme.headline2,
                      status: presenter.getKYCStatus(context, 2),
                      description: presenter.getDescription(2),
                      descriptionStyle: CustomThemes.authorizationTheme.textTheme.headline2,
                      tap: () async {
                        if (!presenter.canUploadImage(2)) {
                          return;
                        }
                        var pickedFile = await picker.getImage(
                          source: ImageSource.camera,
                          imageQuality: 60,
                          preferredCameraDevice: CameraDevice.rear,
                        );

                        if (pickedFile == null) {
                          return;
                        }
                        var file = File(pickedFile.path);
                        if (file == null) {
                          return;
                        }
                        var size = await file.length();
                        print("### File size = $size");
                        presenter.uploadImage("2", file).then((value) {
                          presenter.getAllKYC().then((value) {
                            setState(() {});
                          }).catchError((error) {
                            showErrorAlert(
                              message: error,
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
                          });
                        }).catchError((error) {
                          showErrorAlert(
                            message: error,
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
                        });
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    LoadImageContainer(
                      header: getTranslated(context, "photo-upload"),
                      headerStyle: CustomThemes.authorizationTheme.textTheme.headline2,
                      status: presenter.getKYCStatus(context, 3),
                      description: presenter.getDescription(3),
                      descriptionStyle: CustomThemes.authorizationTheme.textTheme.headline2,
                      tap: () async {
                        if (!presenter.canUploadImage(3)) {
                          return;
                        }
                        var pickedFile = await picker.getImage(
                          source: ImageSource.camera,
                          imageQuality: 60,
                          preferredCameraDevice: CameraDevice.front,
                        );

                        if (pickedFile == null) {
                          return;
                        }
                        var file = File(pickedFile.path);
                        if (file == null) {
                          return;
                        }
                        var size = await file.length();
                        print("### File size = $size");
                        presenter.uploadImage("3", file).then((value) {
                          presenter.getAllKYC().then((value) {
                            setState(() {});
                          }).catchError((error) {
                            showErrorAlert(
                              message: error,
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
                          });
                        }).catchError((error) {
                          showErrorAlert(
                            message: error,
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
                        });
                      },
                    ),
                    LoadImageContainer(
                      header: getTranslated(context, "national-id"),
                      headerStyle: CustomThemes.authorizationTheme.textTheme.headline2,
                      status: presenter.getKYCStatus(context, 4),
                      description: presenter.getDescription(4),
                      descriptionStyle: CustomThemes.authorizationTheme.textTheme.headline2,
                      tap: () async {
                        if (!presenter.canUploadImage(4)) {
                          return;
                        }
                        var pickedFile = await picker.getImage(
                          source: ImageSource.camera,
                          imageQuality: 60,
                          preferredCameraDevice: CameraDevice.rear,
                        );

                        if (pickedFile == null) {
                          return;
                        }
                        var file = File(pickedFile.path);
                        if (file == null) {
                          return;
                        }
                        var size = await file.length();
                        print("### File size = $size");
                        presenter.uploadImage("4", file).then((value) {
                          presenter.getAllKYC().then((value) {
                            setState(() {});
                          }).catchError((error) {
                            showErrorAlert(
                              message: error,
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
                          });
                        }).catchError((error) {
                          showErrorAlert(
                            message: error,
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
                        });
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
