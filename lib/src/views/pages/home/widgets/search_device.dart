import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khn_tracking/src/core/controllers/device_controller_old.dart';
import 'package:khn_tracking/src/models/device_model.dart';

class SearchDevice extends StatelessWidget {
  const SearchDevice({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DeviceController>(
      init: Get.find<DeviceController>(),
      builder: (controller) => AnimatedOpacity(
        // If the widget is visible, animate to 0.0 (invisible).
        // If the widget is hidden, animate to 1.0 (fully visible).
        opacity: controller.isSearch ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 500),
        // The green box must be a child of the AnimatedOpacity widget.
        child: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus &&
                currentFocus.focusedChild != null) {
              FocusManager.instance.primaryFocus!.unfocus();
            }
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.white,
            padding: const EdgeInsets.only(top: 100),
            child: controller.searchDv == null
                ? const Center(child: Text('Không tìm thấy xe!'))
                : Column(
                    children: controller.searchDv!.map<ListTile>(
                      (DeviceLessModel dv) {
                        return ListTile(
                          leading: const Icon(Icons.car_rental),
                          title: Text(dv.vehicleNumber),
                          onTap: () {
                            controller.setCurentDv(dv.deviceID);
                          },
                        );
                      },
                    ).toList(),
                  ),
          ),
        ),
      ),
    );
  }
}
