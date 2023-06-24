import 'dart:convert';
import 'package:khn_tracking/src/core/services/local_storage_user.dart';
import 'package:khn_tracking/src/models/user_model.dart';

import 'endpoints_khn.dart';
import 'request_api.dart';

class AuthAPI {
  static Future<dynamic> signInWithUserAndPassword(
      String username, String password) async {
    Map<String, String> headers = {
      'Content-type': 'application/json; charset=utf-8',
      'Accept': 'application/json',
    };
    Map<String, dynamic> user = {
      'UserName': username,
      '_Password': password,
    };
    final response =
        await postRequest(Uri.parse(Endpoints.login()), headers, user);
    return json.decode(response.body);
  }

  static Future<dynamic> changePws(String oldPws, String newPws) async {
    UserModel? prefsUser = await LocalStorageUser.getUserData();
    Map<String, String> headers = {
      'Content-type': 'application/json; charset=utf-8',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${prefsUser!.token}',
    };
    Map<String, dynamic> data = {
      'oldpwd': oldPws,
      'newpwd': newPws,
    };
    final response =
        await postRequest(Uri.parse(Endpoints.changePws()), headers, data);
    return json.decode(response.body);
  }
}
