import 'package:flutter/material.dart';
import 'package:muzui_sinkei/card.dart';

class GameState with ChangeNotifier {
  GameState() {
    prepareCards();
  }

  List<GameCard> _cards = [];
  List<GameCard> get cards => _cards;

  void prepareCards() {
    for (var i = 0; i < 20; i++) {
      _cards.add(GameCard(cardId: (i % 10).toString()));
    }
    _cards.shuffle(); // this code doesnt work!?
    notifyListeners();
  }
}
