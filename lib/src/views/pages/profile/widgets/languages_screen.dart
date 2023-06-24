import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khn_tracking/src/core/services/local_storage_locale.dart';
import 'package:settings_ui/settings_ui.dart';

class LanguagesScreen extends StatefulWidget {
  const LanguagesScreen({Key? key}) : super(key: key);

  @override
  _LanguagesScreenState createState() => _LanguagesScreenState();
}

class _LanguagesScreenState extends State<LanguagesScreen> {
  final locales = [
    {'name': 'Vietnamese', 'locale': const Locale('vi', 'VN')},
    {'name': 'English', 'locale': const Locale('en', 'US')},
  ];
  int languageIndex = 0;

  Future<void> asyncGetLangIndex() async {
    Locale? locale;
    locale = await getLocale();
    if (locale.toString() == 'vi_VN') {
      languageIndex = 0;
    } else {
      languageIndex = 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
        future: asyncGetLangIndex(),
        builder: (context, snapshot) {
          return Scaffold(
            appBar: AppBar(title: Text('language'.tr)),
            body: SettingsList(
              sections: [
                SettingsSection(tiles: [
                  SettingsTile(
                    title: const Text("Tiếng Việt"),
                    trailing: trailingWidget(0),
                    onPressed: (BuildContext context) {
                      changeLanguage(0, locales[0]['locale'] as Locale);
                    },
                  ),
                  SettingsTile(
                    title: const Text("English"),
                    trailing: trailingWidget(1),
                    onPressed: (BuildContext context) {
                      changeLanguage(1, locales[1]['locale'] as Locale);
                    },
                  ),
                ]),
              ],
            ),
          );
        });
  }

  Widget trailingWidget(int index) {
    return (languageIndex == index)
        ? const Icon(Icons.check, color: Colors.blue)
        : const Icon(null);
  }

  void changeLanguage(int index, Locale locale) {
    setState(() {
      languageIndex = index;
      setLocale(locale.languageCode, locale.countryCode!);
      Get.updateLocale(locale);
    });
  }
}
