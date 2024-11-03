import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:lizs_sandbox/features/animations/rotating_cube/constants/widget_keys.dart';
import 'package:lizs_sandbox/features/animations/rotating_cube/presentation/pages/rotating_cube_page.dart';

import '../constants.dart';

void main() {
  testWidgets('Initially show 0 radians and 0 degree text widgets',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MaterialApp(home: RotatingCubePage()));

    // Find the radians text on the page
    final radiansTextFinder = find.byKey(RotatingCubeWidgetKeys.radiansText);

    // Verify the radians text is on the page once
    expect(radiansTextFinder, findsOneWidget);

    // Check initial value of radians text
    final Text radiansTextWidget = tester.widget<Text>(radiansTextFinder);
    expect(radiansTextWidget.data, initialRadiansString);

    // Find the degrees text on the page
    final degreesTextFinder = find.byKey(RotatingCubeWidgetKeys.degreesText);

    // Verify the degrees text is on the page once
    expect(degreesTextFinder, findsOneWidget);

    // Check initial value of degrees text
    final Text degreesTextWidget = tester.widget<Text>(degreesTextFinder);
    expect(degreesTextWidget.data, initialDegreesString);
  });
}
