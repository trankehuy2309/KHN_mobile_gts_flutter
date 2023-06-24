// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeviceGroupModel _$DeviceGroupModelFromJson(Map<String, dynamic> json) =>
    DeviceGroupModel(
      vehicleGroupID: json['vehicleGroupID'] as int,
      vehicleGroup: json['vehicleGroup'] as String,
      countdv: json['countdv'] as int,
      isShow: json['isShow'] as bool? ?? false,
      listDvStage: (json['listDvStage'] as List<dynamic>?)
          ?.map((e) => DeviceStageModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DeviceGroupModelToJson(DeviceGroupModel instance) =>
    <String, dynamic>{
      'vehicleGroupID': instance.vehicleGroupID,
      'vehicleGroup': instance.vehicleGroup,
      'countdv': instance.countdv,
      'isShow': instance.isShow,
      'listDvStage': instance.listDvStage,
    };

DeviceStageModel _$DeviceStageModelFromJson(Map<String, dynamic> json) =>
    DeviceStageModel(
      deviceID: json['deviceID'] as int,
      vehicleNumber: json['vehicleNumber'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      latitude_last: (json['latitude_last'] as num?)?.toDouble() ?? 0.0,
      longitude_last: (json['longitude_last'] as num?)?.toDouble() ?? 0.0,
      speed: (json['speed'] as num).toDouble(),
      oilvalue: json['oilvalue'] as int,
      oilval: json['oilval'] as String?,
      statusKey: json['statusKey'] as bool,
      statusDoor: json['statusDoor'] as bool,
      in_Out: json['in_Out'] as String? ?? "0",
      sleep: json['sleep'] as bool? ?? false,
      theDriver: json['theDriver'] as String,
      dateSave: DateTime.parse(json['dateSave'] as String),
      dateSaveLast: (json['dateSaveLast'] == null
          ? DateTime.now()
          : DateTime.parse(json['dateSaveLast'] as String)),
      cooler: json['cooler'] as bool? ?? false,
      state: json['state'] as int,
      stateStr: json['stateStr'] as String?,
      addr: json['addr'] as String? ?? '',
      //serialNumberInf
      serialNumberInf_: json['serialNumberInf_'] as String? ?? "#",
      StatusExt: json['statusExt'] as String? ?? "",
      isCamera: json['isCamera'] as bool? ?? false,
      dateExpired: DateTime.parse(json['dateExpired'] as String),
      version: json['version'] as String? ?? "",
      imei: json['imei'] as String? ?? "",
      //deviceInfo: json['deviceInfo'] == null
      //  ? null
      //: DeviceInfoModel.fromJson(
      //  json['deviceInfo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DeviceStageModelToJson(DeviceStageModel instance) =>
    <String, dynamic>{
      'deviceID': instance.deviceID,
      'vehicleNumber': instance.vehicleNumber,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'latitude_last': instance.latitude_last,
      'longitude_last': instance.longitude_last,
      'speed': instance.speed,
      'oilvalue': instance.oilvalue,
      'oilval': instance.oilval,
      'statusKey': instance.statusKey,
      'statusDoor': instance.statusDoor,
      'in_Out': instance.in_Out,
      'sleep': instance.sleep,
      'theDriver': instance.theDriver,
      'dateSave': instance.dateSave.toIso8601String(),
      'dateSaveLast': instance.dateSaveLast.toIso8601String(),
      'cooler': instance.cooler,
      'state': instance.state,
      'stateStr': instance.stateStr,
      'statusExt': instance.StatusExt,
      'addr': instance.addr,
      'serialNumberInf_': instance.serialNumberInf_,
      'isCamera': instance.isCamera,
      'dateExpired': instance.dateExpired,
      'version': instance.version,
      'imei': instance.imei,

      //'deviceInfo': instance.deviceInfo,
    };

DeviceLessModel _$DeviceLessModelFromJson(Map<String, dynamic> json) =>
    DeviceLessModel(
      deviceID: json['deviceID'] as int,
      imei: json['imei'] as String,
      nameDevice: json['nameDevice'] as String,
      dateExpired: DateTime.parse(json['dateExpired'] as String),
      vehicleNumber: json['vehicleNumber'] as String,
      qcvn: json['qcvn'] as bool,
    );

Map<String, dynamic> _$DeviceLessModelToJson(DeviceLessModel instance) =>
    <String, dynamic>{
      'deviceID': instance.deviceID,
      'imei': instance.imei,
      'nameDevice': instance.nameDevice,
      'dateExpired': instance.dateExpired.toIso8601String(),
      'vehicleNumber': instance.vehicleNumber,
      'qcvn': instance.qcvn,
    };

DeviceExpModel _$DeviceExpModelFromJson(Map<String, dynamic> json) =>
    DeviceExpModel(
      imei: json['imei'] as String,
      deviceID: json['deviceID'] as int,
      vehicleNumber: json['vehicleNumber'] as String,
      dateExpired: DateTime.parse(json['dateExpired'] as String),
    );

Map<String, dynamic> _$DeviceExpModelToJson(DeviceExpModel instance) =>
    <String, dynamic>{
      'imei': instance.imei,
      'deviceID': instance.deviceID,
      'vehicleNumber': instance.vehicleNumber,
      'dateExpired': instance.dateExpired.toIso8601String(),
    };
