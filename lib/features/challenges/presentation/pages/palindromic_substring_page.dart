import 'package:flutter/material.dart';

class PalindromeSubstringPage extends StatefulWidget {
  const PalindromeSubstringPage({
    super.key,
  });

  @override
  State<PalindromeSubstringPage> createState() =>
      _PalindromeSubstringPageState();
}

class _PalindromeSubstringPageState extends State<PalindromeSubstringPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController controller =
      TextEditingController(text: 'abcddcbz');

  String? subString = '';
  String? secondSubString = '';
  String? thirdSubstring = '';

  @override
  void initState() {
    super.initState();

    _findSubstring();
  }

  void _findSubstring() {
    subString = palindromeFirstMethod(
        controller.text); // Time complexity: O(n^3), Space complexity: O(n^2)
    secondSubString = palindromeSecondMethod(
        controller.text); // Time complexity: O(n^2), Space complexity: O(n^2)
    thirdSubstring = palindromeThirdMethod(
        controller.text); // Time complexity: O(n^2), Space complexity: O(n)
    setState(() {});
  }

  // Recursive function (mine)
  String? palindromeFirstMethod(String fullStr) {
    String? palindromeStr;

    final List<String> fullStrSplit = fullStr.split('');
    for (int i = 0; i < fullStrSplit.length; i++) {
      for (int j = fullStrSplit.length - 1; j > i; j--) {
        if (fullStrSplit[i] == fullStrSplit[j]) {
          final String? palin =
              palindromeRecursive(fullStr.substring(i, j + 1).split(''));
          if (palin != null) {
            if (palindromeStr == null || palin.length > palindromeStr.length) {
              palindromeStr = palin;
            }
          }
        }
      }
    }

    return palindromeStr;
  }

  String? palindromeRecursive(List<String> str) {
    // base case - 1 character
    if (str.length == 1) {
      return str.join();
    }

    // base case - 2 of the same character
    if (str.length == 2 && str.first == str.last) {
      return str.join();
    }

    // case - the outer letters are not the same
    if (str.first != str.last) {
      return null;
    }

    final List<String> copiedStrList = str.toList();
    copiedStrList.removeAt(0);
    copiedStrList.removeLast();

    final String? palin = palindromeRecursive(copiedStrList);

    if (palin == null) {
      return null;
    }

    return (str.first + palin + str.last);
  }

  // Nested for-loops (mine)
  String? palindromeSecondMethod(String fullStr) {
    String? palindromeStr;

    final List<String> fullStrSplit = fullStr.split('');
    for (int i = 0; i < fullStrSplit.length; i++) {
      for (int j = fullStrSplit.length - 1; j > i; j--) {
        if (fullStrSplit[i] == fullStrSplit[j]) {
          final List<String> strForward = fullStr.substring(i, j + 1).split('');
          final List<String> strBackward = strForward.reversed.toList();

          if (strForward.join() == strBackward.join()) {
            if (palindromeStr == null || palindromeStr.length < j + 1 - i) {
              palindromeStr = fullStr.substring(i, j + 1);
            }
          }
        }
      }
    }

    return palindromeStr;
  }

  // Expand around center (ChatGPT rec)
  String palindromeThirdMethod(String s) {
    if (s.isEmpty) return '';
    int start = 0;
    int end = 0;
    for (int i = 0; i < s.length; i++) {
      int len1 = expandAroundCenter(s, i, i); // Odd length palindromes
      int len2 = expandAroundCenter(s, i, i + 1); // Even length palindromes
      int len = len1 > len2 ? len1 : len2;
      if (len > end - start) {
        start = i - (len - 1) ~/ 2;
        end = i + len ~/ 2;
      }
    }
    return s.substring(start, end + 1);
  }

  int expandAroundCenter(String s, int left, int right) {
    while (left >= 0 && right < s.length && s[left] == s[right]) {
      left--;
      right++;
    }
    return right - left - 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Palindromic Substring'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Form(
              autovalidateMode: AutovalidateMode.always,
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  controller: controller,
                  onChanged: (value) {
                    _findSubstring();
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                children: [
                  Text(
                    'Recursion',
                    style: Theme.of(context).textTheme.titleSmall!,
                  ),
                  Text(
                    subString ?? '',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                children: [
                  Text(
                    'Nested For-Loops',
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(color: Colors.green),
                  ),
                  Text(
                    secondSubString ?? '',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: Colors.green),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                children: [
                  Text(
                    'Expand Around Center',
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(color: Colors.blue),
                  ),
                  Text(
                    thirdSubstring ?? '',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: Colors.blue),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
