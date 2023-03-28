import 'package:flutter/material.dart';
import 'package:mobile_app/constants/colors.dart';
import 'package:mobile_app/localization/localization-constants.dart';
import 'package:mobile_app/themes/themes.dart';
import 'package:mobile_app/ui/pages/e-vouchers/e-vouchers.dart';
import 'package:mobile_app/ui/pages/funds/add-beneficiary/add-beneficiary.dart';

class FundsMenuPage extends StatefulWidget {
  @override
  FundsMenuPageState createState() => FundsMenuPageState();
}

class FundsMenuPageState extends State<FundsMenuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: CustomColors.backgroundLightGrayColor,
          elevation: 0,
          title: Text(
            getTranslated(context, "funds-menu"),
            style: CustomThemes.darkGrayGreenTheme.textTheme.subtitle1,
          ),
          iconTheme: IconThemeData(
            color: CustomColors.darkGrayGreenColor,
          )),
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
            height: MediaQuery.of(context).size.height / 8.5,
            padding: EdgeInsets.only(left: 18, right: 18, top: 20),
            child: ListView.separated(
              itemBuilder: (context, index) {
                switch (index) {
                  case 0:
                    return Center(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EVouchersPage(),
                            ),
                          );
                        },
                        child: Text(
                          getTranslated(context, "e-vouchers"),
                          style: CustomThemes.darkGrayGreenTheme.textTheme.bodyText2,
                        ),
                      ),
                    );
                    break;

                  case 1:
                    return Center(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddBeneficiaryPage(),
                            ),
                          );
                        },
                        child: Text(
                          getTranslated(context, "add-beneficiary"),
                          style: CustomThemes.darkGrayGreenTheme.textTheme.bodyText2,
                        ),
                      ),
                    );
                    break;

                  default:
                    return Container();
                }
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
              itemCount: 2,
            ),
          ),
        ),
      ),
    );
  }
}
