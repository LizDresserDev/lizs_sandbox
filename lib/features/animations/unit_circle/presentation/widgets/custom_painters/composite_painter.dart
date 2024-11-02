import 'package:flutter/material.dart';

class CompositePainter extends CustomPainter {
  final CustomPainter innerPainter;
  final List<Offset> positions; // allows for duplicates

  CompositePainter({
    required this.innerPainter,
    required this.positions,
  });

  @override
  void paint(Canvas canvas, Size size) {
    for (Offset position in positions) {
      canvas.save();
      canvas.translate(position.dx, position.dy);
      innerPainter.paint(canvas, const Size(0, 0)); // Adjust size if necessary
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class CenteredPainter extends CustomPainter {
  final CustomPainter innerPainter;

  CenteredPainter({
    required this.innerPainter,
  });

  @override
  void paint(Canvas canvas, Size size) {
    canvas.save();
    canvas.translate(0, 0);
    innerPainter.paint(canvas, const Size(0, 0));
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
