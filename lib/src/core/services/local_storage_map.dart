import 'package:shared_preferences/shared_preferences.dart';

const String prefMapName = "MapName";

setMap(String mapName) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(prefMapName, mapName);
}

Future<String> getMap() async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  String mapName = _prefs.getString(prefMapName) ?? "Map4D";
  return mapName;
}
