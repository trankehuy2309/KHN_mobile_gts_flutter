import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReportOverTime extends StatelessWidget {
  const ReportOverTime({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => {Get.back()},
        ),
        centerTitle: true,
        title: const Text('Báo cáo quá thời gian lái xe'),
      ),
      body: const SafeArea(
        child: Scrollbar(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Scrollbar(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Text('a'),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
