import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lizs_sandbox/features/animations/rotating_cube/constants/widget_keys.dart';
import 'package:lizs_sandbox/features/animations/rotating_cube/presentation/pages/rotating_cube_page.dart';

void main() {
  testWidgets('Sliding the angle edit slider rotates cubes golden test',
      (WidgetTester tester) async {
    // Build the widget
    await tester.pumpWidget(const MaterialApp(home: RotatingCubePage()));

    // X-AXIS SLIDER
    // Find the X-Axis slider by key
    final sliderXAxisFinder = find.byKey(RotatingCubeWidgetKeys.sliderXAxis);
    expect(sliderXAxisFinder, findsOneWidget);

    // Scroll to the slider if it's off screen
    await tester.ensureVisible(sliderXAxisFinder);
    await tester.pumpAndSettle();

    // Calculate the drag amount to set the slider value
    // halfway to the maximum value
    final RenderBox xAxisSliderBox = tester.renderObject(sliderXAxisFinder);
    final Offset xAxisSliderCenter =
        xAxisSliderBox.localToGlobal(xAxisSliderBox.size.center(Offset.zero));
    final Offset xAxisSliderLeftEdge =
        xAxisSliderBox.localToGlobal(Offset(xAxisSliderBox.size.width, 0));

    final double xAxisDragAmount =
        (xAxisSliderLeftEdge.dx - xAxisSliderCenter.dx) / 2;

    // Simulate dragging the slider to the right
    // by the calculated drag amount
    await tester.dragFrom(xAxisSliderCenter, Offset(xAxisDragAmount, 0));
    await tester.pumpAndSettle();

    // Y-AXIS SLIDER
    // Find the Y-Axis slider by key
    final sliderYAxisFinder = find.byKey(RotatingCubeWidgetKeys.sliderYAxis);
    expect(sliderYAxisFinder, findsOneWidget);

    // Scroll to the slider if it's off screen
    await tester.ensureVisible(sliderYAxisFinder);
    await tester.pumpAndSettle();

    // Calculate the drag amount to set the slider value
    // halfway to the maximum value
    final RenderBox yAxisSliderBox = tester.renderObject(sliderYAxisFinder);
    final Offset yAxisSliderCenter =
        yAxisSliderBox.localToGlobal(yAxisSliderBox.size.center(Offset.zero));
    final Offset yAxisSliderLeftEdge =
        yAxisSliderBox.localToGlobal(Offset(yAxisSliderBox.size.width, 0));

    final double yAxisDragAmount =
        (yAxisSliderLeftEdge.dx - yAxisSliderCenter.dx) / 2;

    // Simulate dragging the slider to the right
    // by the calculated drag amount
    await tester.dragFrom(yAxisSliderCenter, Offset(yAxisDragAmount, 0));
    await tester.pumpAndSettle();

    // Z-AXIS SLIDER
    // Find the Z-Axis slider by key
    final sliderZAxisFinder = find.byKey(RotatingCubeWidgetKeys.sliderZAxis);
    expect(sliderZAxisFinder, findsOneWidget);

    // Scroll to the slider if it's off screen
    await tester.ensureVisible(sliderZAxisFinder);
    await tester.pumpAndSettle();

    // Calculate the drag amount to set the slider value
    // halfway to the maximum value
    final RenderBox zAxisSliderBox = tester.renderObject(sliderZAxisFinder);
    final Offset zAxisSliderCenter =
        zAxisSliderBox.localToGlobal(zAxisSliderBox.size.center(Offset.zero));
    final Offset zAxisSliderLeftEdge =
        zAxisSliderBox.localToGlobal(Offset(zAxisSliderBox.size.width, 0));

    final double zAxisDragAmount =
        (zAxisSliderLeftEdge.dx - zAxisSliderCenter.dx) / 2;

    // Simulate dragging the slider to the right
    // by the calculated drag amount
    await tester.dragFrom(zAxisSliderCenter, Offset(zAxisDragAmount, 0));
    await tester.pumpAndSettle();

    // Take a screenshot and compare with the golden file
    await expectLater(
      find.byType(RotatingCubePage),
      matchesGoldenFile('images/angle_edit_sliders_golden.png'),
    );
  });
}
