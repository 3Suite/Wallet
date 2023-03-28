import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:mobile_app/constants/colors.dart';
import 'package:mobile_app/localization/localization-constants.dart';
import 'package:mobile_app/models/card-model.dart';
import 'package:mobile_app/themes/themes.dart';
import 'package:mobile_app/ui/cells/transaction-cell.dart';
import 'package:mobile_app/ui/common-widgets/cards-list-widget.dart';
import 'package:mobile_app/ui/pages/dashboard/dashboard-presenter.dart';
import 'package:mobile_app/ui/pages/transaction/transaction-page.dart';
import 'package:mobile_app/view-models/transaction-view-model.dart';

import 'package:mobile_app/ui/extensions/custom-widget-extension.dart';

class DashboardPage extends StatefulWidget {
  @override
  DashboardPageState createState() => DashboardPageState();
}

class DashboardPageState extends State<DashboardPage> {
  final DashboardPresenter presenter = DashboardPresenter();
  bool isTransactionsLoading = false;
  CardModel selectedCard;
  ScrollController _scrollController = ScrollController();

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }

    presenter.controller = this;
  }

  @override
  void initState() {
    super.initState();

    presenter.fetchCountries().catchError((error) {
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
    });
    presenter.loadCards().catchError((error) {
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
    });
    presenter.fetchUser().catchError((error) {
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
    });
  }

  DashboardPageState() {
    _scrollController.addListener(_scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    var appBar = AppBar(
      title: Text(
        getTranslated(context, "dashboard"),
        style: CustomThemes.darkGrayGreenTheme.textTheme.subtitle1,
      ),
      elevation: 0,
      backgroundColor: Colors.white,
    );

    var page = Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // ----- Cards list -----
            CardsList(
              presenter: presenter,
              cardSelectedCallback: (card) {
                selectedCard = card;
                WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                  setState(() {
                    isTransactionsLoading = true;
                  });
                  presenter.loadTransactions(card).whenComplete(() {
                    setState(() {
                      isTransactionsLoading = false;
                    });
                  });
                });
              },
            ),
            // ----- Transaction history -----
            SizedBox(height: 35),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 15, right: 15),
                padding: EdgeInsets.all(30),
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () async {
                            await presenter.getPdf(context).catchError((error) {
                              hideActivityIndicator();
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
                            });
                          },
                          child: Icon(
                            Icons.picture_as_pdf,
                            color: CustomColors.darkGrayGreenColor,
                            size: 30,
                          ),
                        ),
                        Text(
                          getTranslated(context, "transaction-history"),
                          textAlign: TextAlign.center,
                          style: CustomThemes.darkGrayGreenTheme.textTheme.subtitle1,
                        ),
                        Container(),
                      ],
                    ),
                    SizedBox(height: 10),
                    // ----- Transactions list -----
                    Expanded(
                      child: isTransactionsLoading
                          ? Container(
                              child: Center(
                                child: CircularProgressIndicator(
                                  valueColor: new AlwaysStoppedAnimation<Color>(
                                    CustomColors.darkGrayGreenColor,
                                  ),
                                ),
                              ),
                            )
                          : GroupedListView<TransactionViewModel, DateTime>(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              elements: presenter.transactions,
                              groupBy: (t) => t.transactionDate,
                              groupComparator: (t1, t2) {
                                return t2.compareTo(t1);
                              },
                              controller: _scrollController,
                              groupSeparatorBuilder: (transactionDate) {
                                return _getSeparatorWidget(transactionDate);
                              },
                              itemBuilder: (context, transaction) {
                                return InkWell(
                                  child: TransactionCell(
                                    transaction: transaction,
                                  ),
                                  onTap: () {
                                    var page = TransactionPage(
                                      card: selectedCard,
                                      transaction: transaction.transaction,
                                    );
                                    Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                        builder: (context) => page,
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
    return page;
  }

  Widget _getSeparatorWidget(DateTime transactionDate) {
    var totalBalanceForDate = presenter.getTotalBalance(transactionDate);
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            DateFormat(DateFormat.ABBR_MONTH_DAY).format(transactionDate),
            style: CustomThemes.darkGrayGreenTheme.textTheme.headline4,
          ),
          Container(
            padding: EdgeInsets.fromLTRB(5, 2, 5, 2),
            decoration: BoxDecoration(
              color: totalBalanceForDate < 0 ? CustomColors.negativeBalanceColor : CustomColors.positiveBalanceColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              TransactionViewModel.FormatBalance(
                selectedCard.currencyId,
                totalBalanceForDate,
              ),
              style: TextStyle(
                fontSize: 11,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _scrollListener() {
    var offset = _scrollController.offset;
    var contentSize = _scrollController.position.maxScrollExtent;
    var x = 100 * offset / contentSize;
    if (x >= 80) {
      presenter.loadTransactions(selectedCard);
    }
  }
}
