import 'package:flutter/material.dart';
import 'package:khn_tracking/src/core/services/local_storage_map.dart';

import 'gmap/map_demo.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget? page = const GMapPage();

  Future<void> getPage() async {
    String mName = await getMap();
    switch (mName) {
      case 'Map4D':
        page = const GMapPage();
        break;
      case 'OpenStreetMap':
        page = const GMapPage();
        break;
      case 'GoogleMap':
        page = const GMapPage();
        break;
      default:
        page = const GMapPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
        future: getPage(),
        builder: (context, snapshot) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            // endDrawer: const EndDrawHome(),
            body: page!,
          );
        });
  }
}
