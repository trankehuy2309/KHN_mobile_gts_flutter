import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khn_tracking/src/core/controllers/device_controller_old.dart';

class PanelMapWidget extends StatelessWidget {
  const PanelMapWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DeviceController>(
      init: Get.find<DeviceController>(),
      builder: (controller) => AnimatedPositioned(
        bottom: controller.panelPosition,
        right: 0,
        left: 0,
        duration: const Duration(milliseconds: 200),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            margin: const EdgeInsets.all(20),
            height: 100,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(50)),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      blurRadius: 20,
                      offset: Offset.zero,
                      color: Colors.grey.withOpacity(0.5))
                ]),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: Container(
                      margin: const EdgeInsets.only(left: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.fromLTRB(1, 0, 6, 0),
                                child: Icon(
                                  Icons.circle,
                                  // color: controller.dvStageCurent.labelColor,
                                  color: Theme.of(context).primaryColor,
                                  size: 15,
                                ),
                              ),
                              Text(
                                controller.dvStageCurent!.vehicleNumber,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5, // default\minimum height
                          ),
                          Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                                child: Icon(
                                  Icons.watch_later,
                                  color: Colors.grey.shade700,
                                  size: 15,
                                ),
                              ),
                              Text(
                                controller.dvStageCurent!.dateSave.toString(),
                                style: TextStyle(
                                    fontSize: 14, color: Colors.grey.shade700),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 3, // default\minimum height
                          ),
                          Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                                child: Icon(
                                  Icons.location_on,
                                  color: Colors.grey.shade700,
                                  size: 15,
                                ),
                              ),
                              Text(
                                '${controller.dvStageCurent!.latitude.toString()}, ${controller.dvStageCurent!.longitude.toString()}',
                                style: TextStyle(
                                    fontSize: 14, color: Colors.grey.shade700),
                              ),
                            ],
                          ),
                          // const SizedBox(
                          //   height: 3, // default\minimum height
                          // ),
                          // Container(
                          //   width: MediaQuery.of(context).size.width * 0.6,
                          //   child: Text(
                          //     controller.dvStageCurent!.address,
                          //     style: TextStyle(
                          //         fontSize: 14, color: Colors.grey.shade700),
                          //     maxLines: 2,
                          //     overflow: TextOverflow.ellipsis,
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/icons/car_blue.png',
                          width: 50, height: 50),
                      controller.dvStageCurent!.state == 3
                          ? Text(
                              '${controller.dvStageCurent!.speed.toString()} km/h',
                              style: TextStyle(
                                  fontSize: 14, color: Colors.grey.shade700),
                            )
                          : const Text('')
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
