import 'package:shared_preferences/shared_preferences.dart';

setScreenStart(bool value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool('screenstart', value);
}

Future<bool> getScreenStart() async {
  try {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    bool setScreen = _prefs.getBool('screenstart') ?? true;
    return setScreen;
  } catch (e) {
    return true;
  }
}
