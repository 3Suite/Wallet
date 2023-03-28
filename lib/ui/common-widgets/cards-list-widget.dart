import 'package:flutter/material.dart';
import 'package:mobile_app/common-presenters/cards-presenter.dart';
import 'package:mobile_app/constants/colors.dart';
import 'package:mobile_app/models/card-model.dart';
import 'package:mobile_app/ui/widgets/card-widget.dart';

class CardsList extends StatefulWidget {
  final CardsPresenter presenter;
  final void Function(CardModel) cardSelectedCallback;

  CardsList({@required this.presenter, @required this.cardSelectedCallback});

  @override
  _CardsListState createState() => _CardsListState(
        presenter: presenter,
        cardSelectedCallback: cardSelectedCallback,
      );
}

class _CardsListState extends State<CardsList> {
  final CardsPresenter presenter;
  final void Function(CardModel) cardSelectedCallback;

  bool isCardsLoading = true;
  int selectedCardIndex = 0;

  _CardsListState({
    @required this.presenter,
    @required this.cardSelectedCallback,
  }) {
    _loadInfo();
  }

  Future<void> _loadInfo() async {
    setState(() {
      isCardsLoading = true;
    });
    presenter.loadCards().then((value) {
      setState(() {
        isCardsLoading = false;
      });
      if (presenter.cardViewModels.length > 0) {
        cardSelectedCallback(presenter.cardViewModels[0].card);
      }
    }).catchError((e) {
      print(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isCardsLoading) {
      return Container(
        height: CardWidget.cardHeight,
        child: Center(
          child: CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(
              CustomColors.darkGrayGreenColor,
            ),
          ),
        ),
      );
    }
    if (presenter.cardViewModels.length == 0) {
      return Container(
        height: CardWidget.cardHeight,
        child: Center(
          child: Text("There is no any wallet :("),
        ),
      );
    }
    return Container(
      height: CardWidget.cardHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: selectedCardIndex == 0
                ? Container()
                : InkWell(
                    onTap: prevCard,
                    child: Container(
                      height: CardWidget.cardHeight,
                      child: Icon(Icons.chevron_left),
                    ),
                  ),
          ),
          GestureDetector(
            onHorizontalDragEnd: (details) {
              if (details.primaryVelocity > 0) {
                prevCard();
              } else if (details.primaryVelocity < 0) {
                nextCard();
              }
            },
            child: CardWidget(
              card: presenter.cardViewModels[selectedCardIndex],
            ),
          ),
          Expanded(
            child: selectedCardIndex + 1 == presenter.cardViewModels.length
                ? Container()
                : InkWell(
                    onTap: nextCard,
                    child: Container(
                      height: CardWidget.cardHeight,
                      child: Icon(Icons.chevron_right),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  void nextCard() {
    if (selectedCardIndex + 1 == presenter.cardViewModels.length) {
      return;
    }

    setState(() {
      selectedCardIndex += 1;
    });
    cardSelectedCallback(presenter.cardViewModels[selectedCardIndex].card);
  }

  void prevCard() {
    if (selectedCardIndex - 1 < 0) {
      return;
    }

    setState(() {
      selectedCardIndex -= 1;
    });
    cardSelectedCallback(presenter.cardViewModels[selectedCardIndex].card);
  }
}
