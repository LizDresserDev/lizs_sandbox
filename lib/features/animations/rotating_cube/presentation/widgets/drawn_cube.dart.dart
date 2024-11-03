import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lizs_sandbox/features/animations/rotating_cube/data/cube_face.dart';
import 'package:lizs_sandbox/features/animations/rotating_cube/presentation/widgets/custom_painters/cube_face_painter.dart';

/// A widget that draws a 3D cube with visible faces.
///
/// The [DrawnCube] class uses a list of [CubeFace] objects to represent
/// the visible faces of the cube. It also requires the projected
/// vertex offsets and the length of the cube's side.
class DrawnCube extends StatelessWidget {
  /// Const constructor for a [DrawnCube] widget.
  ///
  /// The [visibleCubeFaces] parameter specifies the list of faces
  /// that are visible. The [projectedVerticeOffsets] parameter specifies
  /// the projected 2D offsets of the cube's vertices. The [cubeSideLength]
  /// parameter specifies the length of each side of the cube.
  const DrawnCube({
    required this.visibleCubeFaces,
    required this.projectedVerticeOffsets,
    required this.cubeSideLength,
    super.key,
  });

  /// A list of visible faces of the cube.
  final List<CubeFace> visibleCubeFaces;

  /// The projected 2D offsets of the cube's vertices.
  final List<Offset> projectedVerticeOffsets;

  /// The length of each side of the cube.
  final double cubeSideLength;

  @override
  Widget build(BuildContext context) {
    // List of drawn cube faces
    final List<Widget> drawnCubeFaces = visibleCubeFaces.map((face) {
      return CustomPaint(
        painter: CubeFacePainter(face, projectedVerticeOffsets),
      );
    }).toList();

    // Stack of drawn cube faces
    return Stack(
      alignment: Alignment.center,
      children: drawnCubeFaces,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(
        IterableProperty<CubeFace>(
          'visibleCubeFaces',
          visibleCubeFaces,
        ),
      )
      ..add(
        IterableProperty<Offset>(
          'projectedVerticeOffsets',
          projectedVerticeOffsets,
        ),
      )
      ..add(
        DoubleProperty(
          'cubeSideLength',
          cubeSideLength,
        ),
      );
  }
}
