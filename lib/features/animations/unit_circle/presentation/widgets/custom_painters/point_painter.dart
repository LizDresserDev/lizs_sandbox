import 'package:flutter/material.dart';

class PointPainter extends CustomPainter {
  final Offset pointOffset;
  final Color color;
  final double? opacity;
  final double? radius;

  const PointPainter(this.pointOffset, this.color, {this.opacity, this.radius});
  @override
  void paint(
    Canvas canvas,
    Size size,
  ) {
    final Paint pointPaint = Paint()
      ..color = color.withOpacity(opacity ?? .6)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(pointOffset, radius ?? 5, pointPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
