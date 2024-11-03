import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lizs_sandbox/features/animations/rotating_cube/presentation/widgets/reusable_widgets/circular_ink_well.dart';

/// Enum representing the rotation axis.
// ignore: public_member_api_docs
enum RotationAxis { x, y, z }

/// An abstract widget for editing angles in a 3D space.
///
/// The [AngleEditWidget] class provides a base for widgets that
/// modify the rotation angles around a specific axis. It contains
/// the common properties and methods needed for angle editing.
abstract class AngleEditWidget extends StatelessWidget {
  /// Creates an [AngleEditWidget].
  ///
  /// The [rotationAxis] parameter specifies the axis of rotation.
  /// The [label] parameter specifies the label of the widget.
  /// The [currentRotationValue] parameter specifies the current rotation value.
  /// The [updateRotationValues] callback is used to update the rotation values.
  const AngleEditWidget({
    required this.rotationAxis,
    required this.label,
    required this.currentRotationValue,
    required this.updateRotationValues,
    super.key,
  });

  /// The axis of rotation.
  final RotationAxis rotationAxis;

  /// The label of the widget.
  final String label;

  /// The current rotation value.
  final double currentRotationValue;

  /// Callback function to update the rotation values.
  final void Function({
    required double? newRx,
    required double? newRy,
    required double? newRz,
  }) updateRotationValues;

  /// Updates the angle based on the [newAngle] provided.
  ///
  /// This method updates the rotation value for the specified axis.
  void updateAngle(double newAngle) {
    switch (rotationAxis) {
      case RotationAxis.x:
        updateRotationValues(
          newRx: newAngle,
          newRy: null,
          newRz: null,
        );
      case RotationAxis.y:
        updateRotationValues(
          newRx: null,
          newRy: newAngle,
          newRz: null,
        );
      case RotationAxis.z:
        updateRotationValues(
          newRx: null,
          newRy: null,
          newRz: newAngle,
        );
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(
        DoubleProperty(
          'currentRotationValue',
          currentRotationValue,
        ),
      )
      ..add(
        EnumProperty<RotationAxis>(
          'rotationAxis',
          rotationAxis,
        ),
      )
      ..add(StringProperty('label', label))
      ..add(
        ObjectFlagProperty<
            void Function({
              required double? newRx,
              required double? newRy,
              required double? newRz,
            })>.has(
          'updateRotationValues',
          updateRotationValues,
        ),
      );
  }
}

/// A widget that provides buttons for editing the rotation angle.
///
/// The [AngleEditButtonSection] class displays buttons that allow
/// the user to increment or decrement the rotation angle by predefined values.
class AngleEditButtonSection extends AngleEditWidget {
  /// Creates an [AngleEditButtonSection].
  ///
  /// The [buttonKeys] parameter specifies the keys for the buttons.
  const AngleEditButtonSection({
    required super.rotationAxis,
    required super.label,
    required super.currentRotationValue,
    required super.updateRotationValues,
    required this.buttonKeys,
    super.key,
  }) : assert(
          buttonKeys.length == 4,
          'There should be exactly 4 button keys provided',
        );

  /// The keys for the buttons.
  final List<Key> buttonKeys;

  /// Builds a row of buttons for editing the angle.
  ///
  /// The [angleIncrement] parameter specifies the amount to increment/decrement.
  /// The [keys] parameter specifies the keys for the buttons.
  Row _buildButtonRow(double angleIncrement, List<Key> keys) {
    return Row(
      children: [
        CircularInkWell(
          key: keys[0],
          size: 24,
          onTap: () => updateAngle(currentRotationValue + angleIncrement),
          child: const Text('+'),
        ),
        const SizedBox(width: 4),
        CircularInkWell(
          key: keys[1],
          size: 24,
          onTap: () => updateAngle(currentRotationValue - angleIncrement),
          child: const Text('-'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(label),
        const Text('(π / 6)'),
        _buildButtonRow(pi / 6, buttonKeys.sublist(0, 2)),
        const Text('(π / 180)'),
        _buildButtonRow(pi / 180, buttonKeys.sublist(2, 4)),
      ],
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IterableProperty<Key>('buttonKeys', buttonKeys));
  }
}

/// A widget that provides a slider for editing the rotation angle.
///
/// The [AngleEditSlider] class displays a slider that allows
/// the user to adjust the rotation angle smoothly.
class AngleEditSlider extends AngleEditWidget {
  /// Creates an [AngleEditSlider].
  ///
  /// The [sliderKey] parameter specifies the key for the slider.
  const AngleEditSlider({
    required this.sliderKey,
    required super.rotationAxis,
    required super.label,
    required super.currentRotationValue,
    required super.updateRotationValues,
    super.key,
  });

  /// The key for the slider.
  final Key sliderKey;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(label),
        Expanded(
          child: Slider(
            key: sliderKey,
            min: -2 * pi,
            max: 2 * pi,
            value: currentRotationValue,
            onChanged: updateAngle,
          ),
        ),
      ],
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Key>('sliderKey', sliderKey));
  }
}
