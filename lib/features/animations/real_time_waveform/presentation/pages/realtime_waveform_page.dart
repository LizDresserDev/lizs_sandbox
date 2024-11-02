import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lizs_sandbox/features/animations/real_time_waveform/data/ecg_simulator.dart';

class RealTimeWaveformPage extends StatefulWidget {
  const RealTimeWaveformPage({
    super.key,
  });

  @override
  State<RealTimeWaveformPage> createState() => _RealTimeWaveformPageState();
}

class _RealTimeWaveformPageState extends State<RealTimeWaveformPage> {
  final int pixelsPerMs = 2;
  int msOverPage = 0;
  final int durationInMs = 100;
  List<double?> samples = [];
  final Random random = Random();
  Timer? timer;
  int replacementIndex = 0;

  ECGSimulator ecgSimulator = ECGSimulator();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      msOverPage = (MediaQuery.of(context).size.width / pixelsPerMs).floor();
      samples = List.generate(msOverPage, (_) => null);
    });

    ecgSimulator.ecgStream.listen((data) {
      setState(() {
        samples[replacementIndex] = data;
        const int nextXMany = 5;

        if (replacementIndex + nextXMany < msOverPage - 1) {
          samples[replacementIndex + nextXMany] = null;
        }
        replacementIndex =
            replacementIndex + 1 == msOverPage ? 0 : replacementIndex + 1;
      });
    });
  }

  @override
  void dispose() {
    ecgSimulator.stop();
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Real-Time Waveform'),
      ),
      body: Center(
        child: CustomPaint(
          painter: WaveformPainter(samples, msOverPage),
          child: const SizedBox(
            height: 200,
            width: double.infinity,
          ),
        ),
      ),
    );
  }
}

class WaveformPainter extends CustomPainter {
  final List<double?> samples;
  final int count;
  WaveformPainter(this.samples, this.count);
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;
    final paintCircle = Paint()
      ..color = Colors.red.withOpacity(.2)
      ..strokeWidth = 2.0
      ..style = PaintingStyle.fill;

    const double radius = 2;
    final Path firstPath = Path();
    Path? secondPath;

    if (samples.isNotEmpty) {
      final height = size.height / 2;
      final width = size.width;
      final sampleInterval = samples.length >= width
          ? samples.length / width
          : width / samples.length;

      for (int index = 0; index < count; index++) {
        if (index == 0) {
          if (samples.last != null) {
            final double lastY =
                height - (samples.last! * height).clamp(-height, height);
            firstPath.moveTo(0, lastY);
            canvas.drawCircle(Offset(0, lastY), radius, paintCircle);
          }
        }

        if (samples[index] != null) {
          final double x = sampleInterval * (index + 1);
          final double y =
              height - (samples[index]! * height).clamp(-height, height);

          if (index != 0 &&
              samples[index] != null &&
              samples[index - 1] == null) {
            secondPath = Path();

            secondPath.moveTo(x, y);
            canvas.drawCircle(Offset(x, y), radius, paintCircle);
          } else {
            if (secondPath != null) {
              secondPath.lineTo(x, y);
            } else {
              firstPath.lineTo(x, y);
            }
          }
        }
      }

      canvas.drawPath(firstPath, paint);
      if (secondPath != null) {
        canvas.drawPath(secondPath, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
