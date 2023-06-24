// import 'dart:convert';

// import 'package:flutter/services.dart';
// import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:flutter/material.dart';
// import 'dart:async';

// import 'package:khn_tracking/src/models/mock/pin_pill_info.dart';
// import 'package:khn_tracking/src/views/widgets/map_pin_pill.dart';

// const double CAMERA_ZOOM = 16;
// const double CAMERA_TILT = 80;
// const double CAMERA_BEARING = 30;
// const LatLng SOURCE_LOCATION = LatLng(42.747932, -71.167889);
// const LatLng DEST_LOCATION = LatLng(37.335685, -122.0605916);

// class GMapPage extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() => GMapPageState();
// }

// class GMapPageState extends State<GMapPage> {
//   Completer<GoogleMapController> _controller = Completer();
//   Set<Marker> _markers = Set<Marker>();
// // for my drawn routes on the map
//   Set<Polyline> _polylines = Set<Polyline>();
//   List<LatLng> polylineCoordinates = [];
//   late PolylinePoints polylinePoints;
//   String googleAPIKey = '<API_KEY>';
// // for my custom marker pins
//   late BitmapDescriptor sourceIcon;
//   late BitmapDescriptor destinationIcon;
// // the user's initial location and current location
// // as it moves
//   late LatLng currentLocation;
// // // a reference to the destination location
//   late LatLng destinationLocation;
// // // wrapper around the location API
// //   Location location;
//   double pinPillPosition = -100;
//   PinInformation currentlySelectedPin = PinInformation(
//       pinPath: '',
//       avatarPath: '',
//       location: LatLng(0, 0),
//       locationName: '',
//       labelColor: Colors.grey);
//   late PinInformation sourcePinInfo;
//   late PinInformation destinationPinInfo;
//   late String _routeJson;
//   late List<dynamic> _polylinePoints;

//   @override
//   void initState() {
//     super.initState();
//     _routeJson = 'assets/london_to_british.json';

//     // create an instance of Location
//     polylinePoints = PolylinePoints();

//     // subscribe to changes in the user's location
//     // by "listening" to the location's onLocationChanged event
//     // location.onLocationChanged().listen((LocationData cLoc) {
//     //   // cLoc contains the lat and long of the
//     //   // current user's position in real time,
//     //   // so we're holding on to it
//     //   currentLocation = cLoc;
//     //   updatePinOnMap();
//     // });
//     // currentLocation = LatLng(_polylinePoints[0][1], _polylinePoints[0][0]);
//     // updatePinOnMap();
//     // // set custom marker pins
//     setSourceAndDestinationIcons();
//     // // set the initial location
//     // setInitialLocation();
//   }

//   void setSourceAndDestinationIcons() async {
//     BitmapDescriptor.fromAssetImage(
//             ImageConfiguration(devicePixelRatio: 2.0), 'assets/driving_pin.png')
//         .then((onValue) {
//       sourceIcon = onValue;
//     });

//     BitmapDescriptor.fromAssetImage(ImageConfiguration(devicePixelRatio: 2.0),
//             'assets/destination_map_marker.png')
//         .then((onValue) {
//       destinationIcon = onValue;
//     });
//   }

//   void setInitialLocation() async {
//     // set the initial location by pulling the user's
//     // current location from the location's getLocation()
//     currentLocation = LatLng(_polylinePoints[0][1], _polylinePoints[0][0]);

//     // hard-coded destination for this example
//     destinationLocation = currentLocation;
//   }

//   Future<dynamic> getJsonData() async {
//     final String data = await rootBundle.loadString(_routeJson);
//     final dynamic jsonData = json.decode(data);
//     _polylinePoints =
//         jsonData['features'][0]['geometry']['coordinates'] as List<dynamic>;

//     currentLocation = LatLng(_polylinePoints[0][1], _polylinePoints[0][0]);
//     updatePinOnMap();
//     // // set custom marker pins
//     // setSourceAndDestinationIcons();
//     // // set the initial location
//     setInitialLocation();
//   }

