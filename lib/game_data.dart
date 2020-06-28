import 'package:flutter/material.dart';
import 'package:muzui_sinkei/card.dart';
import 'package:muzui_sinkei/paint_card.dart';

class GameData with ChangeNotifier {
  GameData({int level}) {
    settingsByLevel(level);
    createRandomLists();
    prepareCards();
  }

  void settingsByLevel(int level) {
    if (level == 0) {
      _numCard = 20;
      _numRow = 5;
      _maxNum = 10;
    } else if (level == 1) {
      _numCard = 30;
      _numRow = 6;
      _maxNum = 20;
    } else if (level == 2) {
      _numCard = 42;
      _numRow = 7;
      _maxNum = 30;
    } else {
      _numCard = 56;
      _numRow = 8;
      _maxNum = 40;
    }
  }

  int _numCard;
  int _numRow;
  int get numCard => _numCard;
  int get numRow => _numRow;
  int _maxNum; // 複雑度みたいなもん

  List<GameCard> _cards = [];
  List<GameCard> get cards => _cards;
  Map<int, CustomPainter> _painterMap = {};
  Map<int, CustomPainter> get painterMap => _painterMap;

  int _turn = 1;
  int _score = 0;

  int get turn => _turn;
  int get score => _score;

  String _clearText = '';
  String get clearText => _clearText;

  List<int> _opendIdxs = [];

  void nextTurn() {
    _turn += 1;
  }

  void clearGame() {
    _clearText = 'Game Clear!';
    notifyListeners();
  }

  void reverseCard(int index) {
    if (_opendIdxs.length >= 2) {
      // 連打されたということなので、2つ以上の場合は何もしない
      return;
    }

    if (_cards[index].isFaceUp) {
      // プレイヤーが自ら裏返すことはできない
      return;
    }

    final prevFaceUp = _cards[index].isFaceUp;
    _cards[index].isFaceUp = !prevFaceUp;
    _opendIdxs.add(index);
    notifyListeners();

    if (_opendIdxs.length == 2) {
      Future.delayed(Duration(milliseconds: 1200)).then((_) {
        final isCorectPair =
            _cards[_opendIdxs[0]].cardId == _cards[_opendIdxs[1]].cardId;

        if (isCorectPair) {
          // あってたらスコアをプラス
          _score += 1;
          if (_score * 2 == _numCard) {
            clearGame();
          }
        } else {
          // 間違ってたら裏返して次のターンへ
          nextTurn();
          _cards[_opendIdxs[0]].isFaceUp = false;
          _cards[_opendIdxs[1]].isFaceUp = false;
        }
        _opendIdxs = [];
        notifyListeners();
      });
    }
  }

  // void preparePatterns() {
  //   for (var i = 0; i < 10; i++) {
  //     _painterMap[i] = PaintCard();
  //   }
  // }

  List<double> _randomList = [];
  List<int> _colors = [];
  List<int> _numFigures = [];
  List<int> _strokeCaps = [];
  List<int> _paintingStyles = [];
  List<double> _strokeWidths = [];
  List<int> _startIndices = [];

  void createRandomLists() {
    // 座標の指定に用いる width,height / n の n
    for (var i = 0; i < _maxNum; i++) {
      for (var j = 0; j < _maxNum; j++) {
        _randomList.add(_maxNum / (i + 1));
        _numFigures.add((j % 5) + 5);
        _colors.add((i * _maxNum + j) % 8);
        _strokeCaps.add((i * _maxNum + j) % 3);
        _paintingStyles.add((i * _maxNum + j) % 2);
        _strokeWidths.add(((i * _maxNum + j) % 10) + 1.0);
      }
    }
    for (var i = 0; i < (_maxNum * _maxNum / 2); i++) {
      _startIndices.add(i);
    }

    _randomList.shuffle();
    _colors.shuffle();
    _numFigures.shuffle();
    _strokeCaps.shuffle();
    _paintingStyles.shuffle();
    _strokeWidths.shuffle();
    _startIndices.shuffle();
  }

  void prepareCards() {
    for (var i = 0; i < _numCard; i++) {
      final idx = i % (_numCard ~/ 2);
      _cards.add(GameCard(
        cardId: idx,
        paintCard: PaintCard(
          randomList: _randomList,
          strokeCaps: _strokeCaps,
          paintingStyles: _paintingStyles,
          strokeWidths: _strokeWidths,
          numFigure: _numFigures[idx],
          startIndex: _startIndices[idx],
          colors: _colors,
        ),
      ));
    }
    _cards.shuffle(); // this code doesnt work!?
    notifyListeners();
  }

  GameCard getCard(int index) {
    return _cards[index];
  }
}
