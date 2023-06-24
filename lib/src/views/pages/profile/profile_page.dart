import 'package:get/get.dart';
import 'package:khn_tracking/src/core/controllers/_controller.dart';
import 'package:khn_tracking/src/core/controllers/user_controller.dart';
import 'package:khn_tracking/src/core/services/local_storage_locale.dart';

import 'package:flutter/material.dart';
import 'package:khn_tracking/src/core/services/local_storage_map.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:url_launcher/url_launcher.dart';

import 'widgets/accout_change_password.dart';
import 'widgets/languages_screen.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool lockInBackground = false;
  bool notificationsEnabled = false;
  final locales = [
    {'name': 'English', 'locale': const Locale('en', 'US')},
    {'name': 'Vietnamese', 'locale': const Locale('vi', 'VN')},
  ];
  late String lang = '', mapName = '';
  Future<void> asyncGetLangIndex() async {
    mapName = await getMap();
    Locale? locale = await getLocale();
    List rs = locales.where((element) => element['locale'] == locale).toList();
    lang = rs[0]['name'];
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
        future: asyncGetLangIndex(),
        builder: (context, snapshot) {
          return Scaffold(
            appBar: AppBar(title: Text('setting'.tr), centerTitle: true),
            body: buildSettingsList(),
            floatingActionButton: Padding(
              padding: const EdgeInsets.only(bottom: 30.0),
              child: FloatingActionButton(
                onPressed: () {
                  launch('tel://' + 'phone-call'.tr);
                  // Add your onPressed code here!
                },
                backgroundColor: const Color(0XFF008e76),
                child: const Icon(Icons.support_agent, color: Colors.white),
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.miniEndFloat,
          );
        });
  }

  Widget buildSettingsList() {
    return Obx(() {
      Get.put(UserController());
      return SettingsList(
        contentPadding: const EdgeInsets.fromLTRB(8, 16, 8, 16),
        sections: [
          SettingsSection(
            title: Text('account'.tr),
            tiles: [
              SettingsTile(
                  title: Text(Get.find<UserController>().user ?? ""),
                  description: Text('username'.tr),
                  leading: const Icon(Icons.person)),
              SettingsTile(
                title: Text('password-change'.tr),
                leading: const Icon(Icons.password),
                onPressed: (context) {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => const ChangePassScreen(),
                  ));
                },
              ),
              SettingsTile(
                  title: Text('signOut'.tr),
                  leading: const Icon(Icons.exit_to_app),
                  onPressed: (context) {
                    Get.find<AuthController>().signOut();
                  }),
            ],
          ),
          SettingsSection(
            title: Text('common'.tr),
            tiles: [
              SettingsTile(
                title: Text('language'.tr),
                description: Text(lang),
                leading: const Icon(Icons.language),
                onPressed: (context) {
                  // Get.to((context) => LanguagesScreen);
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => const LanguagesScreen(),
                  ));
                },
              ),
              SettingsTile(
                title: Text('map'.tr),
                description: const Text('Google Map'),
                leading: const Icon(Icons.cloud_queue),
                onPressed: (context) {
                  // Get.to((context) => LanguagesScreen);
                  // Navigator.of(context).push(MaterialPageRoute(
                  //   builder: (_) => const MapTypePage(),
                  // ));
                },
              ),
            ],
          ),
          SettingsSection(
            title: Text('security'.tr),
            tiles: [
              SettingsTile.switchTile(
                title: Text('lockAppInBackground'.tr),
                leading: const Icon(Icons.phonelink_lock),
                initialValue: lockInBackground,
                onToggle: (bool value) {
                  setState(() {
                    lockInBackground = value;
                  });
                },
              ),
              SettingsTile.switchTile(
                title: Text('useFingerprint'.tr),
                description:
                    Text('allowApplicationToAccessStoredFingerprint'.tr),
                leading: const Icon(Icons.fingerprint),
                onToggle: (bool value) {
                  Get.snackbar(
                    'Thông báo',
                    'Chức năng đang phát triển',
                    snackPosition: SnackPosition.BOTTOM,
                  );
                },
                initialValue: false,
              ),
              SettingsTile.switchTile(
                title: Text('enableNotifications'.tr),
                enabled: notificationsEnabled,
                leading: const Icon(Icons.notifications_active),
                initialValue: notificationsEnabled,
                onToggle: (value) {
                  setState(() {
                    notificationsEnabled = value;
                  });
                },
              ),
            ],
          ),
          SettingsSection(
            title: Text('misc'.tr),
            tiles: [
              SettingsTile(
                  title: Text('policy'.tr),
                  leading: const Icon(Icons.description)),
              SettingsTile(
                  title: Text('version'.tr + ': 1.0.0'),
                  leading: const Icon(Icons.collections_bookmark)),
            ],
          ),
          SettingsSection(
            tiles: [
              SettingsTile(
                title: Center(
                    child: TextButton(
                        onPressed: () {
                          launch('http://khanhhoi.net');
                        },
                        child: const Text('© Bản quyền thuộc về Khánh Hội'))),
              )
            ],
          ),
        ],
      );
    });
  }
}
