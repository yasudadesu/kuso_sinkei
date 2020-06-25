import 'dart:math';

import 'package:flutter/material.dart';

class PaintCard extends CustomPainter {
  final rand = Random();

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();

    paint.color = Colors.blue;
    var rect = Rect.fromLTWH(0, 0, size.width, size.height);
    canvas.drawRect(rect, paint);

    // 三角（塗りつぶし）
    paint.color = Colors.purple;
    var path = randomTriangle(size);
    canvas.drawPath(path, paint);

    // 三角（外線）
    paint = new Paint()
      ..color = Colors.yellow
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    path = Path();
    path.moveTo(size.width / 2, size.height / 5 * 3);
    path.lineTo(size.width / 4, size.height / 5 * 4);
    path.lineTo(size.width / 4 * 3, size.height / 5 * 4);
    path.close();
    canvas.drawPath(path, paint);
  }

  double randWidth(Size size) {
    final ratio = rand.nextInt(6) + 1;
    return size.width / ratio;
  }

  double randHeight(Size size) {
    final ratio = rand.nextInt(6) + 1;
    return size.height / ratio;
  }

  Path randomTriangle(Size size) {
    var path = Path();

    path.moveTo(randWidth(size), randHeight(size));
    path.lineTo(randWidth(size), randHeight(size));
    path.lineTo(randWidth(size), randHeight(size));
    path.close();

    return path;
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
