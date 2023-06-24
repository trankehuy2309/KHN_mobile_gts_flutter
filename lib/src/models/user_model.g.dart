// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfoModel _$UserInfoModelFromJson(Map<String, dynamic> json) =>
    UserInfoModel(
      id: json['id'] as int,
      userName: json['userName'] as String,
      fullName: json['fullName'] as String,
      idCard: json['idCard'] as String,
      sex: json['sex'] as int,
      email: json['email'] as String,
      birthday: json['birthday'] == null
          ? null
          : DateTime.parse(json['birthday'] as String),
      numberPhone: json['numberPhone'] as String,
      dateCreate: DateTime.parse(json['dateCreate'] as String),
      createBy: json['createBy'] as int,
      image: json['image'] as String?,
      roleId: json['roleId'] as int,
      isActive: json['isActive'] as int,
      address_: json['address_'] as String?,
    );

Map<String, dynamic> _$UserInfoModelToJson(UserInfoModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sex': instance.sex,
      'roleId': instance.roleId,
      'isActive': instance.isActive,
      'userName': instance.userName,
      'fullName': instance.fullName,
      'idCard': instance.idCard,
      'email': instance.email,
      'numberPhone': instance.numberPhone,
      'image': instance.image,
      'address_': instance.address_,
      'dateCreate': instance.dateCreate.toIso8601String(),
      'birthday': instance.birthday?.toIso8601String(),
      'createBy': instance.createBy,
    };

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      username: json['username'] as String,
      password: json['password'] as String,
      expiredAccount: DateTime.parse(json['expiredAccount'] as String),
      token: json['token'] as String,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'username': instance.username,
      'password': instance.password,
      'expiredAccount': instance.expiredAccount.toIso8601String(),
      'token': instance.token,
    };
