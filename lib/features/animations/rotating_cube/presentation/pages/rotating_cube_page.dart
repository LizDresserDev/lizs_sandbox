import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lizs_sandbox/features/animations/rotating_cube/constants/widget_keys.dart';
import 'package:lizs_sandbox/features/animations/rotating_cube/data/cube_face.dart';
import 'package:lizs_sandbox/features/animations/rotating_cube/presentation/widgets/drawn_cube.dart.dart';
import 'package:lizs_sandbox/features/animations/rotating_cube/presentation/widgets/reusable_widgets/angle_edit_widget.dart';
import 'package:lizs_sandbox/features/animations/rotating_cube/presentation/widgets/transformed_cube.dart';
import 'package:lizs_sandbox/features/animations/rotating_cube/utils/utils.dart';
import 'package:vector_math/vector_math_64.dart' hide Colors;

/// Displays a drawn and transformed rotating 3D cube.
///
/// The [RotatingCubePage] widget provides an interface to view
/// and manipulate a 3D cube,
/// allowing rotations around the x, y, and z axes. The cube can be controlled
/// manually via sliders and buttons or animated automatically.
class RotatingCubePage extends StatefulWidget {
  const RotatingCubePage({super.key});
  @override
  State<RotatingCubePage> createState() => _RotatingCubePageState();
}

