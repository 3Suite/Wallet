import 'package:flutter/material.dart';
import 'package:mobile_app/constants/colors.dart';
import 'package:mobile_app/models/provider-model.dart';
import 'package:mobile_app/ui/pages/deposit-funds/money-providers-widget/money-provider-cell.dart';
import 'package:mobile_app/ui/pages/deposit-funds/money-providers-widget/money-providers-presenter.dart';

class MoneyProvidersWidget extends StatefulWidget {
  final void Function(ProviderModel) providersLoadedCallback;
  final void Function(ProviderModel) providerSelectedCallback;

  MoneyProvidersWidget({@required this.providersLoadedCallback, @required this.providerSelectedCallback});

  @override
  _MoneyProvidersWidgetState createState() => _MoneyProvidersWidgetState(
        providersLoadedCallback: providersLoadedCallback,
        providerSelectedCallback: providerSelectedCallback,
      );
}

class _MoneyProvidersWidgetState extends State<MoneyProvidersWidget> {
  final void Function(ProviderModel) providersLoadedCallback;
  final void Function(ProviderModel) providerSelectedCallback;
  final MoneyProviderPresenter presenter = new MoneyProviderPresenter();

  int selectedIndex = 0;

  _MoneyProvidersWidgetState({@required this.providersLoadedCallback, @required this.providerSelectedCallback});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<int>(
      future: _loadInfo(),
      builder: (context, AsyncSnapshot<int> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation<Color>(
                CustomColors.darkGrayGreenColor,
              ),
            ),
          );
        }
        return ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                setState(() {
                  selectedIndex = index;
                });
                providerSelectedCallback(presenter.providers[index].provider);
              },
              child: MoneyProviderCell(
                provider: presenter.providers[index],
                isSelected: selectedIndex == index,
              ),
            );
          },
          separatorBuilder: (context, index) {
            return SizedBox(width: 10);
          },
          itemCount: presenter.providers.length,
        );
      },
    );
  }

  Future<int> _loadInfo() async {
    await presenter.loadProviders();
    providersLoadedCallback(presenter.providers[selectedIndex].provider);
    return 0;
  }
}
