import 'package:json_annotation/json_annotation.dart';

part 'app_mock.g.dart';

@JsonSerializable()
class AppSystemMock {
  String typeMap;

  AppSystemMock({
    required this.typeMap,
  });

  factory AppSystemMock.fromJson(Map<String, dynamic> json) =>
      _$AppSystemMockFromJson(json);

  Map<String, dynamic> toJson() => _$AppSystemMockToJson(this);
}
