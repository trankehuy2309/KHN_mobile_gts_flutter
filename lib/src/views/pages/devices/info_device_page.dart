import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khn_tracking/src/helper/ulti.dart';
import 'package:khn_tracking/src/models/device_model.dart';
import 'package:khn_tracking/src/views/widgets/_widgets.dart';

class DeviceInfoPage extends StatelessWidget {
  const DeviceInfoPage({Key? key, required this.device}) : super(key: key);
  final DeviceStageModel device;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => {Get.back()},
          ),
          title: Text(device.vehicleNumber),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.drive_file_rename_outline),
              onPressed: () {},
              // onPressed: () {
              //   Get.to(() => DeviceEditInfo());
              // },
            ),
          ]),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
        child: Column(
          children: [
            const SizedBox(
              height: 8,
            ),
            Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTileItemWidget(
                      Icons.album, 'Tên thiết bị', device.vehicleNumber),
                  ListTileItemWidget(
                      Icons.album, 'Loại thiết bị', device.version),
                  ListTileItemWidget(Icons.album, 'IMEI', device.imei),
                  //ListTileItemWidget(
                  // Icons.album, 'SIM1', device.deviceInfo!.simNumberInf),
                ],
              ),
            ),
            Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const ListTileItemWidget(Icons.album, 'Tình trạng', '#'),
                  const ListTileItemWidget(Icons.album, 'AC', 'ACC'),
                  ListTileItemWidget(Icons.album, 'Thời gian cập nhật1',
                      changeDateTime(device.dateSave)),
                  ListTileItemWidget(
                      Icons.album, 'Tốc độ', '${device.speed.toString()} km/h'),
                  ListTileItemWidget(
                      Icons.album, 'Vĩ độ', device.latitude.toString()),
                  ListTileItemWidget(
                      Icons.album, 'Kinh độ', device.longitude.toString()),
                  const ListTileItemWidget(Icons.album, 'Địa chỉ', '#'),
                ],
              ),
            ),
            Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTileItemWidget(Icons.album, 'Hết hạn',
                      changeDateTime(device.dateExpired)),
                  ListTileItemWidget(
                      Icons.album, 'Biển số xe', device.vehicleNumber),
                  ListTileItemWidget(
                      Icons.album, 'Tên lái xe', device.theDriver),
                  const ListTileItemWidget(Icons.album, 'Số liên lạc', '#'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
