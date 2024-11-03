import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lizs_sandbox/features/animations/rotating_cube/constants/widget_keys.dart';
import 'package:lizs_sandbox/features/animations/rotating_cube/presentation/pages/rotating_cube_page.dart';

void main() {
  testWidgets('Tapping angle edit button rotates cubes golden test',
      (WidgetTester tester) async {
    // Build the widget
    await tester.pumpWidget(const MaterialApp(home: RotatingCubePage()));

    // Find the plusPiOver6XAxis button by key
    final plusPiOver6XAxisButtonFinder =
        find.byKey(RotatingCubeWidgetKeys.plusPiOver6XAxis);
    expect(plusPiOver6XAxisButtonFinder, findsOneWidget);

    // Scroll to the widget if it's off screen
    await tester.ensureVisible(plusPiOver6XAxisButtonFinder);
    await tester.pumpAndSettle();

    // Tap the button
    await tester.tap(plusPiOver6XAxisButtonFinder);
    await tester.pumpAndSettle();

    // Find the plusPiOver6XAxis button by key
    final plusPiOver6YAxisButtonFinder =
        find.byKey(RotatingCubeWidgetKeys.plusPiOver6YAxis);
    expect(plusPiOver6YAxisButtonFinder, findsOneWidget);

    // Scroll to the widget if it's off screen
    await tester.ensureVisible(plusPiOver6YAxisButtonFinder);
    await tester.pumpAndSettle();

    // Tap the button
    await tester.tap(plusPiOver6YAxisButtonFinder);
    await tester.pumpAndSettle();

    // Take a screenshot and compare with the golden file
    await expectLater(
      find.byType(RotatingCubePage),
      matchesGoldenFile('images/angle_edit_buttons_golden.png'),
    );
  });
}
