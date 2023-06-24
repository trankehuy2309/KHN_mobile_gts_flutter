import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:khn_tracking/src/core/controllers/_controller.dart';
import 'package:khn_tracking/src/core/controllers/network_controller.dart';
import 'package:khn_tracking/src/core/controllers/page_controller.dart';
import 'package:khn_tracking/src/views/pages/auth/auth_page.dart';
import 'package:khn_tracking/src/views/widgets/custom_navigator_bar.dart';
import 'package:khn_tracking/src/views/widgets/custom_text.dart';
import 'package:new_version/new_version.dart';

class ControlPage extends StatefulWidget {
  const ControlPage({Key? key}) : super(key: key);

  @override
  State<ControlPage> createState() => _ControlPageState();
}

class _ControlPageState extends State<ControlPage> {
  @override
  void initState() {
    super.initState();

    _checkVersion();
  }

  @override
  Widget build(BuildContext context) {
    Get.put(() => NetworkViewModel());
    return Obx(() {
      return Get.find<AuthController>().user == null
          ? LoginPage()
          : Get.find<NetworkViewModel>().connectionStatus.value == 1 ||
                  Get.find<NetworkViewModel>().connectionStatus.value == 2
              ? GetBuilder<ControlViewModel>(
                  init: ControlViewModel(),
                  builder: (controller) => Scaffold(
                    body: controller.currentScreen,
                    bottomNavigationBar: const CustomBottomNavigationBar(),
                  ),
                )
              : const NoInternetConnection();
    });
  }

  void _checkVersion() async {
    final newVersion = NewVersion(
        androidId: "com.khanhhoicompany.khn_tracking",
        iOSAppStoreCountry: "vn",
        iOSId: "com.khndev.khnTracking");
    try {
      final status = await newVersion.getVersionStatus();
      if (status!.canUpdate) {
        newVersion.showUpdateDialog(
          context: context,
          versionStatus: status,
          dialogTitle: "UPDATE!!!",
          dismissButtonText: "Skip",
          dialogText:
              "Please update the app from ${status.localVersion} to ${status.storeVersion}",
          dismissAction: () {
            Navigator.pop(context);
          },
          updateButtonText: "Lets update",
        );
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}

class NoInternetConnection extends StatelessWidget {
  const NoInternetConnection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            SizedBox(
              height: 30.h,
            ),
            CustomText(
              text: 'no-internet'.tr,
              fontSize: 14,
              alignment: Alignment.center,
            ),
          ],
        ),
      ),
    );
  }
}
