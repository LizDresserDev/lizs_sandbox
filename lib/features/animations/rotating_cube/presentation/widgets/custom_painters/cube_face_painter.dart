import 'package:flutter/material.dart';
import 'package:lizs_sandbox/features/animations/rotating_cube/data/cube_face.dart';

/// A custom painter that paints a single face of a 3D cube.
///
/// The [CubeFacePainter] class takes a [CubeFace] object and a list of
/// projected 2D vertex offsets to draw the visible face of a cube.
class CubeFacePainter extends CustomPainter {
  /// Creates a [CubeFacePainter] with the given visible face
  /// and projected vertex offsets.
  ///
  /// The [visibleCubeFace] parameter specifies the face of
  /// the cube to be drawn.
  /// The [projectedVerticeOffsets] parameter specifies
  /// the projected 2D offsets
  /// of the cube's vertices.
  const CubeFacePainter(
    this.visibleCubeFace,
    this.projectedVerticeOffsets,
  );

  /// The face of the cube to be drawn.
  final CubeFace visibleCubeFace;

  /// The projected 2D offsets of the cube's vertices.
  final List<Offset> projectedVerticeOffsets;

  @override
  void paint(Canvas canvas, Size size) {
    final Path path = Path();

    // Flag to check if it's the first vertex and we should use moveTo
    // or if this is a subsequent vertex and we should use lineTo
    bool isFirstVertice = true;
    for (final index in visibleCubeFace.verticeOffsetIndices) {
      final Offset projectedVerticeOffset = projectedVerticeOffsets[index];
      if (isFirstVertice) {
        // Move to the first vertex position.
        path.moveTo(projectedVerticeOffset.dx, projectedVerticeOffset.dy);
        isFirstVertice = false;
      } else {
        // Draw a line to the next vertex position.
        path.lineTo(projectedVerticeOffset.dx, projectedVerticeOffset.dy);
      }
    }
    // Close the path to create a closed shape.
    path.close();

    // Define the paint object with the face color and fill style.
    final Paint paint = Paint()
      ..color = visibleCubeFace.color
      ..style = PaintingStyle.fill;

    // Draw the path on the canvas.
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // Always repaint
    return true;
  }
}
