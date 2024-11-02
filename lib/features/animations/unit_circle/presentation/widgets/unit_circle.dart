import 'dart:math';
import 'package:flutter/material.dart';
import 'package:lizs_sandbox/features/animations/unit_circle/constants/constants.dart';
import 'package:lizs_sandbox/features/animations/unit_circle/presentation/widgets/custom_painters/axis_painter.dart';
import 'package:lizs_sandbox/features/animations/unit_circle/presentation/widgets/custom_painters/circle_painter.dart';
import 'package:lizs_sandbox/features/animations/unit_circle/presentation/widgets/custom_painters/composite_painter.dart';
import 'package:lizs_sandbox/features/animations/unit_circle/presentation/widgets/custom_painters/fraction_painter.dart';
import 'package:lizs_sandbox/features/animations/unit_circle/presentation/widgets/custom_painters/point_painter.dart';
import 'package:lizs_sandbox/features/animations/unit_circle/utils/functions.dart';

class UnitCircle extends StatelessWidget {
  UnitCircle({
    super.key,
    this.controller,
    this.animation,
    this.size = const Size(300, 300),
    this.showNormalUnitCircle = false,
  }) : assert(size.width == size.height);
  final Size size;
  final AnimationController? controller;
  final Animation<double>? animation;
  final bool showNormalUnitCircle;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller!,
      builder: (context, child) {
        // CIRCLE
        List<Widget> painters = [
          CustomPaint(size: size, painter: CirclePainter())
        ];

        // GRAPH
        painters.add(
          CustomPaint(
            size: size,
            painter: AxisPainter(showNormalUnitCircle
                ? OriginLocation.center
                : OriginLocation.topLeft),
          ),
        );

        final Offset centerOfCircle = Offset(size.width / 2, size.height / 2);

        final double circleRadius = size.width / 2;

        // POINTS ON THE CIRCLE
        for (int i = 0; i < anglesInRadians.length; i++) {
          final Offset pointOffset = findPoint(
            showNormalUnitCircle
                ? 2 * pi - anglesInRadians[i]
                : anglesInRadians[i],
            centerOfCircle,
            circleRadius,
          );
          // POINTS ON THE CIRCLE
          painters.add(CustomPaint(
            size: size,
            painter: PointPainter(
              pointOffset,
              colors[i],
            ),
          ));

          // RADS OUTSIDE OF THE CIRCLE
          final Offset radianOffset = findPoint(
            showNormalUnitCircle
                ? 2 * pi - anglesInRadians[i]
                : anglesInRadians[i],
            centerOfCircle,
            circleRadius + 20,
          );
          late String angleInRadsStr;
          if (i == 0) {
            angleInRadsStr = showNormalUnitCircle
                ? zeroRadsNormalUnitCircle
                : zeroRadsFlutterUnitCircle;
          } else {
            angleInRadsStr =
                i == anglesInRadStrings.length ? '' : anglesInRadStrings[i].$1;
          }
          painters.add(
            CustomPaint(
              size: size,
              painter: CompositePainter(
                positions: [radianOffset],
                innerPainter: CenteredPainter(
                  innerPainter: FractionPainter(
                    numerator: angleInRadsStr,
                    denominator: i == anglesInRadStrings.length
                        ? ''
                        : anglesInRadStrings[i].$2,
                  ),
                ),
              ),
            ),
          );

          // DEGREES INSIDE THE CIRCLE
          final Offset degreeOffset = findPoint(
            showNormalUnitCircle
                ? 2 * pi - anglesInRadians[i]
                : anglesInRadians[i],
            centerOfCircle,
            circleRadius - 25,
          );

          late String angleInDegreesStr;
          if (i == 0) {
            angleInDegreesStr = showNormalUnitCircle
                ? zeroDegreeNormalUnitCircle
                : zeroDegreeFlutterUnitCircle;
          } else {
            angleInDegreesStr =
                i == anglesInDegrees.length ? '' : anglesInDegrees[i].$2;
          }
          painters.add(
            CustomPaint(
              size: size,
              painter: CompositePainter(
                positions: [degreeOffset],
                innerPainter: CenteredPainter(
                  innerPainter: FractionPainter(
                      numerator: angleInDegreesStr, denominator: null),
                ),
              ),
            ),
          );
        }

        if (controller != null) {
          // SINGULAR POINT ON CIRCLE
          final double angleInRadians = animation!.value;
          final Offset angleOffset = findPoint(
            showNormalUnitCircle ? 2 * pi - angleInRadians : angleInRadians,
            Offset(size.width / 2, size.height / 2),
            size.width / 2,
          );

          painters.add(CustomPaint(
            size: size,
            painter: PointPainter(
              angleOffset,
              Colors.black,
              opacity: 1,
            ),
          ));
        }

        return Stack(children: painters);
      },
    );
  }
}
