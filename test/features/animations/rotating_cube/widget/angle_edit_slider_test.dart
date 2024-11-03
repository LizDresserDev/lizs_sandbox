import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:lizs_sandbox/features/animations/rotating_cube/constants/widget_keys.dart';
import 'package:lizs_sandbox/features/animations/rotating_cube/presentation/pages/rotating_cube_page.dart';

void main() {
  group('Sliders', () {
    const List<Key> sliderKeyList = [
      RotatingCubeWidgetKeys.sliderXAxis,
      RotatingCubeWidgetKeys.sliderYAxis,
      RotatingCubeWidgetKeys.sliderZAxis,
    ];

    for (final key in sliderKeyList) {
      testWidgets('Sliding slider to right maxes the value out to 2pi',
          (WidgetTester tester) async {
        // Build our app and trigger a frame.
        await tester.pumpWidget(const MaterialApp(home: RotatingCubePage()));

        // Find the button by key
        final sliderFinder = find.byKey(key);
        expect(sliderFinder, findsOneWidget);

        // Scroll to the button if it's off screen
        await tester.ensureVisible(sliderFinder);
        await tester.pumpAndSettle();

        // Verify the initial value of the slider
        final Slider slider = tester.widget(sliderFinder);
        expect(slider.value, 0.0);

        // Calculate the drag amount to set the slider value
        // to the maximum value
        final RenderBox sliderBox = tester.renderObject(sliderFinder);
        final Offset sliderCenter =
            sliderBox.localToGlobal(sliderBox.size.center(Offset.zero));
        final Offset sliderRightEdge =
            sliderBox.localToGlobal(Offset(sliderBox.size.width, 0));

        final double dragAmount = sliderRightEdge.dx - sliderCenter.dx;

        // Simulate dragging the slider
        // to the right by the calculated drag amount
        await tester.dragFrom(sliderCenter, Offset(dragAmount, 0));
        await tester.pumpAndSettle();

        // Verify the updated value of the slider
        final updatedSlider = tester.widget<Slider>(sliderFinder);
        expect(updatedSlider.value, slider.max);
        expect(updatedSlider.value, 2 * pi);
      });
    }

    for (final key in sliderKeyList) {
      testWidgets('Sliding slider to left maxes the value out to -2pi',
          (WidgetTester tester) async {
        // Build our app and trigger a frame.
        await tester.pumpWidget(const MaterialApp(home: RotatingCubePage()));

        // Find the button by key
        final sliderFinder = find.byKey(key);
        expect(sliderFinder, findsOneWidget);

        // Scroll to the slider if it's off screen
        await tester.ensureVisible(sliderFinder);
        await tester.pumpAndSettle();

        // Verify the initial value of the slider
        final Slider slider = tester.widget(sliderFinder);
        expect(slider.value, 0.0);

        // Calculate the drag amount to set the slider value
        // to the maximum value
        final RenderBox sliderBox = tester.renderObject(sliderFinder);
        final Offset sliderCenter =
            sliderBox.localToGlobal(sliderBox.size.center(Offset.zero));
        final Offset sliderLeftEdge =
            sliderBox.localToGlobal(Offset(sliderBox.size.width, 0));

        final double dragAmount = sliderCenter.dx - sliderLeftEdge.dx;

        // Simulate dragging the slider to the left
        // by the calculated drag amount
        await tester.dragFrom(sliderCenter, Offset(dragAmount, 0));
        await tester.pumpAndSettle();

        // Verify the updated value of the slider
        final updatedSlider = tester.widget<Slider>(sliderFinder);
        expect(updatedSlider.value, slider.min);
        expect(updatedSlider.value, -2 * pi);
      });
    }
  });
}
