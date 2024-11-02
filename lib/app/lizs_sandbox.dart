import 'package:flutter/material.dart';
import 'package:lizs_sandbox/features/home/presentation/home_page.dart';

class LizsSandbox extends StatelessWidget {
  const LizsSandbox({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
