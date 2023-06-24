import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:khn_tracking/src/core/repositories/home_api.dart';
import 'package:khn_tracking/src/models/device_model.dart';

class DeviceInfoController extends GetxController {
  bool _loading = false;
  bool get loading => _loading;

  DeviceStageModel? _dvInfo;
  DeviceStageModel get dvInfo => _dvInfo!;

  @override
  void onClose() {
    debugPrint('onClose');
  }

  void getDvInfo(int deviceId) async {
    _loading = true;
    await DeviceAPI.getDevieStageById(deviceId, true).then((res) async {
      debugPrint(res.toString());
      _dvInfo = DeviceStageModel.fromJson(res);
      //_dvInfo!.deviceInfo = DeviceInfoModel.fromJson(res);
    });
    _loading = false;
    update();
  }
}
