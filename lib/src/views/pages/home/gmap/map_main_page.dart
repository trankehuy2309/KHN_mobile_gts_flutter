// import 'package:flutter/material.dart';
// import 'package:google_maps_widget/google_maps_widget.dart';

// class GMapPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: SafeArea(
//         child: Scaffold(
//           body: GoogleMapsWidget(
//             apiKey: "AIzaSyDlvHFIM7BBsIWb6kbNq5fcY4Cv0sLW3Qk",
//             sourceLatLng: LatLng(40.484000837597925, -3.369978368282318),
//             destinationLatLng: LatLng(40.48017307700204, -3.3618026599287987),

//             ///////////////////////////////////////////////////////
//             //////////////    OPTIONAL PARAMETERS    //////////////
//             ///////////////////////////////////////////////////////

//             routeWidth: 2,
//             sourceMarkerIconInfo: MarkerIconInfo(
//               assetPath: "assets/driving_pin.png",
//             ),
//             destinationMarkerIconInfo: MarkerIconInfo(
//               assetPath: "assets/destination_map_marker.png",
//             ),
//             driverMarkerIconInfo: MarkerIconInfo(
//               assetPath: "assets/destination_map_marker.png",
//               assetMarkerSize: Size.square(125),
//             ),
//             // mock stream
//             driverCoordinatesStream: Stream.periodic(
//               Duration(milliseconds: 500),
//               (i) => LatLng(
//                 40.47747872288886 + i / 10000,
//                 -3.368043154478073 - i / 10000,
//               ),
//             ),
//             sourceName: "This is source name",
//             driverName: "Alex",
//             onTapDriverMarker: (currentLocation) {
//               print("Driver is currently at $currentLocation");
//             },
//             totalTimeCallback: (time) => print(time),
//             totalDistanceCallback: (distance) => print(distance),

//             /// and a lot more...
//           ),
//         ),
//       ),
//     );
//   }
// }
