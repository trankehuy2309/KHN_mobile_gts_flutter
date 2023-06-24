import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:khn_tracking/src/core/repositories/home_api.dart';
import 'package:khn_tracking/src/models/device_model.dart';

class DeviceController extends GetxController {
  int mode = 0;
  Timer? _intervalCurrentData, _interval;
  bool _loading = false;
  bool get loading => _loading;
  //late List<DeviceGroupModel> listGroup;
  late List<DeviceStageModel> _lDeviceStage;
  List<DeviceStageModel> get lDeviceStage => _lDeviceStage;
  DeviceStageModel? _deviceStage;
  DeviceStageModel? get deviceStage => _deviceStage;
  DeviceStageModel? _dvReportCurrent;
  DeviceStageModel? get dvReportCurrent => _dvReportCurrent;
  late int _currentGroupID;
  List<DeviceExpModel> _deviceExp = [];
  List<DeviceExpModel> get deviceExp => _deviceExp;
  int currentGroupIndex = 0;
  int timeIntervalCurrent = 20;
  int timeInterval = 60;
  bool _isSearch = false;
  bool get isSearch => _isSearch;
  final List<String> _searchTerms = [];
  List<String> get searchTerms => _searchTerms;

  @override
  void onInit() {
    super.onInit();
    getListDeviceExp();
    if (mode != 1) {
      //listGroup = [];
      DeviceGroupModel grDV =
          DeviceGroupModel(vehicleGroupID: 0, vehicleGroup: 'All', countdv: 10);
      //listGroup.add(grDV);
    }
  }

  @override
  void onClose() {
    debugPrint('onClose');
    intervalDispose();
    super.onClose();
  }

  Future<void> getGroupDevice() async {
    _loading = true;
    intervalDispose();
    try {
      // if (mode == 1) {
      // await DeviceAPI.getDeviceGroup().then((res) async {
      //  listGroup = List<DeviceGroupModel>.from(
      // res.map((e) => DeviceGroupModel.fromJson(e)).toList());
      // _currentGroupID = listGroup[currentGroupIndex].vehicleGroupID;
      //  await DeviceAPI.getListDevieStage(_currentGroupID).then((res) {
      // var listDState = List<DeviceStageModel>.from(
      // res.map((e) => DeviceStageModel.fromJson(e)).toList());
      // listGroup[currentGroupIndex].listDvStage = listDState;
      //_lDeviceStage = listDState;
      //  });
      //  });
      //} else {
      await DeviceAPI.getAllDevice().then((res) {
        if (res != null) {
          var listDState = List<DeviceStageModel>.from(
              res.map((e) => DeviceStageModel.fromJson(e)).toList());
          //listGroup[0].listDvStage = listDState;
          _lDeviceStage = listDState;
        }
      });
      // }

      intervalCurrentData();
      // interval();
    } catch (e) {
      debugPrint(e.toString());
    }
    _loading = false;
    update();
  }

  Future<void> getListDeviceExp() async {
    _loading = true;
    update();

    Future.delayed(const Duration(seconds: 5), () {
      DeviceAPI.getListDeviceExp().then((res) {
        _deviceExp = List<DeviceExpModel>.from(
            res.map((e) => DeviceExpModel.fromJson(e)).toList());
      });
    });
  }

  Future<void> getListDVStage() async {
    if (mode == 1) {
      // _loading = true;
      await DeviceAPI.getListDevieStage(_currentGroupID).then((res) async {
        var listDState = List<DeviceStageModel>.from(
            res.map((e) => DeviceStageModel.fromJson(e)).toList());

        // listGroup[currentGroupIndex].listDvStage = listDState;
      });
      // _loading = false;
    } else {
      // _loading = true;
      await DeviceAPI.getAllDevice().then((res) async {
        var listDState = List<DeviceStageModel>.from(
            res.map((e) => DeviceStageModel.fromJson(e)).toList());

        //listGroup[0].listDvStage = listDState;
      });
      // _loading = false;
    }

    update();
  }

