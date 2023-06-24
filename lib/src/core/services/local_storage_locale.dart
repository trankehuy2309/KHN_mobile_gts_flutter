import 'dart:ui';

import 'package:shared_preferences/shared_preferences.dart';

const String prefSelectedLanguageCode = "SelectedLanguageCode";
const String prefSelectedCountryCode = "SelectedCountryCode";

setLocale(String languageCode, String countryCode) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(prefSelectedLanguageCode, languageCode);
  prefs.setString(prefSelectedCountryCode, countryCode);
}

Future<Locale> getLocale() async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  String languageCode = _prefs.getString(prefSelectedLanguageCode) ?? "vi";
  String countryCode = _prefs.getString(prefSelectedCountryCode) ?? "VN";
  return _locale(languageCode, countryCode);
}

Locale _locale(String? languageCode, String countryCode) {
  return languageCode != null && languageCode.isNotEmpty
      ? Locale(languageCode, countryCode)
      : const Locale('vi', 'VN');
}
