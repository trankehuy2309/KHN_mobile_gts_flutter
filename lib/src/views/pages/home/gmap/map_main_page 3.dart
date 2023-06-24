// ignore_for_file: file_names
// import 'dart:async';
// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class GMapPage extends StatefulWidget {
//   const GMapPage({Key? key}) : super(key: key);

//   @override
//   _GMapPageState createState() => _GMapPageState();
// }

// class _GMapPageState extends State<GMapPage>
//     with SingleTickerProviderStateMixin {
//   late GoogleMapController mapController;
//   final Set<Polyline> _polylines = {};
//   AnimationController? _animationController;
//   late Animation<double> _animation;
//   late String _routeJson;
//   late Timer _timer;
//   List<dynamic>? polylinePoints;
//   List<LatLng> polyline = <LatLng>[];

//   @override
//   void initState() {
//     // TODO: implement initState
//     _routeJson = 'assets/london_to_british.json';
//     _animationController = AnimationController(
//       duration: const Duration(seconds: 13),
//       vsync: this,
//     );

//     _animation = CurvedAnimation(
//       parent: _animationController!,
//       curve: Curves.easeInOut,
//     );
//     super.initState();
//   }

//   // void SetT() {
//   //   int i = 0;
//   //   _timer = Timer.periodic(new Duration(seconds: 1), (timer) {
//   //     polyline.add(LatLng(polylinePoints![i][1], polylinePoints![i][0]));

//   //     setState(() {
//   //       _polylines.add(Polyline(
//   //           width: 2, // set the width of the polylines
//   //           polylineId: PolylineId("poly"),
//   //           color: Color.fromARGB(255, 40, 122, 198),
//   //           points: polyline));
//   //     });

//   //     // debugPrint(polyline.toString());
//   //     i++;
//   //   });
//   // }

//   void AnimationLine(int _time) {
//     setState(() {
//       polyline.clear();
//     });
//     int s = (_time * 1000 / polylinePoints!.length).round();
//     int i = 0;

//     _timer = Timer.periodic(new Duration(milliseconds: s), (timer) {
//       polyline.add(LatLng(polylinePoints![i][1], polylinePoints![i][0]));

//       setState(() {
//         _polylines.add(Polyline(
//             width: 2, // set the width of the polylines
//             polylineId: PolylineId("poly"),
//             color: Color.fromARGB(255, 40, 122, 198),
//             points: polyline));
//       });

//       // debugPrint(polyline.toString());
//       i++;
//     });
//     Future.delayed(Duration(seconds: _time), () {
//       _timer.cancel();
//     });
//   }

//   Future<dynamic> getJsonData() async {
//     final String data = await rootBundle.loadString(_routeJson);
//     final dynamic jsonData = json.decode(data);
//     polylinePoints =
//         jsonData['features'][0]['geometry']['coordinates'] as List<dynamic>;
//     _animationController?.forward(from: 0);
//   }

//   @override
//   void dispose() {
//     _animationController?.dispose();
//     _animationController = null;
//     // _mapController?.dispose();
//     // _mapController = null;
//     // _routes.clear();
//     _timer.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<dynamic>(
//         future: getJsonData(),
//         builder: (context, snapshot) {
//           return Scaffold(
//             body: GoogleMap(
//               initialCameraPosition: const CameraPosition(
//                   target: LatLng(51.470012, -0.45418), zoom: 10),
//               myLocationEnabled: true,
//               tiltGesturesEnabled: true,
//               compassEnabled: true,
//               scrollGesturesEnabled: true,
//               zoomGesturesEnabled: true,
//               onMapCreated: _onMapCreated,
//               polylines: Set<Polyline>.of(_polylines),
//             ),
//             floatingActionButton: FloatingActionButton(
//               onPressed: () {
//                 // Add your onPressed code here!
//                 AnimationLine(40);
//               },
//               child: const Icon(Icons.navigation),
//               backgroundColor: Colors.green,
//             ),
//           );
//         });
//   }

//   void _onMapCreated(GoogleMapController controller) async {
//     mapController = controller;
//   }
// }
