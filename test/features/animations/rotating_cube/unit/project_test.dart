import 'package:flutter_test/flutter_test.dart';
import 'package:lizs_sandbox/features/animations/rotating_cube/utils/utils.dart';
import 'package:vector_math/vector_math_64.dart';

void main() {
  group('project 3D points onto 2D offsets', () {
    test('''origin point should not move from center when projected''', () {
      final Vector3 pointOfOrigin = Vector3(0, 0, 0);
      const Offset center = Offset.zero;

      final Offset projectPoint = project(pointOfOrigin, center);

      expect(projectPoint.dx, pointOfOrigin.x);
      expect(projectPoint.dy, pointOfOrigin.y);
    });

    test('''
positive position at (1,1,1) with origin at center (0,0)
    should be mapped to the positive along the X-axis (x value stays the same)
    and along the negative Y-axis (y sign flip)''', () {
      final Vector3 pointOfOrigin = Vector3(1, 1, 1);
      const Offset center = Offset.zero;

      final Offset projectPoint = project(pointOfOrigin, center);

      expect(projectPoint.dx, pointOfOrigin.x);
      expect(projectPoint.dy, -pointOfOrigin.y);
    });

    test('''
negative position at (-1-,1,-1) with origin at center (1,-1)
    should be mapped to an offset of (0,0)''', () {
      final Vector3 pointOfOrigin = Vector3(-1, -1, -1);
      const Offset center = Offset(1, -1);

      final Offset projectPoint = project(pointOfOrigin, center);

      expect(projectPoint.dx, 0);
      expect(projectPoint.dy, 0);
    });
  });
}
