import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:khn_tracking/src/core/controllers/auth_controller.dart';

Future<Response> getRequest(
  Uri url,
  Map<String, String> headers,
) async {
  try {
    final _client = http.Client();
    Response response = await _client
        .get(url, headers: headers)
        .timeout(const Duration(seconds: 60));
    if (response.statusCode == 401) {
      await Get.find<AuthController>().refreshToken();
      return http.Response('Error', 408);
    } else {
      return response;
    }
  } catch (e) {
    debugPrint(e.toString());
    return http.Response('Error', 408);
  }
}

Future<Response> postRequest(
    Uri url, Map<String, String> headers, Map<String, dynamic> body) async {
  try {
    final _client = http.Client();
    Response response = await _client
        .post(url, body: json.encode(body), headers: headers)
        .timeout(const Duration(seconds: 60));
    // .whenComplete(_client.close);
    if (response.statusCode == 401) {
      Get.find<AuthController>().refreshToken();
      Response? response;
      return response!;
    } else {
      return response;
    }
  } catch (e) {
    debugPrint(e.toString());
    // Get.find<AuthController>().signOut();
    Response? response;
    return response!;
  }
}
