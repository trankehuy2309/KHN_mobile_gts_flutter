import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khn_tracking/src/core/repositories/report_api.dart';
import 'package:khn_tracking/src/models/device_model.dart';
import 'package:khn_tracking/src/models/report_distance.dart';

import '../../models/report_model.dart';
import '_controller.dart';

class DashboardReportController extends GetxController {
  late DeviceStageModel? device;
  bool _loading = false;
  bool get loading => _loading;
  DateTime _start = DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day, 0, 0);
  DateTime _end = DateTime.now();
  DateTime get start => _start;
  DateTime get end => _end;

  ReportModel? _reportModel;
  ReportModel? get reportModel => _reportModel;

  ReportOilModel? _reportOil;
  ReportOilModel? get reportOil => _reportOil;

  List<ReportSpeedModel> _reportSpeed = [];
  List<ReportSpeedModel> get reportSpeed => _reportSpeed;

  List<ReportPauseStopModel> _reportPauseStop = [];
  List<ReportPauseStopModel> get reportPauseStop => _reportPauseStop;

  List<ReportRunningModel> _reportRunning = [];
  List<ReportRunningModel> get reportRunning => _reportRunning;

  List<ReportAllByCarModel> _reportAllByCar = [];
  List<ReportAllByCarModel> get reportAllByCar => _reportAllByCar;

  List<ReportMaxSpeedModel> _reportMaxSpeed = [];
  List<ReportMaxSpeedModel> get reportMaxSpeed => _reportMaxSpeed;

  final List<DeviceStageModel> _listDatas = [];
  List<DeviceStageModel> get listDatas => _listDatas;

  List<ReportImageModel> _listDataImg = [];
  List<ReportImageModel> get listDataImg => _listDataImg;

  List<Map<String, dynamic>> rpH = [];

  @override
  void onInit() {
    super.onInit();
    device = Get.find<DeviceController>().deviceStage;
  }

  void setDeviceState(value) {
    device = value;
    update();
  }

  Future<void> getReportType(int type) async {
    _loading = true;
    update();
    switch (type) {
      case 1:
        {
          try {
            _reportModel = null;
            await ReportAPI.getDistanceDevice(device!.deviceID, _start, _end)
                .then((res) {
              _reportModel = ReportModel.fromJson(res);
            });
          } catch (e) {
            debugPrint(e.toString());
          }
          break;
        }
      case 2:
        {
          try {
            _reportModel = null;
            await ReportAPI.getHistoryDevice(device!.deviceID, _start, _end)
                .then((res) {
              _reportModel = ReportModel.fromJson(res);
            });
          } catch (e) {
            debugPrint(e.toString());
          }
          break;
        }
      case 3:
        {
          try {
            await ReportAPI.getSpeedDevice(device!.deviceID, _start, _end)
                .then((res) {
              _reportSpeed = List<ReportSpeedModel>.from(
                  res.map((e) => ReportSpeedModel.fromJson(e)).toList());
            });
          } catch (e) {
            debugPrint(e.toString());
          }
          break;
        }
      case 4:
        {
          try {
            await ReportAPI.getPauseStop(device!.deviceID, _start, _end)
                .then((res) {
              _reportPauseStop = List<ReportPauseStopModel>.from(
                  res.map((e) => ReportPauseStopModel.fromJson(e)).toList());
            });
          } catch (e) {
            debugPrint(e.toString());
          }
          break;
        }
      case 5:
        {
          try {
            await ReportAPI.getRunning(device!.deviceID, _start, _end)
                .then((res) {
              _reportRunning = List<ReportRunningModel>.from(
                  res.map((e) => ReportRunningModel.fromJson(e)).toList());
            });
          } catch (e) {
            debugPrint(e.toString());
          }
          break;
        }
      case 6:
        {
          try {
            await ReportAPI.getOil(device!.deviceID, _start, _end).then((res) {
              debugPrint(res.toString());

              _reportOil = ReportOilModel.fromJson(res);
            });
          } catch (e) {
            debugPrint(e.toString());
          }
          break;
        }
      case 7:
        {
          try {
            await ReportAPI.getAllByCar(device!.deviceID, _start, _end)
                .then((res) {
              _reportAllByCar = List<ReportAllByCarModel>.from(
                  res.map((e) => ReportAllByCarModel.fromJson(e)).toList());
            });
          } catch (e) {
            debugPrint(e.toString());
          }
          break;
        }
      case 8:
        {
          try {
            // await ReportAPI.getAllByDriver(device!.deviceID, _start, _end)
            //     .then((res) {
            //   debugPrint(res.toString());

            //   _reportModel = ReportModel.fromJson(res);
            // });
          } catch (e) {
            debugPrint(e.toString());
          }
          break;
        }
      case 9:
        {
          try {
            await ReportAPI.getMaxSpeed(device!.deviceID, _start, _end)
                .then((res) {
              debugPrint(res.toString());

              _reportMaxSpeed = List<ReportMaxSpeedModel>.from(
                  res.map((e) => ReportMaxSpeedModel.fromJson(e)).toList());
            });
          } catch (e) {
            debugPrint(e.toString());
          }
          break;
        }
      case 10:
        {
          try {
            await ReportAPI.getImg(device!.deviceID, _start, _end).then((res) {
              debugPrint(res.toString());

              _listDataImg = List<ReportImageModel>.from(
                  res.map((e) => ReportImageModel.fromJson(e)).toList());
            });
          } catch (e) {
            debugPrint(e.toString());
          }
          break;
        }
      default:
    }
    _loading = false;
    update();
  }

  updateDateStart(DateTime date) {
    _start = date;
    update();
  }

  updateTimeStart(TimeOfDay time) {
    _start =
        DateTime(_start.year, _start.month, _start.day, time.hour, time.minute);
    update();
  }

  updateDateEnd(DateTime date) {
    _end = date;
    update();
  }

  updateTimeEnd(TimeOfDay time) {
    _end = DateTime(_end.year, _end.month, _end.day, time.hour, time.minute);
    update();
  }

  List<DataModel> getDataReportHistory() {
    List<DataModel> data = [];
    if (_reportModel != null) {
      List<DataModel>? listDatas = _reportModel!.listData;
      data.add(listDatas![0]);
      for (var i = 1; i < listDatas.length - 1; i++) {
        if (listDatas[i].speed == 0.0) {
          var elm = listDatas[i - 1];
          if (elm.speed == 0.0) {
            continue;
          } else {
            data.add(listDatas[i]);
          }
        } else {
          data.add(listDatas[i]);
        }
      }
    }
    return data;
  }
}
