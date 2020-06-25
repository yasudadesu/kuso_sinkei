import 'package:flutter/material.dart';
import 'package:muzui_sinkei/card.dart';
import 'package:muzui_sinkei/paint_card.dart';

class GameState with ChangeNotifier {
  GameState() {
    preparePatterns();
    prepareCards();
  }

  List<GameCard> _cards = [];
  List<GameCard> get cards => _cards;
  Map<int, CustomPainter> _painterMap = {};
  Map<int, CustomPainter> get painterMap => _painterMap;

  void preparePatterns() {
    for (var i = 0; i < 10; i++) {
      _painterMap[i] = PaintCard();
    }
  }

  void prepareCards() {
    for (var i = 0; i < 20; i++) {
      _cards.add(GameCard(cardId: i % 10));
    }
    _cards.shuffle(); // this code doesnt work!?
    notifyListeners();
  }

  GameCard getCard(int index) {
    return _cards[index];
  }

  void reverseCard(int index) {
    final prevFaceUp = _cards[index].isFaceUp;
    _cards[index].isFaceUp = !prevFaceUp;

    notifyListeners();
  }
}
