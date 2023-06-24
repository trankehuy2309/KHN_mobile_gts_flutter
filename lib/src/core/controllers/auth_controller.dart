import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khn_tracking/src/core/repositories/authentication_api.dart';
import 'package:khn_tracking/src/core/services/local_storage_user.dart';
import 'package:khn_tracking/src/models/user_model.dart';
import 'package:khn_tracking/src/views/pages/control_page.dart';

import '_controller.dart';
import 'dashboard_report.dart';
import 'gmap_controller.dart';

class AuthController extends GetxController {
  bool _passwordVisible = true;
  bool _loading = false;
  bool _showDialog = false;
  bool get showDialog => _showDialog;
  late String token;

  bool get loading => _loading;
  String? username, password, passwordOld, passwordNew, passwordConfirm;

  bool? get passwordVisible => _passwordVisible;
  final Rxn<UserModel>? _currentUser = Rxn<UserModel>();
  // UserModel? _currentUser;
  String? get user => _currentUser?.value?.username;
  final Rxn<String>? _userName = Rxn<String>();

  String? get userName => _userName?.value;
  @override
  void onInit() {
    getUserName();
    getCurrentUser();
    super.onInit();
  }

  @override
  void onClose() {
    debugPrint('AuthController onClose');
  }

  void getUserName() async {
    await LocalStorageUser.getUserName().then((res) async {
      _userName!.value = res!;
      update();
    });
  }

  Future<void> getCurrentUser() async {
    try {
      await LocalStorageUser.getUserData().then((res) {
        if (res != null) {
          DateTime now = DateTime.now();
          DateTime exp = res.expiredAccount;
          if (exp.isAfter(now)) {
            _currentUser!.value = res;
          } else {
            _currentUser!.value = null;
          }
        }
      });
    } on Exception catch (e) {
      // ignore: todo
      // TODO
      debugPrint(e.toString());
      _currentUser!.value = null;
    }
    update();
  }

  void signOut() async {
    try {
      Get.delete<DeviceController>();
      Get.delete<GMapController>();
      Get.delete<DashboardReportController>();
      _currentUser!.value = null;
      await LocalStorageUser.clearUserData();
    } catch (error) {
      // ignore: avoid_print
      print(error);
    }
  }

  Future<void> refreshToken() async {
    _loading = true;
    update();
    try {
      await AuthAPI.signInWithUserAndPassword(
              _currentUser!.value!.username, _currentUser!.value!.password)
          .then((res) {
        // debugPrint(res['token'].toString());
        // debugPrint(res.toString());
        if (res['status'] == 400) {
          throw 'Error Tên đăng nhập hoặc mật khẩu không chính xác';
        } else {
          UserModel user = UserModel(
              username: _currentUser!.value!.username,
              token: res['token'],
              password: _currentUser!.value!.password,
              expiredAccount: DateTime.now().add(const Duration(hours: 1)));
          saveUserLocal(user);
        }
      });
    } catch (error) {
      String errorMessage =
          error.toString().substring(error.toString().indexOf(' ') + 1);
      Get.snackbar(
        'Failed to login..',
        errorMessage,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
    _loading = false;
    update();
  }

  Future<void> changePassword(String oldPassword, String newPassword) async {
    _loading = true;
    update();
    try {
      await AuthAPI.changePws(oldPassword, newPassword).then((res) {
        debugPrint(res.toString());
        if (res.toInt() == 0) {
          Get.snackbar(
            'Thông báo',
            'Mật khẩu không chính xác. vui lòng kiểm tra lại',
            snackPosition: SnackPosition.BOTTOM,
          );
        } else {
          signOut();
          _showDialog = true;
        }
      });
    } catch (e) {
      debugPrint(e.toString());
    }
    _loading = false;
    update();
  }

  void signInWithUserAndPassword() async {
    _loading = true;
    update();
    try {
      Get.lazyPut(() => DeviceController());
      Get.lazyPut(() => GMapController());
      await AuthAPI.signInWithUserAndPassword(username!, password!).then((res) {
        if (res['status'] == 400) {
          throw 'Error Tên đăng nhập hoặc mật khẩu không chính xác';
        } else {
          _userName!.value = username!;
          UserModel user = UserModel(
              username: username!,
              token: res['token'],
              //'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6InRhbWxpZW4iLCJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9zaWQiOiIzMjM4NSIsInJvbGUiOiI0IiwibmJmIjoxNjM4MzQ2NTE4LCJleHAiOjE2MzgzNTAxMTgsImlhdCI6MTYzODM0NjUxOH0.p7we7mz8x3JwVQ8K43Wl0ziZ4uUwHTtLmIxVx35a_DM',
              password: password!,
              expiredAccount: DateTime.now().add(const Duration(days: 1)));
          saveUserLocal(user);
        }
      });
      await getCurrentUser();
      Get.offAll(() => const ControlPage());
    } catch (error) {
      String errorMessage =
          error.toString().substring(error.toString().indexOf(' ') + 1);
      Get.snackbar(
        'Failed to login..',
        errorMessage,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
    _loading = false;
    update();
  }
  // void saveUser(UserCredential userCredential) async {
  //   UserInfoModel _userModel = UserInfoModel(
  //     userId: userCredential.user!.uid,
  //     email: userCredential.user!.email!,
  //     name: name == null ? userCredential.user!.displayName! : this.name!,
  //     pic: userCredential.user!.photoURL == null
  //         ? 'default'
  //         : userCredential.user!.photoURL! + "?width=400",
  //   );
  //   saveUserLocal(_userModel);
  // }

  void saveUserLocal(UserModel prefsUser) async {
    LocalStorageUser.setUserData(prefsUser);
  }

  void togglePasswordVisible() {
    _passwordVisible = !_passwordVisible;
    update();
  }
}
