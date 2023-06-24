import 'package:json_annotation/json_annotation.dart';

part 'report_distance.g.dart';

@JsonSerializable()
class ReportModel {
  final int deviceid;
  final String? vehicleNumber;
  final double distances;
  final double speedAVG;
  final double speedMax;
  final List<DataModel>? listData;

  ReportModel({
    required this.deviceid,
    this.vehicleNumber = "",
    required this.distances,
    required this.speedAVG,
    required this.speedMax,
    this.listData,
  });

  factory ReportModel.fromJson(Map<String, dynamic> json) =>
      _$ReportModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReportModelToJson(this);
}

@JsonSerializable()
class DataModel {
  final int speed;
  final double latitude;
  final double longitude;
  final DateTime dateSave;
  final String? addr;

  DataModel({
    required this.speed,
    required this.latitude,
    required this.longitude,
    required this.dateSave,
    this.addr = "",
  });

  factory DataModel.fromJson(Map<String, dynamic> json) =>
      _$DataModelFromJson(json);

  Map<String, dynamic> toJson() => _$DataModelToJson(this);
}

@JsonSerializable()
class ReportPauseStopModel {
  final String vehicleNumber;
  final DateTime dateTime;
  final String duration;
  final String address;
  final String coordinates;
  final String? nameDriver;
  final String? driverLicense;
  final String typeTransportName;
  final String status;

  ReportPauseStopModel({
    required this.vehicleNumber,
    required this.dateTime,
    required this.duration,
    required this.address,
    required this.coordinates,
    this.nameDriver = "",
    this.driverLicense = "",
    required this.typeTransportName,
    required this.status,
  });

  factory ReportPauseStopModel.fromJson(Map<String, dynamic> json) =>
      _$ReportPauseStopModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReportPauseStopModelToJson(this);
}

@JsonSerializable()
class ReportRunningModel {
  final String vehicleNumber;
  final String addressStart;
  final String coordinatesStart;
  final String addressEnd;
  final String coordinatesEnd;
  final String? nameDriver;
  final String? driverLicense;
  final DateTime start;
  final DateTime end;
  final double stimedriver;
  final String typeTransportName;

  ReportRunningModel({
    required this.vehicleNumber,
    required this.addressStart,
    required this.coordinatesStart,
    required this.addressEnd,
    required this.coordinatesEnd,
    this.nameDriver = "",
    this.driverLicense = "",
    required this.start,
    required this.end,
    required this.stimedriver,
    required this.typeTransportName,
  });

  factory ReportRunningModel.fromJson(Map<String, dynamic> json) =>
      _$ReportRunningModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReportRunningModelToJson(this);
}

@JsonSerializable()
class ReportSpeedModel {
  final DateTime datesave;
  final int speed;

  ReportSpeedModel({
    required this.datesave,
    required this.speed,
  });

  factory ReportSpeedModel.fromJson(Map<String, dynamic> json) =>
      _$ReportSpeedModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReportSpeedModelToJson(this);
}

@JsonSerializable()
class ReportAllByCarModel {
  final String vehicleNumber;
  final DateTime date;
  final String distance;
  final String sExceedingSpeed;
  final int sPause_Stop;
  final double tyle1;
  final double tyle2;
  final double tyle3;
  final double tyle4;
  final int solan1;
  final int solan2;
  final int solan3;
  final int solan4;
  final String typeTransportName;
  final String sExceedingSpeed1000;

  ReportAllByCarModel({
    required this.vehicleNumber,
    required this.date,
    required this.distance,
    required this.sExceedingSpeed,
    required this.sPause_Stop,
    required this.tyle1,
    required this.tyle2,
    required this.tyle3,
    required this.tyle4,
    required this.solan1,
    required this.solan2,
    required this.solan3,
    required this.solan4,
    required this.typeTransportName,
    required this.sExceedingSpeed1000,
  });

  factory ReportAllByCarModel.fromJson(Map<String, dynamic> json) =>
      _$ReportAllByCarModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReportAllByCarModelToJson(this);
}

@JsonSerializable()
class ReportMaxSpeedModel {
  final String vehicleNumber;
  final DateTime date;
  final String timeStart;
  final String timeEnd;
  final String address;
  final String addressEnd;
  final String duration;
  final int distance;
  final String speedLimit;
  final String tocDoTrungBinh;

  ReportMaxSpeedModel({
    required this.vehicleNumber,
    required this.date,
    required this.timeStart,
    required this.timeEnd,
    required this.address,
    required this.addressEnd,
    required this.duration,
    required this.distance,
    required this.speedLimit,
    required this.tocDoTrungBinh,
  });

  factory ReportMaxSpeedModel.fromJson(Map<String, dynamic> json) =>
      _$ReportMaxSpeedModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReportMaxSpeedModelToJson(this);
}

@JsonSerializable()
class ReportOilModel {
  final String vehicleNumber;
  final int flagFuel;
  final String method_name;
  final int volumeOilBarrel;
  final List<DataOilModel>? data;
  ReportOilModel({
    required this.vehicleNumber,
    required this.flagFuel,
    required this.method_name,
    required this.volumeOilBarrel,
    this.data,
  });

  factory ReportOilModel.fromJson(Map<String, dynamic> json) =>
      _$ReportOilModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReportOilModelToJson(this);
}

@JsonSerializable()
class DataOilModel {
  final int speed;
  final DateTime dateSave;
  final double latitude;
  final double longitude;
  final int oilValue;
  DataOilModel({
    required this.speed,
    required this.dateSave,
    required this.latitude,
    required this.longitude,
    required this.oilValue,
  });

  factory DataOilModel.fromJson(Map<String, dynamic> json) =>
      _$DataOilModelFromJson(json);

  Map<String, dynamic> toJson() => _$DataOilModelToJson(this);
}
