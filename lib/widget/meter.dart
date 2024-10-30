import 'dart:math';

import 'package:flutter/material.dart';

import '../constants/constant_color.dart';

class DashboardCircleProgressPainter extends CustomPainter {
  final num percentage;
  final Color color;
  final Color bgcolor;
  final ColorScheme colorScheme;

  DashboardCircleProgressPainter(this.colorScheme,
      {required this.percentage, required this.color, required this.bgcolor});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = percentage != 0 ? bgcolor : const Color(0xFF0479F0)
      ..strokeWidth = 8.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromLTWH(0, 0, size.width, size.height),
      0,
      2 * pi,
      false,
      paint,
    );
    Paint filledPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8.0
      ..strokeCap = StrokeCap.round;

    if (percentage < 75) {
      filledPaint.color = Appcolor.nred;
    } else if (percentage == 100) {
      filledPaint.color = Colors.yellowAccent[700]!;
    } else {
      filledPaint.color = Colors.green;
    }
    num absPercentage = percentage.abs();
    double angle = 2 * pi * (absPercentage / 100);

    canvas.drawArc(
      Rect.fromLTWH(0, 0, size.width, size.height),
      0,
      angle,
      false,
      filledPaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
