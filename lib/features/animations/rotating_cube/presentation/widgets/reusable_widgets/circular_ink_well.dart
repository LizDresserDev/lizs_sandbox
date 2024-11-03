import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// The recommended size for a tap target according
/// to the Material Design guidelines.
const double recommendedTapTargetSize = 48;

/// A circular button with an ink splash effect, using an InkWell.
///
/// The [CircularInkWell] widget creates a circular button
/// that responds to touch
/// events by displaying an ink splash effect. It can contain a child widget and
/// has customizable size and tap behavior.
class CircularInkWell extends StatelessWidget {
  /// Creates a [CircularInkWell] widget.
  ///
  /// The [onTap] callback is triggered when the button is tapped.
  /// The [size] parameter specifies the diameter
  /// of the circular button and defaults
  /// to [recommendedTapTargetSize].
  /// The [child] parameter can be used to specify the widget inside the button.
  const CircularInkWell({
    required this.onTap,
    super.key,
    this.size = recommendedTapTargetSize,
    this.child,
  });

  /// The diameter of the circular button.
  ///
  /// Defaults to [recommendedTapTargetSize] if not specified.
  final double size;

  /// Callback function to be invoked when the button is tapped.
  ///
  /// If [onTap] is null, the button will be disabled and its appearance will
  /// indicate it is not interactive.
  final VoidCallback? onTap;

  /// The widget to be displayed inside the circular button.
  ///
  /// This is typically an icon or a text widget.
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: onTap == null
            ? Theme.of(context).colorScheme.surface
            : Theme.of(context).colorScheme.secondaryContainer,
        shape: BoxShape.circle,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: onTap == null
              ? BorderRadius.zero
              : BorderRadius.circular(size / 2),
          child: Center(child: child),
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(
        DoubleProperty(
          'size',
          size,
        ),
      )
      ..add(
        ObjectFlagProperty<VoidCallback?>.has(
          'onTap',
          onTap,
        ),
      );
  }
}
