// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';

class RotatingCubeWidgetKeys {
  // Reset and animate
  static const reset = Key('reset');
  static const animate = Key('animate');

  // Angle Text Widget
  static const radiansText = Key('radiansText');
  static const degreesText = Key('degreesText');

  // Angle Buttons
  static const plusPiOver6XAxis = Key('plusPiOver6XAxis');
  static const minusPiOver6XAxis = Key('minusPiOver6XAxis');
  static const plusPiOver180XAxis = Key('plusPiOver180XAxis');
  static const minusPiOver180XAxis = Key('minusPiOver180XAxis');
  static const plusPiOver6YAxis = Key('plusPiOver6YAxis');
  static const minusPiOver6YAxis = Key('minusPiOver6YAxis');
  static const plusPiOver180YAxis = Key('plusPiOver180YAxis');
  static const minusPiOver180YAxis = Key('minusPiOver180YAxis');
  static const plusPiOver6ZAxis = Key('plusPiOver6ZAxis');
  static const minusPiOver6ZAxis = Key('minusPiOver6ZAxis');
  static const plusPiOver180ZAxis = Key('plusPiOver180ZAxis');
  static const minusPiOver180ZAxis = Key('minusPiOver180ZAxis');

  // Angle Sliders
  static const sliderXAxis = Key('sliderXAxis');
  static const sliderYAxis = Key('sliderYAxis');
  static const sliderZAxis = Key('sliderZAxis');

  // Gesture Detectors
  static const drawnCubeGestureDetector = Key('drawnCubeGestureDetector');
  static const transformedCubeGestureDetector =
      Key('transformedCubeGestureDetector');
}
