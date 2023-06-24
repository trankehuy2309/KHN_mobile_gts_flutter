import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:khn_tracking/src/core/services/local_storage_user.dart';
import 'package:khn_tracking/src/models/user_model.dart';

class UserController extends GetxController {
  bool _loading = false;
  bool get loading => _loading;

  final Rxn<UserModel>? _currentUser = Rxn<UserModel>();
  String? get user => _currentUser?.value?.username;

  @override
  void onInit() {
    getAccountInfo();
    super.onInit();
  }

  Future<void> getAccountInfo() async {
    _loading = true;
    try {
      await LocalStorageUser.getUserData().then((res) {
        if (res != null) {
          _currentUser!.value = res;
        }
      });
    } catch (e) {
      debugPrint(e.toString());
      _currentUser!.value = null;
    }
    _loading = false;
    update();
  }
}
