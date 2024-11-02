import 'package:flutter/material.dart';

enum OriginLocation { topLeft, center }

class AxisPainter extends CustomPainter {
  final OriginLocation originLocation;
  const AxisPainter(this.originLocation);
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.grey
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    Path axesPath = Path();

    late final Offset originTextOffset;

    if (originLocation == OriginLocation.topLeft) {
      final Offset startPoint = Offset(size.width, 0);
      const Offset originPoint = Offset(0, 0);
      final Offset endPoint = Offset(0, size.height);

      axesPath.moveTo(startPoint.dx, startPoint.dy);
      axesPath.lineTo(originPoint.dx, originPoint.dy);
      axesPath.lineTo(endPoint.dx, endPoint.dy);

      originTextOffset = const Offset(-16, -16);
    } else {
      final Offset xAxisStart = Offset(0, size.height / 2);
      final Offset xAxisEnd = Offset(size.width, size.height / 2);
      final Offset yAxisStart = Offset(size.width / 2, 0);
      final Offset yAxisEnd = Offset(size.width / 2, size.height);

      axesPath.moveTo(xAxisStart.dx, xAxisStart.dy);
      axesPath.lineTo(xAxisEnd.dx, xAxisEnd.dy);
      axesPath.moveTo(yAxisStart.dx, yAxisStart.dy);
      axesPath.lineTo(yAxisEnd.dx, yAxisEnd.dy);

      originTextOffset = Offset((size.width / 2) - 24, (size.height / 2) - 16);
    }
    canvas.drawPath(axesPath, paint);

    // GRAPH AXES

    // ORIGIN
    // Define the text to be displayed
    const text = '(0,0)';
    const textStyle = TextStyle(
      color: Colors.black,
      fontSize: 10,
    );

    // Create a TextPainter object
    const textSpan = TextSpan(text: text, style: textStyle);
    final textPainter = TextPainter(
      text: textSpan,
      textAlign: TextAlign.left,
      textDirection: TextDirection.ltr,
    );

    // Layout the TextPainter
    textPainter.layout();

    // Paint the text on the canvas
    textPainter.paint(canvas, originTextOffset);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