//   @override
//   Widget build(BuildContext context) {
//     CameraPosition initialCameraPosition = CameraPosition(
//         zoom: CAMERA_ZOOM,
//         tilt: CAMERA_TILT,
//         bearing: CAMERA_BEARING,
//         target: SOURCE_LOCATION);

//     return FutureBuilder<dynamic>(
//         future: getJsonData(),
//         builder: (context, snapshot) {
//           return Scaffold(
//             body: Stack(
//               children: <Widget>[
//                 GoogleMap(
//                     compassEnabled: true,
//                     tiltGesturesEnabled: false,
//                     markers: _markers,
//                     polylines: _polylines,
//                     mapType: MapType.normal,
//                     initialCameraPosition: initialCameraPosition,
//                     onTap: (LatLng loc) {
//                       pinPillPosition = -100;
//                     },
//                     onMapCreated: (GoogleMapController controller) {
//                       // controller.setMapStyle(Utils.mapStyles);
//                       _controller.complete(controller);
//                       // my map has completed being created;
//                       // i'm ready to show the pins on the map
//                       showPinsOnMap();
//                     }),
//                 MapPinPillComponent(
//                     pinPillPosition: pinPillPosition,
//                     currentlySelectedPin: currentlySelectedPin)
//               ],
//             ),
//           );
//         });
//   }

//   void showPinsOnMap() {
//     // get a LatLng for the source location
//     // from the LocationData currentLocation object
//     var pinPosition =
//         LatLng(currentLocation.latitude, currentLocation.longitude);
//     // get a LatLng out of the LocationData object
//     var destPosition =
//         LatLng(destinationLocation.latitude, destinationLocation.longitude);

//     sourcePinInfo = PinInformation(
//         locationName: "Start Location",
//         location: SOURCE_LOCATION,
//         pinPath: "assets/driving_pin.png",
//         avatarPath: "assets/friend1.jpg",
//         labelColor: Colors.blueAccent);

//     destinationPinInfo = PinInformation(
//         locationName: "End Location",
//         location: DEST_LOCATION,
//         pinPath: "assets/destination_map_marker.png",
//         avatarPath: "assets/friend2.jpg",
//         labelColor: Colors.purple);

//     // add the initial source location pin
//     _markers.add(Marker(
//         markerId: MarkerId('sourcePin'),
//         position: pinPosition,
//         onTap: () {
//           setState(() {
//             currentlySelectedPin = sourcePinInfo;
//             pinPillPosition = 0;
//           });
//         },
//         icon: sourceIcon));
//     // destination pin
//     _markers.add(Marker(
//         markerId: MarkerId('destPin'),
//         position: destPosition,
//         onTap: () {
//           setState(() {
//             currentlySelectedPin = destinationPinInfo;
//             pinPillPosition = 0;
//           });
//         },
//         icon: destinationIcon));
//     // set the route lines on the map from source to destination
//     // for more info follow this tutorial
//     setPolylines();
//   }

//   void setPolylines() async {
//     final List<PointLatLng> polyline = <PointLatLng>[];

//     for (int i = 0; i < _polylinePoints.length; i++) {
//       polyline.add(PointLatLng(_polylinePoints[i][1], _polylinePoints[i][0]));
//     }
//     List<PointLatLng> result = polyline;

//     if (result.isNotEmpty) {
//       result.forEach((PointLatLng point) {
//         polylineCoordinates.add(LatLng(point.latitude, point.longitude));
//       });

//       setState(() {
//         _polylines.add(Polyline(
//             width: 2, // set the width of the polylines
//             polylineId: PolylineId("poly"),
//             color: Color.fromARGB(255, 40, 122, 198),
//             points: polylineCoordinates));
//       });
//     }
//   }

//   void updatePinOnMap() async {
//     // create a new CameraPosition instance
//     // every time the location changes, so the camera
//     // follows the pin as it moves with an animation
//     CameraPosition cPosition = CameraPosition(
//       zoom: CAMERA_ZOOM,
//       tilt: CAMERA_TILT,
//       bearing: CAMERA_BEARING,
//       target: LatLng(currentLocation.latitude, currentLocation.longitude),
//     );
//     final GoogleMapController controller = await _controller.future;
//     controller.animateCamera(CameraUpdate.newCameraPosition(cPosition));
//     // do this inside the setState() so Flutter gets notified
//     // that a widget update is due
//     setState(() {
//       // updated position
//       var pinPosition =
//           LatLng(currentLocation.latitude, currentLocation.longitude);

