import 'package:flutter/material.dart';
import 'package:muzui_sinkei/card.dart';
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
    final cards =
        context.select<GameState, List<GameCard>>((value) => value.cards);

    return SingleChildScrollView(
      child: Column(
        children: [
          for (var i = 0; i < 4; i++)
            Row(
              children: [
                for (var j = 0; j < 5; j++)
                  Padding(
                      padding: const EdgeInsets.all(8),
                      child: Container(
                        height: 160,
                        width: 109.2,
                        color: Colors.black12,
                        child: Center(child: Text(cards[i * 4 + j].cardId)),
                      ))
              ],
            )
        ],
      ),
    );
  }
}
