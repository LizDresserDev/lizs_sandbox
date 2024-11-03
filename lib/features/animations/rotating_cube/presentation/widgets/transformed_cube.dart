import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lizs_sandbox/features/animations/rotating_cube/data/cube_face.dart';

/// A widget that displays a 3D transformed cube with visible faces.
///
/// The [TransformedCube] class takes a list of [CubeFace] objects and
/// displays them as faces of a cube, transformed according to the provided
/// transformation matrices.
class TransformedCube extends StatelessWidget {
  /// Creates a [TransformedCube] widget.
  ///
  /// The [visibleCubeFaces] parameter specifies the list of faces
  /// that are visible. The [cubeSideLength] parameter specifies the length
  /// of each side of the cube.
  const TransformedCube({
    required this.visibleCubeFaces,
    required this.cubeSideLength,
    super.key,
  });

  /// A list of visible faces of the cube.
  final List<CubeFace> visibleCubeFaces;

  /// The length of each side of the cube.
  final double cubeSideLength;

  @override
  Widget build(BuildContext context) {
    final List<Widget> cubeFaceList = visibleCubeFaces.map((face) {
      return Transform(
        transform: face.transform,
        alignment: Alignment.center,
        child: Container(
          width: cubeSideLength,
          height: cubeSideLength,
          color: face.color,
          child: const FlutterLogo(),
        ),
      );
    }).toList();
    return Stack(alignment: Alignment.center, children: cubeFaceList);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(IterableProperty<CubeFace>('visibleCubeFaces', visibleCubeFaces))
      ..add(DoubleProperty('cubeSideLength', cubeSideLength));
  }
}