//       sourcePinInfo.location = pinPosition;

//       // the trick is to remove the marker (by id)
//       // and add it again at the updated location
//       _markers.removeWhere((m) => m.markerId.value == 'sourcePin');
//       _markers.add(Marker(
//           markerId: MarkerId('sourcePin'),
//           onTap: () {
//             setState(() {
//               currentlySelectedPin = sourcePinInfo;
//               pinPillPosition = 0;
//             });
//           },
//           position: pinPosition, // updated position
//           icon: sourceIcon));
//     });
//   }
// }

// class Utils {
//   static String mapStyles = '''[
//   {
//     "elementType": "geometry",
//     "stylers": [
//       {
//         "color": "#f5f5f5"
//       }
//     ]
//   },
//   {
//     "elementType": "labels.icon",
//     "stylers": [
//       {
//         "visibility": "off"
//       }
//     ]
//   },
//   {
//     "elementType": "labels.text.fill",
//     "stylers": [
//       {
//         "color": "#616161"
//       }
//     ]
//   },
//   {
//     "elementType": "labels.text.stroke",
//     "stylers": [
//       {
//         "color": "#f5f5f5"
//       }
//     ]
//   },
//   {
//     "featureType": "administrative.land_parcel",
//     "elementType": "labels.text.fill",
//     "stylers": [
//       {
//         "color": "#bdbdbd"
//       }
//     ]
//   },
//   {
//     "featureType": "poi",
//     "elementType": "geometry",
//     "stylers": [
//       {
//         "color": "#eeeeee"
//       }
//     ]
//   },
//   {
//     "featureType": "poi",
//     "elementType": "labels.text.fill",
//     "stylers": [
//       {
//         "color": "#757575"
//       }
//     ]
//   },
//   {
//     "featureType": "poi.park",
//     "elementType": "geometry",
//     "stylers": [
//       {
//         "color": "#e5e5e5"
//       }
//     ]
//   },
//   {
//     "featureType": "poi.park",
//     "elementType": "labels.text.fill",
//     "stylers": [
//       {
//         "color": "#9e9e9e"
//       }
//     ]
//   },
//   {
//     "featureType": "road",
//     "elementType": "geometry",
//     "stylers": [
//       {
//         "color": "#ffffff"
//       }
//     ]
//   },
//   {
//     "featureType": "road.arterial",
//     "elementType": "labels.text.fill",
//     "stylers": [
//       {
//         "color": "#757575"
//       }
//     ]
//   },
//   {
//     "featureType": "road.highway",
//     "elementType": "geometry",
//     "stylers": [
//       {
//         "color": "#dadada"
//       }
//     ]
//   },
//   {
//     "featureType": "road.highway",
//     "elementType": "labels.text.fill",
//     "stylers": [
//       {
//         "color": "#616161"
//       }
//     ]
//   },
//   {
//     "featureType": "road.local",
//     "elementType": "labels.text.fill",
//     "stylers": [
//       {
//         "color": "#9e9e9e"
//       }
//     ]
//   },
//   {
//     "featureType": "transit.line",
//     "elementType": "geometry",
//     "stylers": [
//       {
//         "color": "#e5e5e5"
//       }
//     ]
//   },
//   {
//     "featureType": "transit.station",
//     "elementType": "geometry",
//     "stylers": [
//       {
//         "color": "#eeeeee"
//       }
//     ]
//   },
//   {
//     "featureType": "water",
//     "elementType": "geometry",
//     "stylers": [
//       {
//         "color": "#c9c9c9"
//       }
//     ]
//   },
//   {
//     "featureType": "water",
//     "elementType": "labels.text.fill",
//     "stylers": [
//       {
//         "color": "#9e9e9e"
//       }
//     ]
//   }
// ]''';
// }
