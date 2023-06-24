import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:khn_tracking/src/core/controllers/_controller.dart';
import 'package:khn_tracking/src/core/controllers/demo_controller.dart';
//import 'package:khn_tracking/src/core/controllers/device_controller.dart';
import 'package:khn_tracking/src/helper/ulti.dart';
import 'package:khn_tracking/src/models/device_model.dart';
import 'package:khn_tracking/src/views/pages/home/gmap/map_focus_demo.dart';

import '../info_device_page.dart';

class ListDeviceWidget extends StatefulWidget {
  ListDeviceWidget({Key? key, required this.index, required this.devices})
      : super(key: key);
  final int index;
  List<DeviceStageModel> devices;

  @override
  _ListDeviceWidgetState createState() => _ListDeviceWidgetState();
}

class _ListDeviceWidgetState extends State<ListDeviceWidget> {
  @override
  Widget build(
    BuildContext context,
  ) {
    return GetBuilder<DeviceController>(
      builder: (controller) => RefreshIndicator(
        onRefresh: () {
          return controller.getListDVStage();
        },
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  'total'.tr + ': ' + widget.devices.length.toString(),
                  style: const TextStyle(
                    color: Color(0XFF757575),
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(8),
                children: widget.devices
                    .map((device) => BuildDeviceItem(device: device))
                    .toList(),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _pullRefresh() async {
    debugPrint('reload');
    // why use freshWords var? https://stackoverflow.com/a/52992836/2301224
  }
}

class BuildDeviceItem extends StatelessWidget {
  final DeviceStageModel device;
  const BuildDeviceItem({Key? key, required this.device}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 8, 8, 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            InkWell(
              onTap: () async {
                Get.lazyPut(() => ReportController());
                Get.lazyPut(() => DemoController());
                Get.find<DeviceController>().setDeviceState(device);
                if (device.state != 5) {
                  if (device.latitude > 0) {
                    Get.to(() => GMapFocus(device: device));
                  } else {
                    return _showMyDialog_MatGPS(context);
                  }
                }
              },
              child: ListTile(
                  leading:
                      Image.asset('assets/themes/icons/car.png', height: 40),
                  // leading: CircleAvatar(
                  //   backgroundColor: Colors.transparent,
                  //   radius: 30,
                  //   child: Icon(Icons.local_taxi,
                  //       size: 40,
                  //       color: statusColor(device.state)),
                  // ),
                  title: Text(
                    '◉ ${device.vehicleNumber.toString()}',
                    style: TextStyle(
                        color: statusColor(device.state),
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  ),
                  subtitle: device.state != 5
                      ? Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(DateFormat('HH:mm:ss dd-MM-yyyy')
                              .format(device.dateSave)),
                        )
                      : const Text('Hết hạn dịch vụ'),
                  trailing: Column(children: <Widget>[
                    Container(
                      padding: const EdgeInsets.fromLTRB(10, 4, 10, 4),
                      decoration: BoxDecoration(
                        color: statusColor(device.state),
                      ),
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                              child: Text(
                            device.stateStr == null
                                ? "Error"
                                : device.stateStr!,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12),
                          )),
                          // ),
                          // SizedBox(
                          // child: Text(
                          // statusString(device.state, device.dateSave)
                          //  .tr
                          //    .toUpperCase(),
                          // style: const TextStyle(
                          // color: Colors.white,
                          //  fontWeight: FontWeight.bold,
                          // fontSize: 16),
                          //   ),
                          // ),
                          // SizedBox(
                          // child: Text(
                          // device.state == 3
                          //  ? '${device.speed.toString()} Km/h'
                          // : (device.state == 5
                          //  ? ""
                          // : timeDevice(device.dateSave,
                          //   device.dateSaveLast)),
                          // style: const TextStyle(
                          // color: Colors.white,
                          //  fontWeight: FontWeight.bold,
                          // fontSize: 12),
                          //  ),
                          //  ),
                        ],
                      ),
                    ),
                  ])),
            ),
            Text(device.addr!,
                textAlign: TextAlign.left,
                style: const TextStyle(color: Color(0XFF757575))),
            // ListViewCategories(device.deviceID),
          ],
        ),
      ),
    );
  }

  Future<void> _showMyDialog_MatGPS(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Thông báo'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Hiện tại thiết bị này không khả dụng.'),
                Text('Quý khách có thể liên hệ nhà cung cấp để được hỗ trợ.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Thoát'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Tiếp tục'),
              onPressed: () {
                Navigator.of(context).pop();
                Get.to(() => GMapFocus(device: device));
              },
            ),
          ],
        );
      },
    );
  }
}

class ListViewCategories extends StatelessWidget {
  const ListViewCategories(this.deviceId, {Key? key}) : super(key: key);
  final int deviceId;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DeviceController>(
      builder: (controller) => Stack(
        children: <Widget>[
          Padding(
            // padding: const EdgeInsets.only(right: 30),
            padding: const EdgeInsets.only(right: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                TextButton.icon(
                  label: Text(
                    'Thông tin',
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  icon: Image.asset('assets/themes/icons/ingredients-list.png',
                      height: 20),
                  onPressed: () async {
                    DeviceStageModel deviceInfo =
                        await controller.getDeviceInfo(deviceId);
                    Get.to(() => DeviceInfoPage(device: deviceInfo));
                  },
                ),
                TextButton.icon(
                  label: Text(
                    'Camera',
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  icon: Image.asset('assets/themes/icons/camcorder.png',
                      height: 20),
                  onPressed: () async {
                    DeviceStageModel deviceInfo =
                        await controller.getDeviceInfo(deviceId);
                    // Get.to(() => HlsTracksPage());
                  },
                ),
                TextButton.icon(
                  label: Text(
                    'Xem lại',
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  icon: Image.asset('assets/themes/icons/point-objects.png',
                      height: 20),
                  onPressed: () {
                    controller.setDeviceReport(deviceId);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ListIconDevice extends StatelessWidget {
  final DeviceStageModel device;
  const ListIconDevice({
    Key? key,
    required this.device,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DeviceIcon(
                  imageUrl: 'assets/themes/icons/key-not-in-vehicle--v2.png',
                  textValue: device.statusKey ? 'Mở' : 'Tắt'), // Khóa
              DeviceIcon(
                  imageUrl: 'assets/themes/icons/rear-door.png',
                  textValue: device.statusDoor ? 'Đóng' : 'Mở'), // Cửa
              DeviceIcon(
                  imageUrl: 'assets/themes/icons/gps-receiving.png',
                  textValue: device.in_Out == '0' ? 'On' : 'Off'), // GPS
              DeviceIcon(
                  imageUrl: 'assets/themes/icons/fan-speed.png',
                  textValue: device.cooler! ? 'Mở' : 'Đóng'), // Máy lạnh
            ],
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DeviceIcon(
                  imageUrl: 'assets/themes/icons/gas-station.png',
                  textValue: device.oilvalue.toString()), // Khóa
              const DeviceIcon(
                  imageUrl: 'assets/themes/icons/wifi.png',
                  textValue: 'Tốt'), // Cửa
              // Máy lạnh
            ],
          ),
        ],
      ),
    );
  }
}

class DeviceIcon extends StatelessWidget {
  final String imageUrl;
  final String textValue;
  const DeviceIcon({Key? key, required this.imageUrl, required this.textValue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 4.0),
          child: Image.asset(
            imageUrl,
            height: 22,
          ),
        ),
        Text(
          textValue,
          style: const TextStyle(
            color: Color(0XFF757575),
          ),
        )
      ],
    );
  }
}
