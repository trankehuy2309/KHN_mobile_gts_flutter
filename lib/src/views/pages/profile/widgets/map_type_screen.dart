import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khn_tracking/src/core/services/local_storage_map.dart';
import 'package:settings_ui/settings_ui.dart';

class MapTypePage extends StatefulWidget {
  const MapTypePage({Key? key}) : super(key: key);

  @override
  _MapTypePageState createState() => _MapTypePageState();
}

class _MapTypePageState extends State<MapTypePage> {
  int mapIndex = 0;
  final mapName = ['Map4D', 'OpenStreetMap', 'GoogleMap'];

  Future<void> asyncGetMapIndex() async {
    String? mName;
    mName = await getMap();
    mapIndex = mapName.indexWhere((element) => element == mName);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
        future: asyncGetMapIndex(),
        builder: (context, snapshot) {
          return Scaffold(
            appBar: AppBar(title: Text('map'.tr)),
            body: SettingsList(
              sections: [
                SettingsSection(tiles: [
                  SettingsTile(
                    title: const Text("Map4D"),
                    trailing: trailingWidget(0),
                    onPressed: (BuildContext context) {
                      changeMapType(0);
                    },
                  ),
                  SettingsTile(
                    title: const Text("OpenStreetMap"),
                    trailing: trailingWidget(1),
                    onPressed: (BuildContext context) {
                      changeMapType(1);
                    },
                  ),
                  SettingsTile(
                    title: const Text("GoogleMap"),
                    trailing: trailingWidget(2),
                    onPressed: (BuildContext context) {
                      changeMapType(2);
                    },
                  ),
                ]),
              ],
            ),
          );
        });
  }

  Widget trailingWidget(int index) {
    return (mapIndex == index)
        ? const Icon(Icons.check, color: Colors.blue)
        : const Icon(null);
  }

  void changeMapType(int index) {
    setState(() {
      mapIndex = index;
      setMap(mapName[index]);
      Get.forceAppUpdate();
    });
  }
}
