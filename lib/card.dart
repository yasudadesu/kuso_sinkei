import 'package:flutter/material.dart';
import 'package:muzui_sinkei/paint_card.dart';

class GameCard {
  GameCard({this.cardId, this.paintCard, this.isFaceUp = false});

  final int cardId;
  final PaintCard paintCard;
  bool isFaceUp;
}
