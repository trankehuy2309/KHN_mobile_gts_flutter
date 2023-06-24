import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khn_tracking/src/views/pages/_page.dart';
import 'package:khn_tracking/src/views/pages/devices/device_page.dart';

import 'device_controller.dart';
import 'gmap_controller.dart';

class ControlViewModel extends GetxController {
  Widget _currentScreen = const HomePage();
  int _navigatorIndex = 2;

  Widget get currentScreen => _currentScreen;

  int get navigatorIndex => _navigatorIndex;

  changeCurrentScreen(int index) {
    _navigatorIndex = index;
    switch (index) {
      case 0:
        Get.find<GMapController>().setIsInterval(false);
        Get.find<DeviceController>().intervalDispose();
        _currentScreen = const AlterPage();
        break;
      case 1:
        Get.find<GMapController>().setIsInterval(false);
        Get.find<DeviceController>().intervalDispose();
        Get.find<DeviceController>().intervalCurrentData();
        Get.find<DeviceController>().intervalDispose();
        _currentScreen = const DevicePage();
        break;
      case 2:
        Get.find<DeviceController>().intervalDispose();
        Get.find<DeviceController>().intervalCurrentData();
        Get.find<GMapController>().setIsInterval(true);

        _currentScreen = const HomePage();
        break;
      case 3:
        Get.find<GMapController>().setIsInterval(false);
        Get.find<DeviceController>().intervalDispose();
        _currentScreen = const MenuPage();
        break;
      case 4:
        Get.find<GMapController>().setIsInterval(false);
        Get.find<DeviceController>().intervalDispose();
        _currentScreen = const ProfilePage();
        break;
    }
    update();
  }
}
