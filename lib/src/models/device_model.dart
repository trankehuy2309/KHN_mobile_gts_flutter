import 'package:json_annotation/json_annotation.dart';

part 'device_model.g.dart';

@JsonSerializable()
class DeviceGroupModel {
  final int vehicleGroupID;
  final String vehicleGroup;
  final int countdv;
  bool isShow;
  List<DeviceStageModel>? listDvStage;

  DeviceGroupModel({
    required this.vehicleGroupID,
    required this.vehicleGroup,
    required this.countdv,
    this.isShow = false,
    this.listDvStage,
  });

  factory DeviceGroupModel.fromJson(Map<String, dynamic> json) =>
      _$DeviceGroupModelFromJson(json);

  Map<String, dynamic> toJson() => _$DeviceGroupModelToJson(this);
}

@JsonSerializable()
class DeviceStageModel {
  final int deviceID;
  final String imei;
  final String vehicleNumber;
  late final double latitude;
  late final double longitude;
  final double? latitude_last;
  final double? longitude_last;
  final double speed;
  final int oilvalue;
  final String? oilval;
  final bool statusKey;
  final bool statusDoor;
  final String? in_Out;
  final bool? sleep;
  final String theDriver;
  final DateTime dateSave;
  final DateTime dateSaveLast;
  final bool? cooler;
  final int state;
  final String? stateStr;
  final String? addr;
  final String serialNumberInf_;
  final String? StatusExt;
  final bool isCamera;
  final String version;
  final DateTime dateExpired;

  //DeviceInfoModel? deviceInfo;

  DeviceStageModel({
    required this.deviceID,
    required this.imei,
    required this.vehicleNumber,
    required this.latitude,
    required this.longitude,
    this.latitude_last = 0.0,
    this.longitude_last = 0.0,
    required this.speed,
    required this.oilvalue,
    this.oilval,
    required this.statusKey,
    required this.statusDoor,
    this.in_Out = "0",
    this.serialNumberInf_ = "",
    this.StatusExt = "",
    this.sleep = false,
    required this.theDriver,
    required this.dateSave,
    required this.dateSaveLast,
    this.cooler = false,
    required this.state,
    this.stateStr,
    this.addr,
    required this.isCamera,
    required this.version,
    required this.dateExpired,

    //this.deviceInfo = null,
  });

  factory DeviceStageModel.fromJson(Map<String, dynamic> json) =>
      _$DeviceStageModelFromJson(json);

  Map<String, dynamic> toJson() => _$DeviceStageModelToJson(this);
}

@JsonSerializable()
class DeviceLessModel {
  final int deviceID;
  final String imei;
  final String nameDevice;
  final DateTime dateExpired;
  final String vehicleNumber;
  final bool qcvn;

  DeviceLessModel({
    required this.deviceID,
    required this.imei,
    required this.nameDevice,
    required this.dateExpired,
    required this.vehicleNumber,
    required this.qcvn,
  });

  factory DeviceLessModel.fromJson(Map<String, dynamic> json) =>
      _$DeviceLessModelFromJson(json);

  Map<String, dynamic> toJson() => _$DeviceLessModelToJson(this);
}

@JsonSerializable()
class DeviceExpModel {
  final String imei;
  final int deviceID;
  final String vehicleNumber;
  final DateTime dateExpired;
  DeviceExpModel({
    required this.imei,
    required this.deviceID,
    required this.vehicleNumber,
    required this.dateExpired,
  });
  factory DeviceExpModel.fromJson(Map<String, dynamic> json) =>
      _$DeviceExpModelFromJson(json);

  Map<String, dynamic> toJson() => _$DeviceExpModelToJson(this);
}
