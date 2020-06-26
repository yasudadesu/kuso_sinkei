import 'package:flutter/material.dart';
import 'package:muzui_sinkei/randoms.dart';

class PaintCard extends CustomPainter {
  PaintCard({
    @required this.randomList,
    @required this.strokeCaps,
    @required this.paintingStyles,
    @required this.strokeWidths,
    @required this.numFigure,
    @required this.colors,
    @required this.startIndex,
  });

  List<double> randomList;
  List<int> strokeCaps;
  List<int> paintingStyles;
  List<double> strokeWidths;
  List<int> colors;
  int numFigure;
  int startIndex;

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    var path;

    paint.color = Colors.blue;
    var rect = Rect.fromLTWH(0, 0, size.width, size.height);
    canvas.drawRect(rect, paint);

    // 三角（塗りつぶし）
    for (var i = 0; i < numFigure; i++) {
      final idx = startIndex + i;
      paint = Paint()
        ..color = colorMap[colors[idx]]
        ..style = paintingStyleMap[paintingStyles[idx]]
        // ..strokeWidth = strokeWidths[idx]
        ..strokeCap = strokeCapMap[strokeCaps[idx]];

      path = randomTriangle(size, i);
      canvas.drawPath(path, paint);
    }

    // 三角（外線）
    // paint = new Paint()
    //   ..color = Colors.yellow
    //   ..strokeCap = StrokeCap.round
    //   ..style = PaintingStyle.stroke
    //   ..strokeWidth = 2;
    // path = Path();
    // path.moveTo(size.width / 2, size.height / 5 * 3);
    // path.lineTo(size.width / 4, size.height / 5 * 4);
    // path.lineTo(size.width / 4 * 3, size.height / 5 * 4);
    // path.close();
    // canvas.drawPath(path, paint);
  }

  double randWidth(Size size, int index) {
    return size.width / randomList[index];
  }

  double randHeight(Size size, int index) {
    return size.height / randomList[index];
  }

  Path randomTriangle(Size size, int index) {
    var path = Path();
    final plusIdx = index * 3; // 三角形の分

    path.moveTo(
      randWidth(size, startIndex + plusIdx),
      randHeight(size, startIndex + plusIdx + 1),
    );
    path.lineTo(
      randWidth(size, startIndex + plusIdx + 2),
      randHeight(size, startIndex + plusIdx + 3),
    );
    path.lineTo(
      randWidth(size, startIndex + plusIdx + 4),
      randHeight(size, startIndex + plusIdx + 5),
    );
    path.close();

    return path;
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(CustomPainter oldDelegate) => false;
}
