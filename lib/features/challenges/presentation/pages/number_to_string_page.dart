import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NumberToStringPage extends StatefulWidget {
  const NumberToStringPage({
    super.key,
  });

  @override
  State<NumberToStringPage> createState() => _NumberToStringPageState();
}

class _NumberToStringPageState extends State<NumberToStringPage> {
  final TextEditingController controller = TextEditingController(text: '12345');
  String numString = '';
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    _convertNumberToString();
  }

  void _convertNumberToString() {
    if (controller.text.trim().isEmpty) {
      setState(() {
        numString = '';
      });
      return;
    }

    final int? intVal = int.tryParse(controller.text);
    if (intVal == null) {
      setState(() {
        numString =
            'invalid number keep it between -${-1 >>> 1} and ${-1 >>> 1}';
      });
      return;
    }

    List<int> reversedList = intVal
        .abs()
        .toString()
        .split('')
        .reversed
        .map((digit) => int.parse(digit))
        .toList();

    List<String> listNum = [];

    final int totalChunks = (((reversedList.length) / 3)).floor() + 1;
    for (int i = 0; i < max(totalChunks, 1); i++) {
      final int hundredsIndex = i * 3 + 2;
      final int tensIndex = i * 3 + 1;
      final int onesIndex = i * 3;

      final int? hundredsValue = hundredsIndex < reversedList.length
          ? reversedList[hundredsIndex]
          : null;
      final int? tensValue =
          tensIndex < reversedList.length ? reversedList[tensIndex] : null;
      final int? onesValue =
          onesIndex < reversedList.length ? reversedList[onesIndex] : null;

      if (onesValue == null) {
        continue;
      }

      if (i == 0 &&
          (hundredsValue == null && tensValue == null && onesValue == 0)) {
        listNum.add('zero');
        continue;
      }

      if ((hundredsValue ?? 0) + (tensValue ?? 0) + (onesValue) == 0) {
        continue;
      }

      listNum.add(powersOfTen(i));

      if (tensValue != 1) {
        listNum.add(singleNumToString(onesValue));
      }

      if (tensValue == 0 && onesValue != 0) {
        listNum.add(' and');
      } else if (tensValue == 1) {
        listNum.add(singleNumToString(10 + onesValue));
      } else if (tensValue != null) {
        listNum.add(singleNumToString((tensValue * 10)));
      }

      if (hundredsValue != null) {
        if (i == 0 && tensValue != 0) {
          listNum.add(' and');
        }

        if (hundredsValue != 0) {
          listNum.add(' hundred');
          listNum.add(singleNumToString(hundredsValue));
        }
      }
    }

    if (controller.text[0] == '-') {
      listNum.add('negative');
    } else {
      listNum.last = listNum.last.trim();
    }

    setState(() {
      numString = listNum.reversed.join();
    });
  }

  String powersOfTen(int outerIndex) {
    switch (outerIndex) {
      case 0:
        return '';
      case 1:
        return ' thousand,';
      case 2:
        return ' million,';
      case 3:
        return ' billion,';
      case 4:
        return ' trillion,';
      case 5:
        return ' quadrillion,';
      case 6:
        return ' quintillion,';
      case 7:
        return ' septillion,';
      default:
        return '+,';
    }
  }

  String singleNumToString(int number) {
    switch (number) {
      case 0:
        return '';
      case 1:
        return ' one';
      case 2:
        return ' two';
      case 3:
        return ' three';
      case 4:
        return ' four';
      case 5:
        return ' five';
      case 6:
        return ' six';
      case 7:
        return ' seven';
      case 8:
        return ' eight';
      case 9:
        return ' nine';
      case 10:
        return ' ten';
      case 11:
        return ' eleven';
      case 12:
        return ' twelve';
      case 13:
        return ' thirteen';
      case 14:
        return ' fourteen';
      case 15:
        return ' fifteen';
      case 16:
        return ' sixteen';
      case 17:
        return ' seventeen';
      case 18:
        return ' eighteen';
      case 19:
        return ' nineteen';
      case 20:
        return ' twenty';
      case 30:
        return ' thirty';
      case 40:
        return ' fourty';
      case 50:
        return ' fifty';
      case 60:
        return ' sixty';
      case 70:
        return ' seventy';
      case 80:
        return ' eighty';
      case 90:
        return ' ninety';
      default:
        return 'Number out of range';
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text(
          'Number to String',
        ),
      ),
      body: Center(
        child: Form(
          autovalidateMode: AutovalidateMode.always,
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  controller: controller,
                  keyboardType: const TextInputType.numberWithOptions(
                      signed: true, decimal: false),
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'^-?\d*')),
                  ],
                  onChanged: (value) {
                    _convertNumberToString();
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  numString,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
