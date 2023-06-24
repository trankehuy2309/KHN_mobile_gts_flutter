// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_distance.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReportModel _$ReportModelFromJson(Map<String, dynamic> json) => ReportModel(
      deviceid: json['deviceid'] as int,
      vehicleNumber: json['vehicleNumber'] as String? ?? "",
      distances: (json['distances'] as num).toDouble(),
      speedAVG: (json['speedAVG'] as num).toDouble(),
      speedMax: (json['speedMax'] as num).toDouble(),
      listData: (json['listData'] as List<dynamic>?)
          ?.map((e) => DataModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ReportModelToJson(ReportModel instance) =>
    <String, dynamic>{
      'deviceid': instance.deviceid,
      'vehicleNumber': instance.vehicleNumber,
      'distances': instance.distances,
      'speedAVG': instance.speedAVG,
      'speedMax': instance.speedMax,
      'listData': instance.listData,
    };

DataModel _$DataModelFromJson(Map<String, dynamic> json) => DataModel(
      speed: json['speed'] as int,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      dateSave: DateTime.parse(json['dateSave'] as String),
      addr: json['addr'] as String? ?? "",
    );

Map<String, dynamic> _$DataModelToJson(DataModel instance) => <String, dynamic>{
      'speed': instance.speed,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'dateSave': instance.dateSave.toIso8601String(),
      'addr': instance.addr,
    };

ReportPauseStopModel _$ReportPauseStopModelFromJson(
        Map<String, dynamic> json) =>
    ReportPauseStopModel(
      vehicleNumber: json['vehicleNumber'] as String,
      dateTime: DateTime.parse(json['dateTime'] as String),
      duration: json['duration'] as String,
      address: json['address'] as String,
      coordinates: json['coordinates'] as String,
      nameDriver: json['nameDriver'] as String? ?? "",
      driverLicense: json['driverLicense'] as String? ?? "",
      typeTransportName: json['typeTransportName'] as String,
      status: json['status'] as String,
    );

Map<String, dynamic> _$ReportPauseStopModelToJson(
        ReportPauseStopModel instance) =>
    <String, dynamic>{
      'vehicleNumber': instance.vehicleNumber,
      'dateTime': instance.dateTime.toIso8601String(),
      'duration': instance.duration,
      'address': instance.address,
      'coordinates': instance.coordinates,
      'nameDriver': instance.nameDriver,
      'driverLicense': instance.driverLicense,
      'typeTransportName': instance.typeTransportName,
      'status': instance.status,
    };

ReportRunningModel _$ReportRunningModelFromJson(Map<String, dynamic> json) =>
    ReportRunningModel(
      vehicleNumber: json['vehicleNumber'] as String,
      addressStart: json['addressStart'] as String,
      coordinatesStart: json['coordinatesStart'] as String,
      addressEnd: json['addressEnd'] as String,
      coordinatesEnd: json['coordinatesEnd'] as String,
      nameDriver: json['nameDriver'] as String? ?? "",
      driverLicense: json['driverLicense'] as String? ?? "",
      start: DateTime.parse(json['start'] as String),
      end: DateTime.parse(json['end'] as String),
      stimedriver: (json['stimedriver'] as num).toDouble(),
      typeTransportName: json['typeTransportName'] as String,
    );

Map<String, dynamic> _$ReportRunningModelToJson(ReportRunningModel instance) =>
    <String, dynamic>{
      'vehicleNumber': instance.vehicleNumber,
      'addressStart': instance.addressStart,
      'coordinatesStart': instance.coordinatesStart,
      'addressEnd': instance.addressEnd,
      'coordinatesEnd': instance.coordinatesEnd,
      'nameDriver': instance.nameDriver,
      'driverLicense': instance.driverLicense,
      'start': instance.start.toIso8601String(),
      'end': instance.end.toIso8601String(),
      'stimedriver': instance.stimedriver,
      'typeTransportName': instance.typeTransportName,
    };

ReportSpeedModel _$ReportSpeedModelFromJson(Map<String, dynamic> json) =>
    ReportSpeedModel(
      datesave: DateTime.parse(json['datesave'] as String),
      speed: json['speed'] as int,
    );

Map<String, dynamic> _$ReportSpeedModelToJson(ReportSpeedModel instance) =>
    <String, dynamic>{
      'datesave': instance.datesave.toIso8601String(),
      'speed': instance.speed,
    };

ReportAllByCarModel _$ReportAllByCarModelFromJson(Map<String, dynamic> json) =>
    ReportAllByCarModel(
      vehicleNumber: json['vehicleNumber'] as String,
      date: DateTime.parse(json['date'] as String),
      distance: json['distance'] as String,
      sExceedingSpeed: json['sExceedingSpeed'] as String,
      sPause_Stop: json['sPause_Stop'] as int,
      tyle1: (json['tyle1'] as num).toDouble(),
      tyle2: (json['tyle2'] as num).toDouble(),
      tyle3: (json['tyle3'] as num).toDouble(),
      tyle4: (json['tyle4'] as num).toDouble(),
      solan1: json['solan1'] as int,
      solan2: json['solan2'] as int,
      solan3: json['solan3'] as int,
      solan4: json['solan4'] as int,
      typeTransportName: json['typeTransportName'] as String,
      sExceedingSpeed1000: json['sExceedingSpeed1000'] as String,
    );

Map<String, dynamic> _$ReportAllByCarModelToJson(
        ReportAllByCarModel instance) =>
    <String, dynamic>{
      'vehicleNumber': instance.vehicleNumber,
      'date': instance.date.toIso8601String(),
      'distance': instance.distance,
      'sExceedingSpeed': instance.sExceedingSpeed,
      'sPause_Stop': instance.sPause_Stop,
      'tyle1': instance.tyle1,
      'tyle2': instance.tyle2,
      'tyle3': instance.tyle3,
      'tyle4': instance.tyle4,
      'solan1': instance.solan1,
      'solan2': instance.solan2,
      'solan3': instance.solan3,
      'solan4': instance.solan4,
      'typeTransportName': instance.typeTransportName,
      'sExceedingSpeed1000': instance.sExceedingSpeed1000,
    };

ReportMaxSpeedModel _$ReportMaxSpeedModelFromJson(Map<String, dynamic> json) =>
    ReportMaxSpeedModel(
      vehicleNumber: json['vehicleNumber'] as String,
      date: DateTime.parse(json['date'] as String),
      timeStart: json['timeStart'] as String,
      timeEnd: json['timeEnd'] as String,
      address: json['address'] as String,
      addressEnd: json['addressEnd'] as String,
      duration: json['duration'] as String,
      distance: json['distance'] as int,
      speedLimit: json['speedLimit'] as String,
      tocDoTrungBinh: json['tocDoTrungBinh'] as String,
    );

Map<String, dynamic> _$ReportMaxSpeedModelToJson(
        ReportMaxSpeedModel instance) =>
    <String, dynamic>{
      'vehicleNumber': instance.vehicleNumber,
      'date': instance.date.toIso8601String(),
      'timeStart': instance.timeStart,
      'timeEnd': instance.timeEnd,
      'address': instance.address,
      'addressEnd': instance.addressEnd,
      'duration': instance.duration,
      'distance': instance.distance,
      'speedLimit': instance.speedLimit,
      'tocDoTrungBinh': instance.tocDoTrungBinh,
    };

ReportOilModel _$ReportOilModelFromJson(Map<String, dynamic> json) =>
    ReportOilModel(
      vehicleNumber: json['vehicleNumber'] as String,
      flagFuel: json['flagFuel'] as int,
      method_name: json['method_name'] as String,
      volumeOilBarrel: json['volumeOilBarrel'] as int,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => DataOilModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ReportOilModelToJson(ReportOilModel instance) =>
    <String, dynamic>{
      'vehicleNumber': instance.vehicleNumber,
      'flagFuel': instance.flagFuel,
      'method_name': instance.method_name,
      'volumeOilBarrel': instance.volumeOilBarrel,
      'data': instance.data,
    };

DataOilModel _$DataOilModelFromJson(Map<String, dynamic> json) => DataOilModel(
      speed: json['speed'] as int,
      dateSave: DateTime.parse(json['dateSave'] as String),
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      oilValue: json['oilValue'] as int,
    );

Map<String, dynamic> _$DataOilModelToJson(DataOilModel instance) =>
    <String, dynamic>{
      'speed': instance.speed,
      'dateSave': instance.dateSave.toIso8601String(),
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'oilValue': instance.oilValue,
    };
