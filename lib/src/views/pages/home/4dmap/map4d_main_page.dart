import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:map4d_map/map4d_map.dart';
import 'package:khn_tracking/src/core/controllers/device_controller_old.dart';
import 'package:khn_tracking/src/views/pages/home/widgets/_widget.dart';

class DMapPage extends StatelessWidget {
  const DMapPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => DeviceController());

    return GetBuilder<DeviceController>(
      init: Get.find<DeviceController>(),
      builder: (controller) => controller.loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : GestureDetector(
              onTap: () {
                FocusScopeNode currentFocus = FocusScope.of(context);
                if (!currentFocus.hasPrimaryFocus &&
                    currentFocus.focusedChild != null) {
                  FocusManager.instance.primaryFocus!.unfocus();
                }
              },
              child: Stack(children: <Widget>[
                controller.isSearch
                    ? const SearchDevice()
                    : GestureDetector(
                        onTap: () {
                          FocusScopeNode currentFocus = FocusScope.of(context);
                          if (!currentFocus.hasPrimaryFocus &&
                              currentFocus.focusedChild != null) {
                            FocusManager.instance.primaryFocus!.unfocus();
                          }
                        },
                        child: MFMapView(
                          initialCameraPosition: controller.position,
                          mapType: MFMapType.roadmap,
                          onMapCreated: controller.onMapCreated,
                          onCameraMoveStarted: controller.onCameraMoveStarted,
                          onCameraMove: controller.onCameraMove,
                          onCameraIdle: controller.onCameraIdle,
                          // myLocationEnabled: true,
                          // myLocationButtonEnabled: true,
                          onTap: controller.onTap,
                          markers: Set<MFMarker>.of(controller.markers.values),
                        ),
                      ),
                const TopBarWidget(),
                const PanelMapWidget(),
              ]),
            ),
    );
  }
}

// class DMapPage extends StatefulWidget {
//   const DMapPage({Key? key}) : super(key: key);

//   @override
//   _DMapPageState createState() => _DMapPageState();
// }

// class _DMapPageState extends State<DMapPage> {
//   Completer<MFMapViewController> _controller = Completer();
//   bool _is3dMode = false;

//   static final MFLatLng _kLandmark81 =
//       MFLatLng(10.794630856464138, 106.72229460050636);
//   static final MFCameraPosition _kInitialCameraPosition =
//       MFCameraPosition(target: _kLandmark81, zoom: 16);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: MFMapView(
//         initialCameraPosition: _kInitialCameraPosition,
//         onMapCreated: (MFMapViewController controller) {
//           _controller.complete(controller);
//         },
//         onPOITap: _onPOITap,
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _switch3dMode,
//         tooltip: '3D Mode',
//         child: Icon(Icons.threed_rotation),
//       ),
//     );
//   }

//   void _onPOITap(String placeId, String name, MFLatLng location) {
//     print('Tap on place: $placeId, name: $name, location: $location');
//   }

//   void _switch3dMode() async {
//     final MFMapViewController controller = await _controller.future;
//     _is3dMode = !_is3dMode;
//     controller.enable3DMode(_is3dMode);
//   }
// }
