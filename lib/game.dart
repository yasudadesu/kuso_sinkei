import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'game_data.dart';
import 'mode_select.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({Key key, this.level}) : super(key: key);
  final int level;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<GameData>(
          create: (context) => GameData(level: level),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(title: Text(modes[level])),
        body: SafeArea(
          child: SinkeiGame(level: level),
        ),
      ),
    );
  }
}

class SinkeiGame extends StatelessWidget {
  const SinkeiGame({Key key, this.level}) : super(key: key);
  final int level;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          GameStateDisplay(),
          Expanded(
            child: GridView.builder(
                // shrinkWrap: true,
                itemCount:
                    context.select<GameData, int>((value) => value.numCard),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount:
                      context.select<GameData, int>((value) => value.numRow),
                  childAspectRatio: 273 / 400,
                ),
                itemBuilder: (context, index) {
                  return CardOnGame(index: index);
                }),
          ),
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
    return Consumer<GameData>(
      builder: (context, gameData, child) {
        final card = gameData.getCard(index);

        return Padding(
            padding: const EdgeInsets.all(8),
            child: GestureDetector(
              onTap: () {
                gameData.reverseCard(index);
              },
              child: SizedBox(
                height: 160,
                width: 109.2,
                child: Center(
                  child: card.isFaceUp
                      ? CustomPaint(painter: card.paintCard, child: Container())
                      : Image.asset('assets/toranpu.png'),
                ),
              ),
            ));
      },
    );
  }
}

class GameStateDisplay extends StatelessWidget {
  const GameStateDisplay({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<GameData>(
      builder: (context, gameData, child) {
        final turn = gameData.turn;
        final score = gameData.score;
        final clearText = gameData.clearText;

        return Container(
          padding: const EdgeInsets.all(12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(width: 60),
              Text('Turn: $turn'),
              const SizedBox(width: 60),
              Text('Score: $score'),
              const SizedBox(width: 60),
              Text(clearText),
            ],
          ),
        );
      },
    );
  }
}
