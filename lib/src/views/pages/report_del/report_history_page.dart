import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khn_tracking/src/core/controllers/report_controller.dart';
import 'package:khn_tracking/src/views/pages/report_del/widgets/tab_search_widget.dart';

import '../control_page.dart';
import 'widgets/end_draw_widget.dart';
import 'widgets/menu_widget.dart';

class ReportHistoryPage extends StatelessWidget {
  const ReportHistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      endDrawer: const EndDrawReport(),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.delete<ReportController>();
            Get.to(() => const ControlPage());
          },
        ),
        title: const Text('Báo cáo lộ trình'),
        centerTitle: true,
        actions: const [
          PopUpMenuWidget(),
        ],
      ),
      body: Stack(children: [
        Container(),
        // SfMaps(
        //   layers: <MapLayer>[
        //     MapTileLayer(
        //       urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
        //       controller: _mapController,
        //       zoomPanBehavior: _zoomPanBehavior,
        //     ),
        //   ],
        // ),
        const Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: TabSearchWidget(),
        ),
      ]),
    );
  }
}

// class ReportHistoryPage extends StatefulWidget {
//   const ReportHistoryPage({Key? key}) : super(key: key);

//   @override
//   _ReportHistoryPageState createState() => _ReportHistoryPageState();
// }

// class _ReportHistoryPageState extends State<ReportHistoryPage> {
//   MapTileLayerController? _mapController;
//   late MapZoomPanBehavior _zoomPanBehavior;

//   @override
//   void initState() {
//     _mapController = MapTileLayerController();
//     _zoomPanBehavior = MapZoomPanBehavior(
//       minZoomLevel: 3,
//       zoomLevel: 10,
//       focalLatLng: const MapLatLng(51.4700, -0.2843),
//       toolbarSettings: const MapToolbarSettings(
//           direction: Axis.vertical, position: MapToolbarPosition.bottomRight),
//       maxZoomLevel: 15,
//       enableDoubleTapZooming: true,
//     );

//     super.initState();
//   }

//   @override
//   void dispose() {
//     _mapController?.dispose();
//     _mapController = null;
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       endDrawer: const EndDrawReport(),
//       appBar: AppBar(
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () => {Get.to(() => ControlPage())},
//         ),
//         title: Text('Báo cáo lộ trình'),
//         centerTitle: true,
//         actions: [
//           PopUpMenuWidget(),
//         ],
//       ),
//       body: Container(
//         child: Stack(children: [
//           SfMaps(
//             layers: <MapLayer>[
//               MapTileLayer(
//                 urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
//                 controller: _mapController,
//                 zoomPanBehavior: _zoomPanBehavior,
//               ),
//             ],
//           ),
//           Positioned(
//             bottom: 0,
//             left: 0,
//             right: 0,
//             child: TabSearchWidget(),
//           ),
//         ]),
//       ),
//     );
//   }
// }
