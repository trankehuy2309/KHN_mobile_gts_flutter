// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReportImageModel _$ReportImageModelFromJson(Map<String, dynamic> json) =>
    ReportImageModel(
      relativeURL: json['relativeURL'] as String,
      timeImg: DateTime.parse(json['timeImg'] as String),
      lat_: (json['lat_'] as num).toDouble(),
      long_: (json['long_'] as num).toDouble(),
      addr: json['addr'] as String? ?? "",
      camName: json['camName'] as String? ?? "",
    );

Map<String, dynamic> _$ReportImageModelToJson(ReportImageModel instance) =>
    <String, dynamic>{
      'relativeURL': instance.relativeURL,
      'timeImg': instance.timeImg.toIso8601String(),
      'lat_': instance.lat_,
      'long_': instance.long_,
      'addr': instance.addr,
      'camName': instance.camName,
    };
