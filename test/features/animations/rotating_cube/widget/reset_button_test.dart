import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:lizs_sandbox/features/animations/rotating_cube/constants/widget_keys.dart';
import 'package:lizs_sandbox/features/animations/rotating_cube/presentation/pages/rotating_cube_page.dart';
import 'package:vector_math/vector_math_64.dart';

import '../constants.dart';

void main() {
  group('Reset button widget tests', () {
    testWidgets('Reset button resets rotations', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(const MaterialApp(home: RotatingCubePage()));

      // Find the initial radians text on the page
      final initialRadiansTextFinder = find.text(initialRadiansString);
      // Verify the radians text is on the page once
      expect(initialRadiansTextFinder, findsOneWidget);

      // Find the degrees text on the page
      final initialDegreesTextFinder = find.text(initialDegreesString);

      // Verify the degrees text is on the page once
      expect(initialDegreesTextFinder, findsOneWidget);

      // Find the Reset button on the page
      final resetButtonFinder = find.byKey(RotatingCubeWidgetKeys.reset);

      // Verify the reset button is on the page once
      expect(resetButtonFinder, findsOneWidget);

      const List<Key> buttonKeyList = [
        RotatingCubeWidgetKeys.plusPiOver6XAxis,
        RotatingCubeWidgetKeys.plusPiOver6YAxis,
        RotatingCubeWidgetKeys.plusPiOver6ZAxis,
      ];

      for (final key in buttonKeyList) {
        // Find the button by key
        final buttonFinder = find.byKey(key);
        expect(buttonFinder, findsOneWidget);

        // Scroll to the button if it's off screen
        await tester.ensureVisible(buttonFinder);
        await tester.pumpAndSettle();

        // Tap the button
        await tester.tap(buttonFinder);
        await tester.pumpAndSettle();
      }

      // Verify that the radian rotations are all equal to pi / 6
      const double rotation = pi / 6;
      final updatedRadiansTextFinder = find.text(
        '''Radians: ${rotation.toStringAsFixed(2)}, ${rotation.toStringAsFixed(2)}, ${rotation.toStringAsFixed(2)}''',
      );

      // Verify the updated radians text is on the page once
      expect(updatedRadiansTextFinder, findsOneWidget);

      // Verify that the degree rotations are all equal to pi / 6
      final updatedDegreesTextFinder = find.text(
        '''Degrees: ${degrees(rotation).toStringAsFixed(1)}°, ${degrees(rotation).toStringAsFixed(1)}°, ${degrees(rotation).toStringAsFixed(1)}°''',
      );

      // Verify the updated radians text is on the page once
      expect(updatedDegreesTextFinder, findsOneWidget);

      // Scroll to the widget if it's off screen
      await tester.ensureVisible(resetButtonFinder);
      await tester.pumpAndSettle();

      // Tap the button
      await tester.tap(resetButtonFinder);
      await tester.pumpAndSettle();

      // Verify that the radians text shows that the rotations
      // have been set back to 0
      final resetRadiansTextFinder = find.text(initialRadiansString);
      expect(resetRadiansTextFinder, findsOneWidget);

      // Verify that the degrees text shows that the rotations
      // have been set back to 0
      final degreesRadiansTextFinder = find.text(initialDegreesString);
      expect(degreesRadiansTextFinder, findsOneWidget);
    });
  });
}