class _RotatingCubePageState extends State<RotatingCubePage>
    with SingleTickerProviderStateMixin {
  double _rx = 0.0; // rotation about the X-axis, in radians
  double _ry = 0.0; // rotation about the Y-axis, in radians
  double _rz = 0.0; // rotation about the Z-axis, in radians

  late final Offset center;
  final double cubeSideLength = 125;
  late final double cubeDiagonalLength;

  late final List<Vector3> scaledVertices;
  List<Offset> projectedVerticeOffsets = [];

  late final List<CubeFace> cubeFaces;
  List<CubeFace> visibleCubeFaces = [];

  Matrix4 transformCubeTransform = Matrix4.identity();
  Matrix4 drawnCubeTransform = Matrix4.identity();

  bool doAutoAnimate = false;

  late AnimationController _controller;
  late Animation<double> _animationRx;
  late Animation<double> _animationRy;
  late Animation<double> _animationRz;

  @override
  void initState() {
    super.initState();
    initializeCube();
    initializeAnimationController();
    updateRotationValues(
      newRx: _rx,
      newRy: _ry,
      newRz: _rz,
    );
  }

  /// Initializes the cube's vertices and faces.
  ///
  /// This method sets up the cube's vertices and faces, scaling them
  /// according to the cube side length.
  void initializeCube() {
    cubeDiagonalLength = cubeSideLength * sqrt(3);
    final double halfCubeSideLength = cubeSideLength / 2;
    center = Offset(halfCubeSideLength, halfCubeSideLength);

    scaledVertices = [
      Vector3(-1, -1, -1) * halfCubeSideLength,
      Vector3(1, -1, -1) * halfCubeSideLength,
      Vector3(1, 1, -1) * halfCubeSideLength,
      Vector3(-1, 1, -1) * halfCubeSideLength,
      Vector3(-1, -1, 1) * halfCubeSideLength,
      Vector3(1, -1, 1) * halfCubeSideLength,
      Vector3(1, 1, 1) * halfCubeSideLength,
      Vector3(-1, 1, 1) * halfCubeSideLength,
    ];

    cubeFaces = [
      CubeFace(
        FaceDirection.front,
        Colors.teal,
        Matrix4.identity()..translate(0.0, 0.0, -halfCubeSideLength),
        Vector3(0, 0, -1),
        const [0, 1, 2, 3],
      ), // front
      CubeFace(
        FaceDirection.back,
        Colors.red,
        Matrix4.identity()
          ..translate(0.0, 0.0, halfCubeSideLength)
          ..rotateY(-pi),
        Vector3(0, 0, 1),
        const [4, 5, 6, 7],
      ), // back
      CubeFace(
        FaceDirection.left,
        Colors.amber,
        Matrix4.identity()
          // ignore: avoid_redundant_argument_values
          ..translate(halfCubeSideLength, 0.0, 0.0)
          ..rotateY(-pi / 2),
        Vector3(1, 0, 0),
        const [1, 2, 6, 5],
      ), // left

      CubeFace(
        FaceDirection.right,
        Colors.purple,
        Matrix4.identity()
          // ignore: avoid_redundant_argument_values
          ..translate(-halfCubeSideLength, 0.0, 0.0)
          ..rotateY(pi / 2),
        Vector3(-1, 0, 0),
        const [0, 3, 7, 4],
      ), // right
      CubeFace(
        FaceDirection.bottom,
        Colors.grey[800]!,
        Matrix4.identity()
          // ignore: avoid_redundant_argument_values
          ..translate(0.0, halfCubeSideLength, 0.0)
          ..rotateX(pi / 2),
        Vector3(0, 1, 0),
        const [0, 1, 5, 4],
      ), // bottom

      CubeFace(
        FaceDirection.top,
        Colors.grey[300]!,
        Matrix4.identity()
          // ignore: avoid_redundant_argument_values
          ..translate(0.0, -halfCubeSideLength, 0.0)
          ..rotateX(-pi / 2),
        Vector3(0, -1, 0),
        const [2, 3, 7, 6],
      ), // top
    ];
  }

  /// Initializes the animation controller for automatic cube rotation.
  ///
  /// Sets up the animation controller and defines the animations for
  /// rotating the cube around the x, y, and z axes.
  void initializeAnimationController() {
    _controller =
        AnimationController(duration: const Duration(seconds: 5), vsync: this);

    _animationRx = Tween<double>(begin: 0, end: 2 * pi).animate(_controller);
    _animationRy = Tween<double>(begin: 0, end: 2 * pi).animate(_controller);
    _animationRz = Tween<double>(begin: 0, end: 2 * pi).animate(_controller);

    _controller.addListener(() {
      updateRotationValues(
        newRx: _animationRx.value,
        newRy: _animationRy.value,
        newRz: _animationRz.value,
      );
    });
  }

  /// Updates the rotation values and transforms the cube.
  ///
  /// This method updates the rotation values based on the provided
  /// new rotation values for the x, y, and z axes. It also transforms
  /// the cube and updates the list of visible faces.
  void updateRotationValues({
    required double? newRx,
    required double? newRy,
    required double? newRz,
  }) {
    setState(() {
      if (newRx != null) {
        _rx = newRx.clamp(-2 * pi, 2 * pi);
      }

      if (newRy != null) {
        _ry = newRy.clamp(-2 * pi, 2 * pi);
      }

      if (newRz != null) {
        _rz = newRz.clamp(-2 * pi, 2 * pi);
      }

      transformCubeTransform = Matrix4.identity()
        ..rotateX(_rx)
        ..rotateY(_ry)
        ..rotateZ(_rz);

      drawnCubeTransform = Matrix4.identity()
        ..rotateX(-_rx)
        ..rotateY(_ry)
        ..rotateZ(-_rz);

      // Clear visible cube faces
      visibleCubeFaces.clear();
      // Iterate through cubeFaces to determine which should
      // now be facing the viewer given the rotations
      for (final face in cubeFaces) {
        final result = isFacingViewer(
          face.normalVector,
          xAxisRotation: _rx,
          yAxisRotation: _ry,
          zAxisRotation: _rz,
        );
        if (result) {
          visibleCubeFaces.add(face);
        }
      }

      // Clear list of projected vertices
      projectedVerticeOffsets.clear();
      projectedVerticeOffsets = scaledVertices.map((vertice) {
        // Rotate out point
        final Vector3 transformed3DPoint =
            drawnCubeTransform.transform3(vertice.clone());
        return project(transformed3DPoint, center);
      }).toList();
    });
  }

  /// Toggles the automatic animation of the cube rotation.
  ///
  /// This method starts or stops the automatic rotation animation
  /// based on the current state.
  void toggleAnimation() {
    setState(() {
      doAutoAnimate = !doAutoAnimate;
      if (doAutoAnimate) {
        _controller.repeat();
      } else {
        _controller
          ..value = 0
          ..stop();
      }
    });
  }

  /// Handles the pan update gesture to manually rotate the cube.
  ///
  /// This method updates the rotation values based on the pan gesture,
  /// allowing manual control of the cube's rotation.
  void onPanUpdate(DragUpdateDetails details) {
    if (doAutoAnimate) {
      return;
    }

    // Calculate the new _rx and _ry values
    final double newRx = _rx + details.delta.dy * 0.01;
    final double newRy = _ry - details.delta.dx * 0.01;

    // Normalize the rotation values to be
    // within the expected range (-2pi to 2pi)
    final double boundedRx = newRx.clamp(-2 * pi, 2 * pi);
    final double boundedRy = newRy.clamp(-2 * pi, 2 * pi);

    updateRotationValues(newRx: boundedRx, newRy: boundedRy, newRz: null);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Rotating Cubes with Back-Culling'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            DecoratedBox(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondaryContainer,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2), // Shadow color
                    spreadRadius: 2, // Spread radius
                    blurRadius: 6, // Blur radius
                    offset: const Offset(0, 3), // Shadow position (x, y)
                  ),
                ],
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(8.0),
                  bottomRight: Radius.circular(8.0),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        key: RotatingCubeWidgetKeys.reset,
                        onPressed: doAutoAnimate
                            ? null
                            : () => updateRotationValues(
                                  newRx: 0,
                                  newRy: 0,
                                  newRz: 0,
                                ),
                        child: const Text('Reset'),
                      ),
                      ElevatedButton(
                        key: RotatingCubeWidgetKeys.animate,
                        onPressed: toggleAnimation,
                        child: doAutoAnimate
                            ? const Text('Come Back!')
                            : const Text('Be Free!'),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: Text(
                          key: RotatingCubeWidgetKeys.radiansText,
                          '''Radians: ${_rx.toStringAsFixed(2)}, ${_ry.toStringAsFixed(2)}, ${_rz.toStringAsFixed(2)}''',
                        ),
                      ),
                      Expanded(
                        child: Text(
                          key: RotatingCubeWidgetKeys.degreesText,
                          '''Degrees: ${degrees(_rx).toStringAsFixed(1)}°, ${degrees(_ry).toStringAsFixed(1)}°, ${degrees(_rz).toStringAsFixed(1)}°''',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            //Drawn cube
            GestureDetector(
              key: RotatingCubeWidgetKeys.drawnCubeGestureDetector,
              onPanUpdate: onPanUpdate,
              child: SizedBox(
                height: cubeDiagonalLength,
                width: cubeDiagonalLength,
                child: ColoredBox(
                  color: Colors.transparent,
                  child: Transform.translate(
                    offset: Offset(-cubeSideLength / 2, -cubeSideLength / 2),
                    child: DrawnCube(
                      visibleCubeFaces: visibleCubeFaces,
                      projectedVerticeOffsets: projectedVerticeOffsets,
                      cubeSideLength: cubeSideLength,
                    ),
                  ),
                ),
              ),
            ),
            //Transform cube
            GestureDetector(
              key: RotatingCubeWidgetKeys.transformedCubeGestureDetector,
              onPanUpdate: onPanUpdate,
              child: SizedBox(
                height: cubeDiagonalLength,
                width: cubeDiagonalLength,
                child: ColoredBox(
                  color: Colors.transparent,
                  child: Transform(
                    alignment: Alignment.center,
                    transform: transformCubeTransform,
                    child: TransformedCube(
                      visibleCubeFaces: visibleCubeFaces,
                      cubeSideLength: cubeSideLength,
                    ),
                  ),
                ),
              ),
            ),
            // Sliders
            if (!doAutoAnimate)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  children: [
                    AngleEditSlider(
                      label: 'X-Axis',
                      rotationAxis: RotationAxis.x,
                      currentRotationValue: _rx,
                      updateRotationValues: updateRotationValues,
                      sliderKey: RotatingCubeWidgetKeys.sliderXAxis,
                    ),
                    AngleEditSlider(
                      label: 'Y-Axis',
                      rotationAxis: RotationAxis.y,
                      currentRotationValue: _ry,
                      updateRotationValues: updateRotationValues,
                      sliderKey: RotatingCubeWidgetKeys.sliderYAxis,
                    ),
                    AngleEditSlider(
                      label: 'Z-Axis',
                      rotationAxis: RotationAxis.z,
                      currentRotationValue: _rz,
                      updateRotationValues: updateRotationValues,
                      sliderKey: RotatingCubeWidgetKeys.sliderZAxis,
                    ),
                  ],
                ),
              ),
            // Buttons
            if (!doAutoAnimate)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  AngleEditButtonSection(
                    label: 'X-Axis',
                    rotationAxis: RotationAxis.x,
                    currentRotationValue: _rx,
                    updateRotationValues: updateRotationValues,
                    buttonKeys: const [
                      RotatingCubeWidgetKeys.plusPiOver6XAxis,
                      RotatingCubeWidgetKeys.minusPiOver6XAxis,
                      RotatingCubeWidgetKeys.plusPiOver180XAxis,
                      RotatingCubeWidgetKeys.minusPiOver180XAxis,
                    ],
                  ),
                  AngleEditButtonSection(
                    label: 'Y-Axis',
                    rotationAxis: RotationAxis.y,
                    currentRotationValue: _ry,
                    updateRotationValues: updateRotationValues,
                    buttonKeys: const [
                      RotatingCubeWidgetKeys.plusPiOver6YAxis,
                      RotatingCubeWidgetKeys.minusPiOver6YAxis,
                      RotatingCubeWidgetKeys.plusPiOver180YAxis,
                      RotatingCubeWidgetKeys.minusPiOver180YAxis,
                    ],
                  ),
                  AngleEditButtonSection(
                    label: 'Z-Axis',
                    rotationAxis: RotationAxis.z,
                    currentRotationValue: _rz,
                    updateRotationValues: updateRotationValues,
                    buttonKeys: const [
                      RotatingCubeWidgetKeys.plusPiOver6ZAxis,
                      RotatingCubeWidgetKeys.minusPiOver6ZAxis,
                      RotatingCubeWidgetKeys.plusPiOver180ZAxis,
                      RotatingCubeWidgetKeys.minusPiOver180ZAxis,
                    ],
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(
        DiagnosticsProperty<Offset>(
          'center',
          center,
        ),
      )
      ..add(
        DoubleProperty(
          'cubeSideLength',
          cubeSideLength,
        ),
      )
      ..add(
        DoubleProperty(
          'cubeDiagonalLength',
          cubeDiagonalLength,
        ),
      )
      ..add(
        IterableProperty<Vector3>(
          'scaledVertices',
          scaledVertices,
        ),
      )
      ..add(
        IterableProperty<Offset>(
          'projectedVerticeOffsets',
          projectedVerticeOffsets,
        ),
      )
      ..add(
        IterableProperty<CubeFace>(
          'cubeFaces',
          cubeFaces,
        ),
      )
      ..add(
        IterableProperty<CubeFace>(
          'visibleCubeFaces',
          visibleCubeFaces,
        ),
      )
      ..add(
        TransformProperty(
          'transformCubeTransform',
          transformCubeTransform,
        ),
      )
      ..add(
        TransformProperty(
          'drawnCubeTransform',
          drawnCubeTransform,
        ),
      )
      ..add(
        DiagnosticsProperty<bool>(
          'doAutoAnimate',
          doAutoAnimate,
        ),
      );
  }
}
