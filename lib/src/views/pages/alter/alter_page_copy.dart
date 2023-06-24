import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AlterPage extends StatelessWidget {
  AlterPage({Key? key}) : super(key: key);

  final ac = Get.find<AlterController>();

  @override
  Widget build(BuildContext context) {
    ac.initIsolate();

    return const Material(
      child: Center(
        child: Center(
          child: Text(
            "Wow , it saved my 10 seconds : check console for response",
            style: TextStyle(
              fontSize: 50,
            ),
          ),
        ),
      ),
    );
  }
}

class AlterController extends GetxController {
  static int num = 0;
  initIsolate() {}

  static Future<int> runIsolate(int number) async {
    debugPrint(num.toString());
    return number++;
  }
}
