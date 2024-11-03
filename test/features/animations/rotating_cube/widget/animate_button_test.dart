import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:lizs_sandbox/features/animations/rotating_cube/constants/widget_keys.dart';
import 'package:lizs_sandbox/features/animations/rotating_cube/presentation/pages/rotating_cube_page.dart';

import '../constants.dart';

void main() {
  group('Animate button widget tests', () {
    testWidgets('When tapped, the cubes start automatically rotating',
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

      // Find the Animate button on the page
      final animateButtonFinder = find.byKey(RotatingCubeWidgetKeys.animate);

      // Verify the animate button is on the page once
      expect(animateButtonFinder, findsOneWidget);

      // Find the initial animate button text
      final animateButtonTextFinder = find.text('Be Free!');

      // Verify the initial animate button text
      expect(animateButtonTextFinder, findsOneWidget);

      // Scroll to the button if it's off screen
      await tester.ensureVisible(animateButtonFinder);
      await tester.pumpAndSettle();

      // Tap the button
      await tester.tap(animateButtonFinder);
      await tester.pump();
      await tester.pump(const Duration(seconds: 1));

      // Verify that the text shown on the animate button has changed
      expect(animateButtonTextFinder, findsNothing);

      // Verify the radians text has changed
      expect(initialRadiansTextFinder, findsNothing);

      // Verify the degrees text has changed
      expect(initialDegreesTextFinder, findsNothing);
    });
  });
}
