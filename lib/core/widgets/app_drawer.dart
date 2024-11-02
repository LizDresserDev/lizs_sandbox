import 'package:flutter/material.dart';
import 'package:lizs_sandbox/features/challenges/presentation/pages/number_to_string_page.dart';
import 'package:lizs_sandbox/features/challenges/presentation/pages/palindromic_substring_page.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const SizedBox(
            height: 100,
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.teal,
              ),
              padding: EdgeInsets.only(left: 20),
              child: Text(
                'Navigation Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('CHALLENGES',
                style: Theme.of(context).textTheme.titleSmall),
          ),
          ListTile(
            leading: const Icon(Icons.abc),
            title: const Text('Palindromic Substring'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const PalindromeSubstringPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.numbers),
            title: const Text('Number to String'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const NumberToStringPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