  void setDvInfo(deviceId) async {
    _loading = true;
    await DeviceAPI.getDevieStageById(_deviceStage!.deviceID, true)
        .then((res) async {
      _deviceStage = DeviceStageModel.fromJson(res);
    });
    _loading = false;
    update();
  }

  Future<DeviceStageModel> getDeviceInfo(deviceId) async {
    _loading = true;
    DeviceStageModel? result = _deviceStage;
    await DeviceAPI.getDevieStageById(_deviceStage!.deviceID, true)
        .then((res) async {
      _deviceStage = DeviceStageModel.fromJson(res);
    });
    _loading = false;
    update();
    return result!;
  }

  void setDeviceReport(int deviceId) {
    _dvReportCurrent =
        _lDeviceStage.where((element) => element.deviceID == deviceId).first;
    update();
  }

  //void changeCurrentGroupByIndex(value) {
  // currentGroupIndex = value;
  // _currentGroupID = listGroup[currentGroupIndex].vehicleGroupID;
  // update();
  //}

  //Future<void> changeCurrentGroupById(value) async {
  // _loading = true;
  //update();
  // _currentGroupID = value;
  // currentGroupIndex =
  // listGroup.indexWhere((element) => element.vehicleGroupID == value);
  // try {
  //  await DeviceAPI.getListDevieStage(_currentGroupID).then((res) {
  //  var listDState = List<DeviceStageModel>.from(
  // res.map((e) => DeviceStageModel.fromJson(e)).toList());
  //  listGroup[currentGroupIndex].listDvStage = listDState;
  //  _lDeviceStage = listDState;
  // });
  // } catch (e) {
  //   debugPrint(e.toString());
  // }
  // _loading = false;
  // update();
  // }

  void setDeviceState(value) {
    _deviceStage = value;
    update();
  }

  // ------------- INTERVAL -----------
  void intervalCurrentData() {
    _intervalCurrentData =
        Timer.periodic(Duration(seconds: timeIntervalCurrent), (timer) async {
      //  if (mode == 1) {
      //  await DeviceAPI.getListDevieStage(_currentGroupID).then((res) {
      // var listDState = List<DeviceStageModel>.from(
      // res.map((e) => DeviceStageModel.fromJson(e)).toList());

      //listGroup[currentGroupIndex].listDvStage = listDState;
      // _lDeviceStage = listDState;
      // update();
      //  });
      // } else {
      try {
        await DeviceAPI.getAllDevice().then((res) {
          if (res != null) {
            var listDState = List<DeviceStageModel>.from(
                res.map((e) => DeviceStageModel.fromJson(e)).toList());

            //listGroup[0].listDvStage = listDState;
            _lDeviceStage = listDState;
            update();
          }
        });
      } catch (e) {
        debugPrint(e.toString());
      }
      //  }
    });
  }

  // void interval() {
  //  if (listGroup.length > 1) {
  //  _interval =
  // Timer.periodic(Duration(seconds: timeInterval), (timer) async {
  //  for (int i = 0; i < listGroup.length; i++) {
  //  if (i != currentGroupIndex) {
  //  try {
  // await DeviceAPI.getListDevieStage(listGroup[i].vehicleGroupID)
  //  .then((res) async {
  // if (res != null) {
  // var listDState = List<DeviceStageModel>.from(
  //  res.map((e) => DeviceStageModel.fromJson(e)).toList());
  //  listGroup[i].listDvStage = listDState;
  //   update();
  //  }
  //  });
  //  } catch (e) {
  //     debugPrint(e.toString());
  //  }
  //  }
  //  }
  // });
  // }
  //}

  void intervalDispose() {
    if (_intervalCurrentData != null) {
      _intervalCurrentData!.cancel();
    }
    // if (_interval != null) {
    //_interval!.cancel();
    // }
  }

  // SEARCH
  void openSearch() {
    _isSearch = true;
    update();
  }

  void closeSearch() {
    _isSearch = false;
    update();
  }
}
