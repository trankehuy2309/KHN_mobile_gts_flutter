import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khn_tracking/src/core/controllers/page_controller.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: GetBuilder<ControlViewModel>(
        builder: (controller) => ConvexAppBar(
            backgroundColor: const Color(0xFF009688),
            initialActiveIndex: controller.navigatorIndex,
            onTap: (index) {
              controller.changeCurrentScreen(index);
            },
            // ignore: prefer_const_literals_to_create_immutables
            items: [
              TabItem(icon: Icons.notifications, title: 'alter'.tr),
              TabItem(icon: Icons.article, title: 'list'.tr),
              TabItem(icon: Icons.map, title: 'home-map'.tr),
              TabItem(icon: Icons.widgets, title: 'report'.tr),
              TabItem(icon: Icons.settings, title: 'setting'.tr),
            ],
            style: TabStyle.titled),
      ),
    );
  }
}
