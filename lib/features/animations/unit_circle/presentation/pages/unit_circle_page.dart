import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lizs_sandbox/features/animations/unit_circle/presentation/widgets/unit_circle.dart';

class UnitCirclePage extends StatefulWidget {
  const UnitCirclePage({
    super.key,
  });

  @override
  State<UnitCirclePage> createState() => _UnitCirclePageState();
}

class _UnitCirclePageState extends State<UnitCirclePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  Duration _duration = const Duration(seconds: 8);
  List<TweenSequenceItem<double>> tweenSequenceItems = [];

  List<double> rotationInRads = [pi / 6, pi / 12, pi / 12, pi / 6];

  @override
  void initState() {
    super.initState();

    for (double angle = 0; angle <= 2 * pi; angle += pi / 2) {
      double previousAngle = angle;
      for (final rot in rotationInRads) {
        // rotate to next angle
        tweenSequenceItems.add(
          TweenSequenceItem<double>(
            tween: Tween<double>(begin: previousAngle, end: previousAngle + rot)
                .chain(CurveTween(curve: Curves.easeInOut)),
            weight: 1.0,
          ),
        );

        // pause
        tweenSequenceItems.add(
          TweenSequenceItem<double>(
            tween: ConstantTween<double>(previousAngle + rot)
                .chain(CurveTween(curve: Curves.easeInOut)),
            weight: 1.0,
          ),
        );
        previousAngle = previousAngle + rot;
      }
    }

    _controller = AnimationController(
      vsync: this,
      duration: _duration,
    );
    _animation = TweenSequence<double>(tweenSequenceItems).animate(_controller);

    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _updateValues(Duration newDuration, Curve newCurve) {
    setState(() {
      _duration = newDuration;
      _controller.reset();

      _controller.duration = _duration;
      _controller.repeat();
    });
  }

  @override
  Widget build(BuildContext context) {
    _updateValues(
        const Duration(
          seconds: 20,
        ),
        Curves.easeInOut);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Unit Circle Angles'),
      ),
      body: Center(
          child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            UnitCircle(
              size: const Size(200, 200),
              controller: _controller,
              animation: _animation,
              showNormalUnitCircle: true,
            ),
            const SizedBox(height: 100),
            UnitCircle(
              size: const Size(200, 200),
              controller: _controller,
              animation: _animation,
            ),
            const SizedBox(height: 20),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              Image.asset(
                "assets/images/CNX_Precalc_Figure_05_02_0032.jpg",
                width: MediaQuery.of(context).size.width / 2,
              ),
              Image.asset(
                "assets/images/axes.jpg",
                width: MediaQuery.of(context).size.width / 2,
              ),
            ])
          ],
        ),
      )),
    );
  }
}
