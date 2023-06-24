import 'dart:ui';

import 'package:get/get.dart';
import 'package:khn_tracking/src/core/services/local_storage_locale.dart';
import 'package:khn_tracking/src/core/services/local_storage_map.dart';

class AppSystemController extends GetxController {
  String? mName;
  // final AppSystemMock? _currentAppSystem = getMap() as AppSystemMock?;
  String? get typeMap => getMName().toString();
  final Rxn<Locale>? _mLocale = Rxn<Locale>();
  // UserModel? _currentUser;
  String? get mLanguage => _mLocale?.value?.languageCode;

  @override
  void onInit() {
    getMName();
    gLocale();
    super.onInit();
  }

  @override
  void onClose() {}

  Future<void> getMName() async {
    mName = await getMap();
  }

  Future<void> gLocale() async {
    _mLocale!.value = await getLocale();
  }

  Future<void> changeLocale() async {
    if (mLanguage != 'vi') {
      await setLocale('vi', 'VN');
      _mLocale!.value = const Locale('vi', 'VN');
      Get.updateLocale(const Locale('vi', 'VN'));
    } else {
      await setLocale('en', 'US');
      _mLocale!.value = const Locale('en', 'US');
      Get.updateLocale(const Locale('en', 'US'));
    }
    update();
  }

  // void saveUserLocal(UserModel userModel) async {
  //   LocalStorageUser.setUserData(userModel);
  // }
}
