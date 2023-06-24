import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khn_tracking/src/core/controllers/device_controller.dart';
import 'package:khn_tracking/src/helper/ulti.dart';

class AlterPage extends StatelessWidget {
  const AlterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('alter'.tr),
          centerTitle: true),
      body: GetBuilder<DeviceController>(
        init: Get.find<DeviceController>(),
        builder: (controller) => controller.loading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                child: controller.deviceExp.isEmpty
                    ? Center(
                        child: Text('no-alter'.tr),
                      )
                    : ListView(
                        children: controller.deviceExp.map((e) {
                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(12, 8, 8, 12),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                ListTile(
                                  leading: Image.asset(
                                      'assets/themes/icons/car.png',
                                      height: 40),
                                  title: Text(
                                    '◉ ${e.vehicleNumber.toString()}',
                                    style: TextStyle(
                                        color: e.dateExpired
                                                .isBefore(DateTime.now())
                                            ? statusColor(5)
                                            : statusColor(3),
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  subtitle: e.dateExpired
                                          .isBefore(DateTime.now())
                                      ? const Text('Hết hạn dịch vụ')
                                      : Text(
                                          'Còn ${e.dateExpired.difference(DateTime.now()).inDays + 1} ngày'),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList()),
              ),
      ),
    );
  }
}
