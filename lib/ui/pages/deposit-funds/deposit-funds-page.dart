import 'package:flutter/material.dart';
import 'package:mobile_app/localization/localization-constants.dart';
import 'package:mobile_app/models/card-model.dart';
import 'package:mobile_app/models/provider-model.dart';
import 'package:mobile_app/ui/pages/deposit-funds/bank-transfer-page.dart';
import 'package:mobile_app/ui/pages/deposit-funds/sub-widgets/enter-amount-widget.dart';
import 'package:mobile_app/ui/pages/deposit-funds/sub-widgets/enter-card-data-widget.dart';
import 'package:mobile_app/utilities/hex-color.dart';
import 'package:mobile_app/themes/themes.dart';
import 'package:mobile_app/ui/common-widgets/cards-list-widget.dart';
import 'package:mobile_app/ui/pages/deposit-funds/deposit-funds-presenter.dart';
import 'package:mobile_app/ui/pages/deposit-funds/money-providers-widget/money-providers-widget.dart';
import 'package:mobile_app/view-models/bank-account-details-view-model.dart';

enum DepositState { enterAmountAndCardInfo, depositResult }

enum TestState { byDefault, layout, layout2, translate }

class DepositFundsPage extends StatefulWidget {
  @override
  _DepositFundsPageState createState() => _DepositFundsPageState();
}

class _DepositFundsPageState extends State<DepositFundsPage> {
  final DepositFundsPresenter presenter = new DepositFundsPresenter();

  DepositState currentState = DepositState.enterAmountAndCardInfo;

  EnterAmountWidget amountWidget;
  MoneyProvidersWidget providersWidget;
  double amount = 0;

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    var appBar = AppBar(
      title: Text(
        getTranslated(context, "deposit-funds"),
        style: CustomThemes.darkGrayGreenTheme.textTheme.subtitle1,
      ),
      elevation: 0,
      backgroundColor: Colors.white,
    );

    return Scaffold(
      appBar: appBar,
      backgroundColor: Colors.white,
      body: SafeArea(
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
                // ----- Deposit Funds step widgets container -----
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        getTranslated(context, "deposit"),
                        textAlign: TextAlign.center,
                        style: CustomThemes.darkGrayGreenTheme.textTheme.subtitle1,
                      ),
                      // ----- Money providers Widget -----
                      SizedBox(height: 20),
                      Container(
                        height: 150,
                        padding: EdgeInsets.only(left: 16, right: 16),
                        child: getProvidersWidget(),
                      ),
                      // ----- Some widget which depends on current state -----
                      SizedBox(height: 10),
                      getWidgetForState(currentState),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget getWidgetForState(DepositState state) {
    switch (state) {
      case DepositState.enterAmountAndCardInfo:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            getAmountWidget(),
            SizedBox(height: 10),
            EnterCardDataWidget(
              cardDataEnteredCallback: _processCardDataChanged,
            ),
          ],
        );

      case DepositState.depositResult:
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 50),
            Image.asset('images/logo.png'),
            SizedBox(height: 50),
            Text(
              getTranslated(context, "deposit-complete"),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: HexColor("#42B4AE"),
                fontSize: 18,
              ),
            ),
          ],
        );
    }
    return Container();
  }

  void _processSelectedCard(CardModel card) {
    print("User selected new wallet: ${card.address}");
    presenter.selectedCard = card;
    getAmountWidget().updateCard(card);
  }

  void _processSelectedMoneyProvider(ProviderModel provider) {
    print("User selected ${provider.name}");
    getAmountWidget().updateProvider(provider);
    presenter.selectedProvider = provider;

    if (provider.isBank()) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (c) => BankTransferPage(
            account: BankAccountDetailsViewModel.withAmount(
              amount: amount,
              selectedCard: presenter.selectedCard,
            ),
          ),
        ),
      );
    }
  }

  void _processLoadeddMoneyProviders(ProviderModel provider) {
    print("Provider ${provider.name} is selected by default");
    getAmountWidget().updateProvider(provider);
    presenter.selectedProvider = provider;
  }

  void _processCardDataChanged(CardData data) {
    print("User entered card data $data");
  }

  EnterAmountWidget getAmountWidget() {
    if (amountWidget == null) {
      amountWidget = EnterAmountWidget(amountChangedCallback: _amountChangedCallback);
    }
    return amountWidget;
  }

  MoneyProvidersWidget getProvidersWidget() {
    if (providersWidget == null) {
      providersWidget = MoneyProvidersWidget(
        providersLoadedCallback: _processLoadeddMoneyProviders,
        providerSelectedCallback: _processSelectedMoneyProvider,
      );
    }
    return providersWidget;
  }

  void _amountChangedCallback(double newAmount) {
    amount = newAmount;
  }
}
