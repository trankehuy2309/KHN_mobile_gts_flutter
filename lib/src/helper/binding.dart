import 'package:get/get.dart';
import 'package:khn_tracking/src/core/controllers/_controller.dart';
import 'package:khn_tracking/src/core/controllers/app_system_controller.dart';
import 'package:khn_tracking/src/core/controllers/dashboard_report.dart';
import 'package:khn_tracking/src/core/controllers/user_controller.dart';

class Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthController());
    Get.lazyPut(() => UserController());
    Get.lazyPut(() => DeviceController());
    Get.lazyPut(() => AppSystemController());
    Get.lazyPut(() => NetworkViewModel());
    Get.lazyPut(() => DashboardReportController());
  }
}
