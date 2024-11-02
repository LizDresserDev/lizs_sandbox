import 'dart:math';

import 'package:flutter/material.dart';

Offset findPoint(double angleInRads, Offset centerPoint, double radiusAtPoint) {
  final double angleXPos = centerPoint.dx + radiusAtPoint * cos(angleInRads);
  final double angleYPos = centerPoint.dy + radiusAtPoint * sin(angleInRads);

  return Offset(angleXPos, angleYPos);
}

Color interpolatedColor({
  required Color firstColor,
  required Color secondColor,
  double firstColorWeight = .5,
}) {
  // Ensure weight1 is between 0 and 1
  double color1Weight = 0;
  double color2Weight = 0;
  if (firstColorWeight < 0) {
    color1Weight = 0;
    color2Weight = 1;
  } else if (firstColorWeight > 1) {
    color1Weight = 1;
    color2Weight = 0;
  } else {
    color1Weight = firstColorWeight;
    color2Weight = 1 - firstColorWeight;
  }

  int red =
      (firstColor.red * color1Weight + secondColor.red * color2Weight).round();
  int green =
      (firstColor.green * color1Weight + secondColor.green * color2Weight)
          .round();
  int blue = (firstColor.blue * color1Weight + secondColor.blue * color2Weight)
      .round();

  return Color.fromARGB(255, red, green, blue);
}
