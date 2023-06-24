import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserInfoModel {
  final int id, sex, roleId, isActive;
  final String userName, fullName, idCard, email, numberPhone;
  final String? image, address_;
  final DateTime dateCreate;
  final DateTime? birthday;
  final int createBy;

  UserInfoModel({
    required this.id,
    required this.userName,
    required this.fullName,
    required this.idCard,
    required this.sex,
    required this.email,
    this.birthday,
    required this.numberPhone,
    required this.dateCreate,
    required this.createBy,
    this.image,
    required this.roleId,
    required this.isActive,
    this.address_,
  });

  factory UserInfoModel.fromJson(Map<String, dynamic> json) =>
      _$UserInfoModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserInfoModelToJson(this);
}

@JsonSerializable()
class UserModel {
  final String username;
  final String password;
  final DateTime expiredAccount;
  final String token;
  UserModel({
    required this.username,
    required this.password,
    required this.expiredAccount,
    required this.token,
  });
  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
