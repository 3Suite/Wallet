import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/constants/colors.dart';
import 'package:mobile_app/localization/localization-constants.dart';
import 'package:mobile_app/models/beneficiary-model.dart';
import 'package:mobile_app/models/card-model.dart';
import 'package:mobile_app/themes/themes.dart';
import 'package:mobile_app/ui/common-widgets/cards-list-widget.dart';
import 'package:mobile_app/ui/common-widgets/custom-button.dart';
import 'package:mobile_app/ui/common-widgets/load-image-container.dart';
import 'package:mobile_app/ui/common-widgets/text-field-with-header.dart';
import 'package:mobile_app/ui/pages/authorization/code-entering/code-entering.dart';
import 'package:mobile_app/ui/pages/authorization/code-entering/send-funds-code-entering-presenter.dart';
import 'package:mobile_app/ui/pages/funds-menu/funds-menu.dart';
import 'package:mobile_app/ui/pages/send-funds/send-funds-presenter.dart';
import 'package:simple_autocomplete_formfield/simple_autocomplete_formfield.dart';
import 'package:mobile_app/ui/extensions/custom-widget-extension.dart';
import 'package:image_picker/image_picker.dart';

class SendFundsPage extends StatefulWidget {
  @override
  _SendFundsPageState createState() => _SendFundsPageState();
}

class _SendFundsPageState extends State<SendFundsPage> {
  final SendFundsPresenter presenter = SendFundsPresenter();

  bool isFavoritesLoading = true;

  final picker = ImagePicker();
  File localFile;

  _SendFundsPageState() {
    _loadInfo();
  }

