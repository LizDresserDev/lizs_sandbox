import 'dart:math';

import 'package:flutter/material.dart';

const List<double> anglesInRadians = [
  0,
  pi / 6,
  pi / 4,
  pi / 3,
  pi / 2,
  2 * pi / 3,
  3 * pi / 4,
  5 * pi / 6,
  pi,
  7 * pi / 6,
  5 * pi / 4,
  4 * pi / 3,
  3 * pi / 2,
  5 * pi / 3,
  7 * pi / 4,
  11 * pi / 6,
  2 * pi
];

const List<Color> colors = [
  Color(0xFFFF0000), // Red
  Color(0xFFFF4500), // Orange Red
  Color(0xFFFF7F50), // Coral
  Color(0xFFFFA500), // Orange
  Color(0xFFFFD700), // Gold
  Color(0xFFFFFF00), // Yellow
  Color(0xFFADFF2F), // Green Yellow
  Color(0xFF00FF00), // Lime
  Color(0xFF32CD32), // Lime Green
  Color(0xFF00FA9A), // Medium Spring Green
  Color(0xFF00FFFF), // Aqua
  Color(0xFF1E90FF), // Dodger Blue
  Color(0xFF0000FF), // Blue
  Color(0xFF4B0082), // Indigo
  Color(0xFF8A2BE2), // Blue Violet
  Color(0xFF9400D3), // Dark Violet
  Color(0xFFEE82EE), // Violet
];

const List<(String, String?)> anglesInRadStrings = [
  ('2π\n0', null),
  ('π', '6'),
  ('π', '4'),
  ('π', '3'),
  ('π', '2'),
  ('2π', '3'),
  ('3π', '4'),
  ('5π', '6'),
  ('π', null),
  ('7π', '6'),
  ('5π', '4'),
  ('4π', '3'),
  ('3π', '2'),
  ('5π', '3'),
  ('7π', '4'),
  ('11π', '6'),
];

const List<(double, String)> anglesInDegrees = [
  (0, '360°\n0°'),
  (30, '30°'),
  (45, '45°'),
  (60, '60°'),
  (90, '90°'),
  (120, '120°'),
  (135, '135°'),
  (150, '150°'),
  (180, '180°'),
  (210, '210°'),
  (225, '225°'),
  (240, '240°'),
  (270, '270°'),
  (300, '300°'),
  (315, '315°'),
  (330, '330°'),
];

const String zeroDegreeFlutterUnitCircle = '360°\n0°';
const String zeroDegreeNormalUnitCircle = '0°\n360°';
const String zeroRadsFlutterUnitCircle = '2π\n0';
const String zeroRadsNormalUnitCircle = '0\n2π';
