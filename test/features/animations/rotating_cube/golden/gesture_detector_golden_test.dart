import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lizs_sandbox/features/animations/rotating_cube/constants/widget_keys.dart';
import 'package:lizs_sandbox/features/animations/rotating_cube/presentation/pages/rotating_cube_page.dart';

void main() {
  testWidgets(
      'GestureDetector onPanUpdate udpates the position variables golden test',
      (WidgetTester tester) async {
    // Build the widget
    await tester.pumpWidget(const MaterialApp(home: RotatingCubePage()));

    // Find the GestureDetector widget using its key
    final gestureDetectorFinder =
        find.byKey(RotatingCubeWidgetKeys.drawnCubeGestureDetector);

    // Verify the GestureDetector is present in the widget tree
    expect(gestureDetectorFinder, findsOneWidget);

    // Get the global position of the GestureDetector
    final RenderBox gestureDetectorBox =
        tester.renderObject(gestureDetectorFinder);
    final Offset gestureDetectorPosition =
        gestureDetectorBox.localToGlobal(Offset.zero);

    // Create DragUpdateDetails with specific delta values
    final DragUpdateDetails details1 = DragUpdateDetails(
      delta: const Offset(-50, -50),
      globalPosition: gestureDetectorPosition + const Offset(-50, -50),
    );

    // Trigger the onPanUpdate callback
    final gestureDetector =
        tester.widget<GestureDetector>(gestureDetectorFinder);
    gestureDetector.onPanUpdate!(details1);
    await tester
        .pumpAndSettle(); // Rebuild the widget after the state has changed

    // Take a screenshot and compare with the golden file
    await expectLater(
      find.byType(RotatingCubePage),
      matchesGoldenFile('images/gesture_detector_golden.png'),
    );
  });
}
