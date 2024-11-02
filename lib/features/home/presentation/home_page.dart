import 'package:flutter/material.dart';
import 'package:lizs_sandbox/core/widgets/app_drawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Liz's Sandbox"),
      ),
      drawer: const AppDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('RULES', style: Theme.of(context).textTheme.headlineSmall),
            const Text("1. Don't throw sand."),
          ],
        ),
      ),
    );
  }
}
