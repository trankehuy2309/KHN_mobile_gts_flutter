import 'dart:convert';
import 'package:khn_tracking/src/core/services/local_storage_user.dart';
import 'package:khn_tracking/src/models/user_model.dart';

import 'endpoints_khn.dart';
import 'request_api.dart';

class ReportAPI {
  // image
  static Future<dynamic> getListImageFromTo(
      vehicleNumber, page, limit, from, to) async {
    UserModel? prefsUser = await LocalStorageUser.getUserData();
    Map<String, String> headers = {
      'Content-type': 'application/json; charset=utf-8',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${prefsUser!.token}',
    };
    final response = await getRequest(
        Uri.parse(
            Endpoints.getListImageFromTo(vehicleNumber, page, limit, from, to)),
        headers);
    return json.decode(response.body);
  }

  // quãng đường
  static Future<dynamic> getDistanceDevice(deviceId, from, to) async {
    UserModel? prefsUser = await LocalStorageUser.getUserData();
    Map<String, String> headers = {
      'Content-type': 'application/json; charset=utf-8',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${prefsUser!.token}',
    };
    final response = await getRequest(
        Uri.parse(Endpoints.getDistanceDevice(deviceId, from, to)), headers);
    return json.decode(response.body);
  }

  // lộ trình
  static Future<dynamic> getHistoryDevice(deviceId, from, to) async {
    UserModel? prefsUser = await LocalStorageUser.getUserData();
    Map<String, String> headers = {
      'Content-type': 'application/json; charset=utf-8',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${prefsUser!.token}',
    };
    final response = await getRequest(
        Uri.parse(Endpoints.getHistoryDevice(deviceId, from, to)), headers);
    return json.decode(response.body);
  }

  // dữ liệu vận tốc
  static Future<dynamic> getSpeedDevice(deviceId, from, to) async {
    UserModel? prefsUser = await LocalStorageUser.getUserData();
    Map<String, String> headers = {
      'Content-type': 'application/json; charset=utf-8',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${prefsUser!.token}',
    };
    final response = await getRequest(
        Uri.parse(Endpoints.getSpeedDevice(deviceId, from, to)), headers);
    return json.decode(response.body);
  }

  // dừng đỗ
  static Future<dynamic> getPauseStop(deviceId, from, to) async {
    UserModel? prefsUser = await LocalStorageUser.getUserData();
    Map<String, String> headers = {
      'Content-type': 'application/json; charset=utf-8',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${prefsUser!.token}',
    };
    final response = await getRequest(
        Uri.parse(Endpoints.getPauseStop(deviceId, from, to)), headers);
    return json.decode(response.body);
  }

  // thời gian lái xe liên tục
  static Future<dynamic> getRunning(deviceId, from, to) async {
    UserModel? prefsUser = await LocalStorageUser.getUserData();
    Map<String, String> headers = {
      'Content-type': 'application/json; charset=utf-8',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${prefsUser!.token}',
    };
    final response = await getRequest(
        Uri.parse(Endpoints.getRunning(deviceId, from, to)), headers);
    return json.decode(response.body);
  }

  // tiêu thụ nhiên liệu
  static Future<dynamic> getOil(deviceId, from, to) async {
    UserModel? prefsUser = await LocalStorageUser.getUserData();
    Map<String, String> headers = {
      'Content-type': 'application/json; charset=utf-8',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${prefsUser!.token}',
    };
    final response = await getRequest(
        Uri.parse(Endpoints.getOil(deviceId, from, to)), headers);
    return json.decode(response.body);
  }

  // tổng hợp theo xe
  static Future<dynamic> getAllByCar(deviceId, from, to) async {
    UserModel? prefsUser = await LocalStorageUser.getUserData();
    Map<String, String> headers = {
      'Content-type': 'application/json; charset=utf-8',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${prefsUser!.token}',
    };
    final response = await getRequest(
        Uri.parse(Endpoints.getAllByCar(deviceId, from, to)), headers);
    return json.decode(response.body);
  }

  // tổng hợp theo tài xế
  static Future<dynamic> getAllByDriver(deviceId, from, to) async {
    UserModel? prefsUser = await LocalStorageUser.getUserData();
    Map<String, String> headers = {
      'Content-type': 'application/json; charset=utf-8',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${prefsUser!.token}',
    };
    final response = await getRequest(
        Uri.parse(Endpoints.getAllByDriver(deviceId, from, to)), headers);
    return json.decode(response.body);
  }

  // quá tốc độ giới hạn
  static Future<dynamic> getMaxSpeed(deviceId, from, to) async {
    UserModel? prefsUser = await LocalStorageUser.getUserData();
    Map<String, String> headers = {
      'Content-type': 'application/json; charset=utf-8',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${prefsUser!.token}',
    };
    final response = await getRequest(
        Uri.parse(Endpoints.getMaxSpeed(deviceId, from, to)), headers);
    return json.decode(response.body);
  }

  static Future<dynamic> getImg(deviceId, from, to) async {
    UserModel? prefsUser = await LocalStorageUser.getUserData();
    Map<String, String> headers = {
      'Content-type': 'application/json; charset=utf-8',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${prefsUser!.token}',
    };
    final response = await getRequest(
        Uri.parse(Endpoints.getImg(deviceId, from, to)), headers);
    return json.decode(response.body);
  }
}
