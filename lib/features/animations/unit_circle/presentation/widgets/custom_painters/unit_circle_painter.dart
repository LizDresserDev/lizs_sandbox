import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lizs_sandbox/features/animations/unit_circle/constants/constants.dart';
import 'package:lizs_sandbox/features/animations/unit_circle/utils/functions.dart';

class UnitCirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    if (size.width == 0 || size.height == 0) {
      return;
    }

    final Paint paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    // Center of the circle
    final Offset center = Offset(size.width / 2, size.height / 2);
    // Radius of the unit circle (scaled for visibility)
    final double radius = min(size.width / 2, size.height / 2);

    // Draw the circle
    canvas.drawCircle(center, radius, paint);

    for (int i = 0; i < anglesInRadians.length; i++) {
      final Offset angleOffset = findPoint(anglesInRadians[i], center, radius);

      final Paint dotPaint = Paint()
        ..color = colors[i]
        ..style = PaintingStyle.fill;
      canvas.drawCircle(angleOffset, 5, dotPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
