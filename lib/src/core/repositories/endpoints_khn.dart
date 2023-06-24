import 'package:khn_tracking/src/helper/constants.dart';

class Endpoints {
  //////////////////////////////
  //        AUTH              //
  //////////////////////////////
  static String login() {
    return '$KHN_API_URL/home';
  }

  static String changePws() {
    return '$KHN_API_URL/home/UpdatePwd';
  }

  //////////////////////////////
  //        DEVICE            //
  //////////////////////////////
  ///
  static String getAllDevice() {
    return '$KHN_API_URL/device/all';
  }

  static String getListDeviceExp() {
    return '$KHN_API_URL/device/GetDv?mode=1';
  }

  static String getListDeviceByGroupId(int groupId) {
    return '$KHN_API_URL/device/group?id=$groupId';
  }

  static String getDevieStageById(int deviceId, bool opt) {
    return '$KHN_API_URL/device/search?id=$deviceId${opt ? '&opt=true' : ''}';
  }

  static String getDevieStageByVNumber(String verticalNumber) {
    return '$KHN_API_URL/device/search?vhn=$verticalNumber';
  }

  //////////////////////////////
  //     GROUP DEVICE         //
  //////////////////////////////
  static String getListGroup() {
    return '$KHN_API_URL/device/group';
  }
  //////////////////////////////
  //         REPORT          //
  ////////////////////////////

  static String getListImageFromTo(
      int deviceId, int? page, int? limit, DateTime? from, DateTime? to) {
    return '$KHN_API_URL/device/report/1?deviceId=$deviceId&page=$page&limit=$limit&from=${from ?? ""}&to=${to ?? ""}';
  }

  static String getHistoryDevice(int deviceId, DateTime? from, DateTime? to) {
    return '$KHN_API_URL/device/report/2?deviceId=$deviceId&from=$from&to=$to';
  }

  static String getDistanceDevice(int deviceId, DateTime? from, DateTime? to) {
    return '$KHN_API_URL/device/report/3?deviceId=$deviceId&from=$from&to=$to';
  }

  static String getSpeedDevice(int deviceId, DateTime? from, DateTime? to) {
    return '$KHN_API_URL/device/report/4?deviceId=$deviceId&from=$from&to=$to';
  }

  static String getPauseStop(int deviceId, DateTime? from, DateTime? to) {
    return '$KHN_API_URL/device/report/5?deviceId=$deviceId&from=$from&to=$to';
  }

  static String getRunning(int deviceId, DateTime? from, DateTime? to) {
    return '$KHN_API_URL/device/report/6?deviceId=$deviceId&from=$from&to=$to';
  }

  static String getOil(int deviceId, DateTime? from, DateTime? to) {
    return '$KHN_API_URL/device/report/9?deviceId=$deviceId&from=$from&to=$to';
  }

  static String getAllByCar(int deviceId, DateTime? from, DateTime? to) {
    return '$KHN_API_URL/device/report/7?deviceId=$deviceId&from=$from&to=$to';
  }

  static String getAllByDriver(int deviceId, DateTime? from, DateTime? to) {
    return '$KHN_API_URL/device/report/10?deviceId=$deviceId&from=$from&to=$to';
  }

  static String getMaxSpeed(int deviceId, DateTime? from, DateTime? to) {
    return '$KHN_API_URL/device/report/8?deviceId=$deviceId&from=$from&to=$to';
  }

  static String getImg(int deviceId, DateTime? from, DateTime? to) {
    return '$KHN_API_URL/device/report/11?deviceId=$deviceId&from=$from&to=$to';
  }
}
