import 'package:json_annotation/json_annotation.dart';

part 'report_model.g.dart';

@JsonSerializable()
class ReportImageModel {
  // final int id;
  final String relativeURL;
  final DateTime timeImg;
  final double lat_;
  final double long_;
  final String? addr;
  final String? camName;

  ReportImageModel({
    // required this.id,
    required this.relativeURL,
    required this.timeImg,
    required this.lat_,
    required this.long_,
    this.addr = "",
    this.camName = "",
  });

  factory ReportImageModel.fromJson(Map<String, dynamic> json) =>
      _$ReportImageModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReportImageModelToJson(this);
}