  Future<void> _loadInfo() async {
    setState(() {
      isFavoritesLoading = true;
    });
    try {
      await presenter.loadBeneficiaries();
    } finally {
      setState(() {
        isFavoritesLoading = false;
      });
    }
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    var appBar = AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FundsMenuPage(),
                ),
              );
            },
            child: Image.asset("images/menu-icon.png"),
          ),
          Text(
            getTranslated(context, "send-funds"),
            style: CustomThemes.darkGrayGreenTheme.textTheme.subtitle1,
          ),
          Container(),
        ],
      ),
      elevation: 0,
      backgroundColor: Colors.white,
    );

    return Scaffold(
      appBar: appBar,
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CardsList(
                presenter: presenter,
                cardSelectedCallback: _processSelectedCard,
              ),
              SizedBox(height: 35),
              // ----- Central container -----
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 15, right: 15),
                  padding: EdgeInsets.all(16),
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
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // ----- Beneficiary -----
                        Text(
                          getTranslated(context, "beneficiary"),
                          style: CustomThemes.darkGrayGreenTheme.textTheme.subtitle2,
                        ),
                        SizedBox(height: 6),
                        SimpleAutocompleteFormField<BeneficiaryModel>(
                          itemBuilder: (c, beneficiary) {
                            return buildBeneficiaryCell(beneficiary);
                          },
                          onSearch: (searchText) async {
                            return presenter.getBeneficiaries(searchText);
                          },
                          initialValue: presenter.selectedBeneficiary,
                          itemToString: (b) {
                            if (b == null) {
                              return "";
                            }
                            presenter.selectedBeneficiary = b;
                            return b.firstName;
                          },
                          onFieldSubmitted: (b) {
                            print("1");
                            presenter.selectedBeneficiary = b;
                          },
                          onSaved: (beneficary) {
                            print("2");
                            presenter.selectedBeneficiary = beneficary;
                          },
                          // ----- Text Field props -----
                          controller: TextEditingController(text: getBeneficiaryName()),
                          style: CustomThemes.darkGrayGreenTheme.textTheme.headline3,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(10),
                            hintText: getTranslated(context, "search"),
                            hintStyle: CustomThemes.darkGrayGreenTheme.textTheme.headline4,
                            filled: true,
                            fillColor: Colors.white,
                            focusColor: CustomColors.lightGreenColor,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                              borderSide: BorderSide(
                                color: CustomColors.lightGreenColor,
                                width: 1,
                                style: BorderStyle.solid,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                              borderSide: BorderSide(
                                width: 1,
                                color: CustomColors.lightGreenColor,
                                style: BorderStyle.none,
                              ),
                            ),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        // ----- Amount -----
                        SizedBox(height: 12),
                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.center, children: [
                          Expanded(
                            child: TextFieldWithHeader(
                              header: getTranslated(context, "amount"),
                              headerStyle: CustomThemes.darkGrayGreenTheme.textTheme.subtitle2,
                              textStyle: CustomThemes.darkGrayGreenTheme.textTheme.headline3,
                              placeholderStyle: CustomThemes.darkGrayGreenTheme.textTheme.headline4,
                              placeholderText: getTranslated(context, "enter-amount"),
                              text: presenter.amount,
                              keyboardType: TextInputType.phone,
                              textChanged: (amount) {
                                presenter.amount = amount;
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20, left: 10),
                            child: Text(
                              presenter.getCardSign(),
                              style: CustomThemes.authorizationTheme.textTheme.bodyText1,
                            ),
                          ),
                        ]),
                        // ----- Transfer note -----
                        SizedBox(height: 12),
                        TextFieldWithHeader(
                          header: getTranslated(context, "note-for-transfer"),
                          headerStyle: CustomThemes.darkGrayGreenTheme.textTheme.subtitle2,
                          textStyle: CustomThemes.darkGrayGreenTheme.textTheme.headline3,
                          placeholderStyle: CustomThemes.darkGrayGreenTheme.textTheme.headline4,
                          placeholderText: getTranslated(context, "transfer-description"),
                          text: presenter.transferNote,
                          textChanged: (note) {
                            presenter.transferNote = note;
                          },
                        ),
                        // ----- Upload document -----
                        SizedBox(height: 12),
                        LoadImageContainer(
                          header: getTranslated(context, "upload-doc"),
                          headerStyle: CustomThemes.authorizationTheme.textTheme.headline2,
                          status: localFile == null ? getTranslated(context, "upload") : getTranslated(context, "replace"),
                          description: localFile == null ? "" : localFile.path.split('/').last,
                          descriptionStyle: CustomThemes.authorizationTheme.textTheme.headline2,
                          tap: () async {
                            final pickedFile = await picker.getImage(
                              source: ImageSource.gallery,
                            );

                            if (pickedFile == null) {
                              return;
                            }
                            setState(() {
                              localFile = File(pickedFile.path);
                            });
                            if (localFile == null) {
                              return;
                            }
                            var size = await localFile.length();
                            print("### File size = $size");
                            var bytes = await localFile.readAsBytes();
                            var fileName = localFile.path.split('/').last;
                            var fileType = localFile.path.split('.').last;
                            presenter.fileBase64Value = "data:image/$fileType;filename:$fileName;base64," + base64.encode(bytes);
                          },
                        ),
                        // ----- Send -----
                        SizedBox(height: 12),
                        CustomButton(
                          text: getTranslated(context, "send").toUpperCase(),
                          style: CustomThemes.authorizationTheme.textTheme.subtitle1,
                          tappedCallback: () async {
                            showActivityIndicator();
                            try {
                              var message = await presenter.sendFunds(context);
                              setState(() {});
                              showErrorAlert(
                                title: message,
                                message: "",
                                actions: [
                                  CupertinoDialogAction(
                                    isDefaultAction: true,
                                    child: Text("Ok"),
                                    onPressed: () {
                                      goBack();
                                    },
                                  ),
                                ],
                              );
                            } catch (error) {
                              var errorJson;
                              try {
                                errorJson = json.decode(error);
                              } catch (error) {
                                print(error);
                              }
                              int logId;
                              int httpErrorCode;
                              try {
                                logId = errorJson["entityId"];
                                httpErrorCode = errorJson["httpErrorCode"];
                              } catch (error) {
                                print(error);
                              }
                              if (httpErrorCode == 406) {
                                var presenter = SendFundsCodeEnteringPresenter();
                                presenter.setLogId(logId);
                                Navigator.of(context).push(
                                  CupertinoPageRoute(
                                    fullscreenDialog: false,
                                    builder: (context) => CodeEnteringPage(presenter: presenter),
                                  ),
                                );
                                return;
                              }
                              showErrorAlert(
                                message: error,
                                actions: [
                                  CupertinoDialogAction(
                                    isDefaultAction: true,
                                    child: Text("Ok"),
                                    onPressed: () {
                                      goBack();
                                    },
                                  )
                                ],
                              );
                              print(error);
                            } finally {
                              hideActivityIndicator();
                            }
                          },
                        ),
                        // ----- Favorites -----
                        SizedBox(height: 12),
                        buildFavorites(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _processSelectedCard(CardModel card) {
    setState(() {
      presenter.selectedCard = card;
    });
  }

  Widget buildFavorites() {
    if (isFavoritesLoading) {
      return Container(
        child: Center(
          child: CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(
              CustomColors.darkGrayGreenColor,
            ),
          ),
        ),
      );
    }

    var children = List<Widget>();
    for (var favorite in presenter.favorites) {
      var cell = buildBeneficiaryCell(favorite);
      children.add(InkWell(
        onTap: () {
          setState(() {
            presenter.selectedBeneficiary = favorite;
          });
        },
        child: cell,
      ));
    }
    return Column(children: children);
  }

  Widget buildBeneficiaryCell(BeneficiaryModel beneficiary) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(beneficiary.firstName),
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Container(
              color: CustomColors.darkGrayGreenColor,
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Text(
                getTranslated(context, "pay"),
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String getBeneficiaryName() {
    var b = presenter.selectedBeneficiary;
    if (b == null) {
      return "";
    }
    return b.firstName;
  }
}
