import 'package:khn_tracking/src/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class LocalStorageUser {
  static setUserData(UserModel prefsUser) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user', json.encode(prefsUser.toJson()));
    await prefs.setString('username', prefsUser.username);
  }

  static Future<UserModel?> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('user') != null) {
      return UserModel.fromJson(
          json.decode(prefs.getString('user')!) as Map<String, dynamic>);
    }
    return null;
  }

  static Future<String?> getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('username') != null) {
      return prefs.getString('username');
    }
    return '';
  }

  static clearUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('user');
  }
}
