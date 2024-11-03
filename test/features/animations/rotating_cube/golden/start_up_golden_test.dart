import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lizs_sandbox/features/animations/rotating_cube/presentation/pages/rotating_cube_page.dart';

void main() {
  testWidgets('RotatingCubePage startup golden test',
      (WidgetTester tester) async {
    // Build the widget
    await tester.pumpWidget(const MaterialApp(home: RotatingCubePage()));

    // Take a screenshot and compare with the golden file
    await expectLater(
      find.byType(RotatingCubePage),
      matchesGoldenFile('images/startup_golden.png'),
    );
  });
}
