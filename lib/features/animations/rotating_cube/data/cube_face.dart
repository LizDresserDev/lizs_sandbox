import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart';

/// Enum representing the direction of each face of the cube.
// ignore: public_member_api_docs
enum FaceDirection { front, back, left, right, top, bottom }

/// A class representing a single face of a 3D cube.
///
/// The CubeFace class encapsulates the properties of one face of a cube,
/// including its direction, color, transformation matrix, normal vector,
/// and the indices of its vertices in a vertex list.
class CubeFace {
  /// Const constructor for CubeFace
  const CubeFace(
    this.faceDirection,
    this.color,
    this.transform,
    this.normalVector,
    this.verticeOffsetIndices,
  );

  /// The direction this face is facing.
  final FaceDirection faceDirection;

  /// The color of the face.
  final Color color;

  /// The transformation matrix applied to the face when it is a
  /// part of the TransformedCube.
  ///
  /// This matrix defines how the face is transformed in 3D space.
  final Matrix4 transform;

  /// The normal vector of the face.
  ///
  /// The normal vector is perpendicular to the face and is used in calculating
  /// whether this face is facing the viewer or not (the calcuations are done
  /// using the isFacingViewer function)
  final Vector3 normalVector;

  /// The indices of the face's vertices in the vertex list,
  /// used when the face is a part of the DrawnCube.
  ///
  /// These indices are used to reference the vertices of the face in a shared
  /// vertex list, allowing efficient rendering of the cube.
  final List<int> verticeOffsetIndices;
}
