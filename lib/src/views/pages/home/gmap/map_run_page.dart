import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GMapRunPage extends StatefulWidget {
  const GMapRunPage({Key? key}) : super(key: key);

  @override
  _GMapRunPageState createState() => _GMapRunPageState();
}

class _GMapRunPageState extends State<GMapRunPage>
    with SingleTickerProviderStateMixin {
  late GoogleMapController mapController;
  final Set<Polyline> _polylines = {};
  AnimationController? _animationController;
  late String _routeJson;

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    _routeJson = 'assets/london_to_british.json';
    _animationController = AnimationController(
      duration: const Duration(seconds: 13),
      vsync: this,
    );

    super.initState();
  }

  Future<dynamic> getJsonData() async {
    final List<LatLng> polyline = <LatLng>[];
    final String data = await rootBundle.loadString(_routeJson);
    final dynamic jsonData = json.decode(data);
    final List<dynamic> polylinePoints =
        jsonData['features'][0]['geometry']['coordinates'] as List<dynamic>;
    for (int i = 0; i < polylinePoints.length; i++) {
      polyline.add(LatLng(polylinePoints[i][1], polylinePoints[i][0]));
    }
    _animationController?.forward(from: 0);
    // ignore: unawaited_futures
    // _animationController?.forward(from: 0);
    _polylines.add(Polyline(
      polylineId: const PolylineId("line 1"),
      visible: true,
      width: 2,
      // patterns: [PatternItem.dash(30), PatternItem.gap(10)],
      points: polyline,
      // points: MapsCurvedLines.getPointsOnCurve(
      //     _point1, _point2), // Invoke lib to get curved line points
      color: Colors.blue,
    ));
    return polyline;
  }

  @override
  void dispose() {
    _animationController?.dispose();
    _animationController = null;
    // _mapController?.dispose();
    // _mapController = null;
    // _routes.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
        future: getJsonData(),
        builder: (context, snapshot) {
          return Scaffold(
            body: GoogleMap(
              initialCameraPosition: const CameraPosition(
                  target: LatLng(51.470012, -0.45418), zoom: 10),
              myLocationEnabled: true,
              tiltGesturesEnabled: true,
              compassEnabled: true,
              scrollGesturesEnabled: true,
              zoomGesturesEnabled: true,
              onMapCreated: _onMapCreated,
              polylines: Set<Polyline>.of(_polylines),
            ),
          );
        });
  }

  void _onMapCreated(GoogleMapController controller) async {
    mapController = controller;
  }
}
