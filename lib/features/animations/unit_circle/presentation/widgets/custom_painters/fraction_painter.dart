import 'dart:math';

import 'package:flutter/material.dart';

class FractionPainter extends CustomPainter {
  final double fontSize;
  final String numerator;
  final String? denominator;

  FractionPainter(
      {required this.numerator, this.denominator, this.fontSize = 12});

  Size getSize() {
    final textStyle = TextStyle(
      color: Colors.black,
      fontSize: fontSize,
    );

    bool useNumeratorWidth =
        !(denominator != null && denominator!.length > numerator.length);

    final textSpan = TextSpan(
        text: useNumeratorWidth ? numerator : denominator!, style: textStyle);
    final textPainter = TextPainter(
      text: textSpan,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();

    final double maxTextDim = max(textPainter.width, textPainter.height) * 1.5;
    return Size(maxTextDim, maxTextDim);
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2.0;

    final textStyle = TextStyle(
      color: Colors.black,
      fontSize: fontSize,
    );

    final numeratorSpan = TextSpan(text: numerator, style: textStyle);
    final numeratorPainter = TextPainter(
      text: numeratorSpan,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    numeratorPainter.layout();

    if (denominator == null) {
      // Calculate the position for the numerator in the center
      final numeratorOffset = Offset(
        (size.width - numeratorPainter.width) / 2,
        (size.height - numeratorPainter.height) / 2,
      );

      // Draw the numerator text in the center
      numeratorPainter.paint(canvas, numeratorOffset);
    } else {
      final denominatorSpan = TextSpan(text: denominator, style: textStyle);
      final denominatorPainter = TextPainter(
        text: denominatorSpan,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      );
      denominatorPainter.layout();

      // Calculate the positions
      final numeratorOffset = Offset(
        (size.width - numeratorPainter.width) / 2,
        (size.height / 2 - numeratorPainter.height),
      );
      final denominatorOffset = Offset(
        (size.width - denominatorPainter.width) / 2,
        (size.height / 2 + 2),
      );

      // Draw the text
      numeratorPainter.paint(canvas, numeratorOffset);
      denominatorPainter.paint(canvas, denominatorOffset);

      // Draw the fraction line
      final fractionLineStart = Offset(
        (size.width - max(numeratorPainter.width, denominatorPainter.width)) /
            2,
        size.height / 2,
      );
      final fractionLineEnd = Offset(
        (size.width + max(numeratorPainter.width, denominatorPainter.width)) /
            2,
        size.height / 2,
      );
      canvas.drawLine(fractionLineStart, fractionLineEnd, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
