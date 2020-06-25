import 'package:flutter/material.dart';

class GameCard {
  GameCard({this.cardId, this.isFaceUp = false});

  final int cardId;
  bool isFaceUp;
}
