import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart';

/// Determines if a face of a cube is facing the viewer.
///
/// The [isFacingViewer] function computes whether a face with a given normal
/// vector is facing the viewer after applying the specified rotations around
/// the x, y, and z axes.
///
/// - [normalVector]: The normal vector of the face.
/// - [xAxisRotation]: The rotation around the x-axis in radians.
/// - [yAxisRotation]: The rotation around the y-axis in radians.
/// - [zAxisRotation]: The rotation around the z-axis in radians.
///
/// Returns `true` if the face is facing the viewer, `false` otherwise.
bool isFacingViewer(
  Vector3 normalVector, {
  required double xAxisRotation,
  required double yAxisRotation,
  required double zAxisRotation,
}) {
  // Clone the normal for this face
  Vector3 normal = normalVector.clone();

  // Create rotation matrices
  final Matrix4 rotationX = Matrix4.rotationX(xAxisRotation);
  final Matrix4 rotationY = Matrix4.rotationY(yAxisRotation);
  final Matrix4 rotationZ = Matrix4.rotationZ(zAxisRotation);

  // Apply rotations to the normal vector
  normal = rotationZ.transform3(normal);
  normal = rotationY.transform3(normal);
  normal = rotationX.transform3(normal);

  // View Direction (viewer) vector (points along the negative z-axis)
  final Vector3 viewDirection = Vector3(0, 0, -1);

  // Compute the dotProduct between the normal and the viewDirection
  // A positive dotProduct means that the face is facing the viewer
  final double dotProduct = normal.dot(viewDirection);

  // Corrects floating-point issue
  const double epsilon = .01;

  return dotProduct > epsilon;
}

/// Projects a 3D point onto a 2D plane using orthographic projection.
///
/// The [project] function maps a 3D point to a 2D point by applying a simple
/// orthographic projection. The x-coordinate remains the same, the y-coordinate
/// is flipped, and the z-coordinate is ignored.
///
/// - [point]: The 3D point to be projected.
/// - [center]: The center offset to apply to the projected point.
///
/// Returns an [Offset] representing the 2D projected point.
Offset project(Vector3 point, Offset center) {
  // Simple orthographic projection
  // Maps a 3D point to a 2D point

  // x stays the same sign
  // y axis has a flipped sign
  // z axis is ignored

  return Offset(point.x, -point.y) + center;
}
