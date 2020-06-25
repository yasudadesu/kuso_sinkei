import 'package:flutter/material.dart';
import 'package:muzui_sinkei/paint_card.dart';
import 'package:provider/provider.dart';

import 'game_state.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<GameState>(
      create: (context) => GameState(),
      child: Scaffold(
        appBar: AppBar(title: Text('Game')),
        body: SafeArea(
          child: SinkeiGame(),
        ),
      ),
    );
  }
}

class SinkeiGame extends StatelessWidget {
  const SinkeiGame({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          for (var i = 0; i < 4; i++)
            Row(
              children: [
                for (var j = 0; j < 5; j++) CardOnGame(index: i * 5 + j)
              ],
            )
        ],
      ),
    );
  }
}

class CardOnGame extends StatelessWidget {
  const CardOnGame({Key key, this.index}) : super(key: key);
  final int index;

  @override
  Widget build(BuildContext context) {
    // final card =
    //     context.select<GameState, GameCard>((value) => value.getCard(index));
    return Consumer<GameState>(
      builder: (context, gameState, child) {
        final card = gameState.getCard(index);
        final painterMap = gameState.painterMap;

        return Padding(
            padding: const EdgeInsets.all(8),
            child: GestureDetector(
              onTap: () {
                gameState.reverseCard(index);
              },
              child: Container(
                height: 160,
                width: 109.2,
                // color: card.isFaceUp ? Colors.black12 : Colors.transparent,
                child: Center(
                  child: card.isFaceUp
                      ? Text(card.cardId.toString())
                      // ? CustomPaint(
                      //     painter: painterMap[card.cardId], child: Container())
                      : Image.asset('assets/toranpu.png'),
                ),
              ),
            ));
      },
    );
  }
}
