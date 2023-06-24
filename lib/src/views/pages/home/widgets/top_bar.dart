import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khn_tracking/src/core/controllers/device_controller_old.dart';

class TopBarWidget extends StatelessWidget {
  const TopBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DeviceController>(
      init: Get.find<DeviceController>(),
      builder: (controller) => Positioned(
        left: 10,
        right: 0,
        top: 40,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    height: 50.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white),
                    child: TextFormField(
                      maxLength: 8,
                      textInputAction: TextInputAction.search,
                      decoration: InputDecoration(
                          counterText: "",
                          hintText: "Nhập biển số cần tìm?",
                          border: InputBorder.none,
                          contentPadding:
                              const EdgeInsets.only(left: 15.0, top: 15.0),
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.search),
                            onPressed: () {},
                            iconSize: 30.0,
                          )),
                      onChanged: (val) {
                        if (val.length > 3) {
                          controller.searchDvByNumber(val);
                        } else if (val.isEmpty) {
                          controller.closeSearch();
                        }
                      },
                      onTap: () {
                        controller.openSearch();
                        // controller.isSearch = !controller.isSearch;
                      },
                    ),
                  ),
                ),
                // IconButton(
                //   color: Theme.of(context).primaryColor,
                //   icon: const Icon(Icons.group),
                //   onPressed: () {
                //     Scaffold.of(context).openDrawer();
                //   },
                // ),
                IconButton(
                  color: Theme.of(context).primaryColor,
                  icon: const Icon(Icons.more_vert),
                  onPressed: () {
                    Scaffold.of(context).openEndDrawer();
                  },
                ),
              ],
            ),
            // Container(
            //   height: 100,
            //   color: Colors.white,
            //   margin: EdgeInsets.only(top: 2, right: 10),
            // ),
          ],
        ),
      ),
    );
  }
}
