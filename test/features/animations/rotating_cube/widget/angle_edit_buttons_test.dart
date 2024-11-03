import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:lizs_sandbox/features/animations/rotating_cube/constants/widget_keys.dart';
import 'package:lizs_sandbox/features/animations/rotating_cube/presentation/pages/rotating_cube_page.dart';
import 'package:vector_math/vector_math_64.dart';

import '../constants.dart';

void main() {
  group('X-Axis buttons', () {
    const List<(Key, double)> xAxisButtonKeyList = [
      (RotatingCubeWidgetKeys.plusPiOver6XAxis, pi / 6),
      (RotatingCubeWidgetKeys.minusPiOver6XAxis, -pi / 6),
      (RotatingCubeWidgetKeys.plusPiOver180XAxis, pi / 180),
      (RotatingCubeWidgetKeys.minusPiOver180XAxis, -pi / 180),
    ];

    for (final key in xAxisButtonKeyList) {
      testWidgets(
          '''X-axis button widget found and when tapped updates the radian and degree text widgets''',
          (WidgetTester tester) async {
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

        // Find the button by key
        final buttonFinder = find.byKey(key.$1);
        expect(buttonFinder, findsOneWidget);

        // Scroll to the button if it's off screen
        await tester.ensureVisible(buttonFinder);
        await tester.pumpAndSettle();

        // Tap the button
        await tester.tap(buttonFinder);
        await tester.pumpAndSettle();

        // Verify the updated radians and degrees text has changed
        // Find the initial radians text on the page
        final updatedRadiansTextFinder = find.text(
          'Radians: ${key.$2.toStringAsFixed(2)}, 0.00, 0.00',
        );
        // Verify the radians text is on the page once
        expect(updatedRadiansTextFinder, findsOneWidget);

        // Find the degrees text on the page
        final updatedDegreesTextFinder = find.text(
          'Degrees: ${degrees(key.$2).toStringAsFixed(1)}°, 0.0°, 0.0°',
        );

        // Verify the degrees text is on the page once
        expect(updatedDegreesTextFinder, findsOneWidget);
      });
    }
  });

  group('Y-Axis buttons', () {
    const List<(Key, double)> yAxisButtonKeyList = [
      (RotatingCubeWidgetKeys.plusPiOver6YAxis, pi / 6),
      (RotatingCubeWidgetKeys.minusPiOver6YAxis, -pi / 6),
      (RotatingCubeWidgetKeys.plusPiOver180YAxis, pi / 180),
      (RotatingCubeWidgetKeys.minusPiOver180YAxis, -pi / 180),
    ];

    for (final key in yAxisButtonKeyList) {
      testWidgets(
          '''Y-axis button widget found and when tapped updates the radian and degree text widgets''',
          (WidgetTester tester) async {
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

        // Find the button by key
        final buttonFinder = find.byKey(key.$1);
        expect(buttonFinder, findsOneWidget);

        // Scroll to the button if it's off screen
        await tester.ensureVisible(buttonFinder);
        await tester.pumpAndSettle();

        // Tap the button
        await tester.tap(buttonFinder);
        await tester.pumpAndSettle();

        // Verify the updated radians and degrees text has changed
        // Find the initial radians text on the page
        final updatedRadiansTextFinder = find.text(
          'Radians: 0.00, ${key.$2.toStringAsFixed(2)}, 0.00',
        );
        // Verify the radians text is on the page once
        expect(updatedRadiansTextFinder, findsOneWidget);

        // Find the degrees text on the page
        final updatedDegreesTextFinder = find.text(
          'Degrees: 0.0°, ${degrees(key.$2).toStringAsFixed(1)}°, 0.0°',
        );

        // Verify the degrees text is on the page once
        expect(updatedDegreesTextFinder, findsOneWidget);
      });
    }
  });

  group('Z-Axis buttons', () {
    const List<(Key, double)> zAxisButtonKeyList = [
      (RotatingCubeWidgetKeys.plusPiOver6ZAxis, pi / 6),
      (RotatingCubeWidgetKeys.minusPiOver6ZAxis, -pi / 6),
      (RotatingCubeWidgetKeys.plusPiOver180ZAxis, pi / 180),
      (RotatingCubeWidgetKeys.minusPiOver180ZAxis, -pi / 180),
    ];

    for (final key in zAxisButtonKeyList) {
      testWidgets('''
Z-axis button widget found and when tapped updates the radian and degree text widgets''',
          (WidgetTester tester) async {
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

        // Find the button by key
        final buttonFinder = find.byKey(key.$1);
        expect(buttonFinder, findsOneWidget);

        // Scroll to the button if it's off screen
        await tester.ensureVisible(buttonFinder);
        await tester.pumpAndSettle();

        // Tap the button
        await tester.tap(buttonFinder);
        await tester.pumpAndSettle();

        // Verify the updated radians and degrees text has changed
        // Find the initial radians text on the page
        final updatedRadiansTextFinder = find.text(
          'Radians: 0.00, 0.00, ${key.$2.toStringAsFixed(2)}',
        );
        // Verify the radians text is on the page once
        expect(updatedRadiansTextFinder, findsOneWidget);

        // Find the degrees text on the page
        final updatedDegreesTextFinder = find.text(
          'Degrees: 0.0°, 0.0°, ${degrees(key.$2).toStringAsFixed(1)}°',
        );

        // Verify the degrees text is on the page once
        expect(updatedDegreesTextFinder, findsOneWidget);
      });
    }
  });

  group('Rotations are clamped between -2pi and 2pi', () {
    testWidgets('Rotations never go above 2pi', (WidgetTester tester) async {
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

      const List<Key> plusButtonKeyList = [
        RotatingCubeWidgetKeys.plusPiOver6XAxis,
        RotatingCubeWidgetKeys.plusPiOver6YAxis,
        RotatingCubeWidgetKeys.plusPiOver6ZAxis,
      ];

      for (final key in plusButtonKeyList) {
        // Find the button by key
        final buttonFinder = find.byKey(key);
        expect(buttonFinder, findsOneWidget);

        // Scroll to the button if it's off screen
        await tester.ensureVisible(buttonFinder);
        await tester.pumpAndSettle();
        for (int i = 0; i < 15; i++) {
          // Tap the button
          await tester.tap(buttonFinder);
          await tester.pumpAndSettle();
        }
      }

      // Verify the updated radians and degrees text has changed
      // Find the initial radians text on the page
      final updatedRadiansTextFinder = find.text(
        '''Radians: ${(2 * pi).toStringAsFixed(2)}, ${(2 * pi).toStringAsFixed(2)}, ${(2 * pi).toStringAsFixed(2)}''',
      );
      // Verify the radians text is on the page once
      expect(updatedRadiansTextFinder, findsOneWidget);

      // Find the degrees text on the page
      final updatedDegreesTextFinder = find.text(
        '''Degrees: ${degrees(2 * pi).toStringAsFixed(1)}°, ${degrees(2 * pi).toStringAsFixed(1)}°, ${degrees(2 * pi).toStringAsFixed(1)}°''',
      );

      // Verify the degrees text is on the page once
      expect(updatedDegreesTextFinder, findsOneWidget);
    });

    testWidgets('Rotations never go below -2pi', (WidgetTester tester) async {
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

      const List<Key> minusButtonKeyList = [
        RotatingCubeWidgetKeys.minusPiOver6XAxis,
        RotatingCubeWidgetKeys.minusPiOver6YAxis,
        RotatingCubeWidgetKeys.minusPiOver6ZAxis,
      ];

      for (final key in minusButtonKeyList) {
        // Find the button by key
        final buttonFinder = find.byKey(key);
        expect(buttonFinder, findsOneWidget);

        // Scroll to the button if it's off screen
        await tester.ensureVisible(buttonFinder);
        await tester.pumpAndSettle();
        for (int i = 0; i < 15; i++) {
          // Tap the button
          await tester.tap(buttonFinder);
          await tester.pumpAndSettle();
        }
      }

      // Verify the updated radians and degrees text has changed
      // Find the initial radians text on the page
      final updatedRadiansTextFinder = find.text(
        '''Radians: ${(-2 * pi).toStringAsFixed(2)}, ${(-2 * pi).toStringAsFixed(2)}, ${(-2 * pi).toStringAsFixed(2)}''',
      );
      // Verify the radians text is on the page once
      expect(updatedRadiansTextFinder, findsOneWidget);

      // Find the degrees text on the page
      final updatedDegreesTextFinder = find.text(
        '''Degrees: ${degrees(-2 * pi).toStringAsFixed(1)}°, ${degrees(-2 * pi).toStringAsFixed(1)}°, ${degrees(-2 * pi).toStringAsFixed(1)}°''',
      );

      // Verify the degrees text is on the page once
      expect(updatedDegreesTextFinder, findsOneWidget);
    });
  });
}
