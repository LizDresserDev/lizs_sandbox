import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:lizs_sandbox/features/animations/rotating_cube/utils/utils.dart';
import 'package:vector_math/vector_math_64.dart';

void main() {
  group('isFacingViewer returns correct bool for faces', () {
    // isFacingViewer should return false
    // for each face facing away at the start should
    // isFacingViewer should return true
    // for the front face at the start

    // FRONT OF CUBE - facing toward viewer
    test(
        '''isFacingViewer returns true for the front face if no rotation is applied''',
        () {
      final Vector3 faceNormal = Vector3(0, 0, -1);
      // apply a rotation to the normal
      final bool result = isFacingViewer(
        faceNormal,
        xAxisRotation: 0,
        yAxisRotation: 0,
        zAxisRotation: 0,
      );

      expect(result, isTrue);
    });

    // FRONT OF CUBE - facing away from the viewer
    test(
        '''isFacingViewer returns true for the front face if no rotation is applied''',
        () {
      final Vector3 faceNormal = Vector3(0, 0, -1);

      // apply a rotation to the normal
      const double xAxisRotation = pi / 2;
      const double yAxisRotation = 0;
      const double zAxisRotation = 0;

      final bool result = isFacingViewer(
        faceNormal,
        xAxisRotation: xAxisRotation,
        yAxisRotation: yAxisRotation,
        zAxisRotation: zAxisRotation,
      );

      expect(result, isFalse);
    });

    // faceVectorList contains a list of vectors and the rotation
    // either along the X or Y axis that will turn the face toward the viewer
    final List<(Vector3, double?, double?)> faceVectorList = [
      (Vector3(0, 0, 1), pi, null), //back
      (Vector3(1, 0, 0), null, pi / 2), //left
      (Vector3(-1, 0, 0), null, -pi / 2), //right
      (Vector3(0, -1, 0), pi / 2, null), //top
      (Vector3(0, 1, 0), -pi / 2, null), //bottom
    ];

    for (final face in faceVectorList) {
      // FACE - originally faces away from the viewer
      test(
          '''isFacingViewer returns false for any non-front facing face if no rotation is applied''',
          () {
        final Vector3 faceNormal = face.$1;
        // apply a rotation to the normal
        final bool result = isFacingViewer(
          faceNormal,
          xAxisRotation: 0,
          yAxisRotation: 0,
          zAxisRotation: 0,
        );

        expect(result, isFalse);
      });

      // FRONT OF CUBE - facing away from the viewer
      test(
          '''isFacingViewer returns true for the front face if no rotation is applied''',
          () {
        final Vector3 faceNormal = face.$1;

        // apply a rotation to the normal
        final double xAxisRotation = face.$2 ?? 0;
        final double yAxisRotation = face.$3 ?? 0;
        const double zAxisRotation = 0;

        final bool result = isFacingViewer(
          faceNormal,
          xAxisRotation: xAxisRotation,
          yAxisRotation: yAxisRotation,
          zAxisRotation: zAxisRotation,
        );

        expect(result, isTrue);
      });
    }
  });
}
