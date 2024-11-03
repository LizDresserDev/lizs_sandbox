import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:lizs_sandbox/features/animations/rotating_cube/constants/widget_keys.dart';
import 'package:lizs_sandbox/features/animations/rotating_cube/presentation/pages/rotating_cube_page.dart';
import 'package:vector_math/vector_math_64.dart';

import '../constants.dart';

void main() {
  group('GestureDetector widget tests', () {
    testWidgets(
        '''DrawnGestureDetector triggers onPanUpdate to update the rotation variables''',
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

      // Find the GestureDetector widget using its key
      final gestureDetectorFinder =
          find.byKey(RotatingCubeWidgetKeys.drawnCubeGestureDetector);

      // Verify the drawn cube  GestureDetector is present in the widget tree
      expect(gestureDetectorFinder, findsOneWidget);

      // The gesture detector is panned to some offset
      // the rotations update accordingly
      // Get the global position of the GestureDetector renderObject
      final RenderBox gestureDetectorBox =
          tester.renderObject(gestureDetectorFinder);
      final Offset gestureDetectorPosition =
          gestureDetectorBox.localToGlobal(Offset.zero);

      // Create mock DragUpdateDetails with specific delta values
      final DragUpdateDetails dragDetails = DragUpdateDetails(
        delta: const Offset(-50, -50),
        globalPosition: gestureDetectorPosition,
      );

      // Trigger the onPanUpdate callback associated with this GestureDetector
      // using the dragDetails
      final drawnGestureDetector =
          tester.widget<GestureDetector>(gestureDetectorFinder);
      expect(drawnGestureDetector.onPanUpdate, isNotNull);
      drawnGestureDetector.onPanUpdate!(dragDetails);
      await tester.pumpAndSettle();

      // Calculate the expected _rx and _ry values
      final double newRx = 0 + dragDetails.delta.dy * 0.01;
      final double newRy = 0 - dragDetails.delta.dx * 0.01;

      // Normalize the rotation values to be within
      // the expected range (-2pi to 2pi)
      final double boundedRx = newRx.clamp(-2 * pi, 2 * pi);
      final double boundedRy = newRy.clamp(-2 * pi, 2 * pi);

      // Verify the updated radians and degrees text has changed
      // Find the initial radians text on the page
      final updatedRadiansTextFinder = find.text(
        '''Radians: ${boundedRx.toStringAsFixed(2)}, ${boundedRy.toStringAsFixed(2)}, 0.00''',
      );
      // Verify the radians text is on the page once
      expect(updatedRadiansTextFinder, findsOneWidget);

      // Find the degrees text on the page
      final updatedDegreesTextFinder = find.text(
        '''Degrees: ${degrees(boundedRx).toStringAsFixed(1)}°, ${degrees(newRy).toStringAsFixed(1)}°, 0.0°''',
      );

      // Verify the degrees text is on the page once
      expect(updatedDegreesTextFinder, findsOneWidget);
    });

    testWidgets(
        '''TransformedGestureDetector triggers onPanUpdate to update the rotation variables''',
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

      // Find the GestureDetector widget using its key
      final gestureDetectorFinder =
          find.byKey(RotatingCubeWidgetKeys.transformedCubeGestureDetector);

      // Verify the transformed cube  GestureDetector is present
      // in the widget tree
      expect(gestureDetectorFinder, findsOneWidget);

      // The gesture detector is panned to some offset
      // the rotations update accordingly
      // Get the global position of the GestureDetector renderObject
      final RenderBox gestureDetectorBox =
          tester.renderObject(gestureDetectorFinder);
      final Offset gestureDetectorPosition =
          gestureDetectorBox.localToGlobal(Offset.zero);

      // Create mock DragUpdateDetails with specific delta values
      final DragUpdateDetails dragDetails = DragUpdateDetails(
        delta: const Offset(-50, -50),
        globalPosition: gestureDetectorPosition,
      );

      // Trigger the onPanUpdate callback associated with this GestureDetector
      // using the dragDetails
      final transformedGestureDetector =
          tester.widget<GestureDetector>(gestureDetectorFinder);
      expect(transformedGestureDetector.onPanUpdate, isNotNull);
      transformedGestureDetector.onPanUpdate!(dragDetails);
      await tester.pumpAndSettle();

      // Calculate the expected _rx and _ry values
      final double newRx = 0 + dragDetails.delta.dy * 0.01;
      final double newRy = 0 - dragDetails.delta.dx * 0.01;

      // Normalize the rotation values to be
      // within the expected range (-2pi to 2pi)
      final double boundedRx = newRx.clamp(-2 * pi, 2 * pi);
      final double boundedRy = newRy.clamp(-2 * pi, 2 * pi);

      // Verify the updated radians and degrees text has changed
      // Find the initial radians text on the page
      final updatedRadiansTextFinder = find.text(
        '''Radians: ${boundedRx.toStringAsFixed(2)}, ${boundedRy.toStringAsFixed(2)}, 0.00''',
      );
      // Verify the radians text is on the page once
      expect(updatedRadiansTextFinder, findsOneWidget);

      // Find the degrees text on the page
      final updatedDegreesTextFinder = find.text(
        '''Degrees: ${degrees(boundedRx).toStringAsFixed(1)}°, ${degrees(newRy).toStringAsFixed(1)}°, 0.0°''',
      );

      // Verify the degrees text is on the page once
      expect(updatedDegreesTextFinder, findsOneWidget);
    });
  });
}
