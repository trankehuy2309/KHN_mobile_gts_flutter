//import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:khn_tracking/src/core/controllers/device_controller.dart';
import 'package:khn_tracking/src/core/controllers/gmap_controller.dart';
import 'package:khn_tracking/src/helper/ulti.dart';
import 'package:khn_tracking/src/models/device_model.dart';

class GMapPage extends StatefulWidget {
  const GMapPage({Key? key}) : super(key: key);

  @override
  _GMapPageState createState() => _GMapPageState();
}

class _GMapPageState extends State<GMapPage> {
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => GMapController());

    return GetBuilder<GMapController>(
      init: Get.find<GMapController>(),
      builder: (controller) => Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              controller.openSearch();
              showSearch(
                context: context,
                delegate: CustomSearchDelegate(),
              );
            },
            icon: const Icon(Icons.search),
          ),
          actions: const <Widget>[
            // PopupMenuButton(
            //   itemBuilder: (context) => controller.listDGroup
            //       .map(
            //         (e) => PopupMenuItem(
            //           child: Text("${e.vehicleGroup} (${e.countdv})"),
            //           value: controller.listDGroup.indexOf(e),
            //           onTap: () {
            //             controller.closeSearch();

            //             controller.changeCurrentGroup(e.vehicleGroupID);
            //           },
            //         ),
            //       )
            //       .toList(),
            // ),
          ],
          title: Text(
              (controller.title == "" ? 'list-car'.tr : controller.title)
                  .toUpperCase()),
          centerTitle: true,
        ),
        body: controller.loading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Stack(
                children: <Widget>[
                  SizedBox(
                    height: MediaQuery.of(context).size.height - 50.0,
                    width: MediaQuery.of(context).size.width,
                    child: GoogleMap(
                      initialCameraPosition: controller.position,
                      markers: Set.from(controller.allMarkers),
                      onMapCreated: controller.mapCreated,
                      onCameraMove: controller.onGeoChanged,
                    ),
                  ),
                  // Positioned(
                  //   right: 12,
                  //   top: 20,
                  //   child: Column(
                  //     children: [
                  //       Container(
                  //         decoration: BoxDecoration(
                  //           color: Colors.white,
                  //           borderRadius: BorderRadius.circular(10),
                  //           boxShadow: [
                  //             BoxShadow(
                  //               color: Colors.grey.withOpacity(0.5),
                  //               spreadRadius: 5,
                  //               blurRadius: 7,
                  //               offset: const Offset(
                  //                   0, 3), // changes position of shadow
                  //             ),
                  //           ],
                  //         ),
                  //         child: IconButton(
                  //           padding: const EdgeInsets.all(8),
                  //           icon: Image.asset('assets/themes/icons/layers.png',
                  //               width: 30),
                  //           onPressed: () {},
                  //         ),
                  //       ),
                  //       SizedBox(height: 12),
                  //       Container(
                  //         decoration: BoxDecoration(
                  //           color: Colors.white,
                  //           borderRadius: BorderRadius.circular(10),
                  //           boxShadow: [
                  //             BoxShadow(
                  //               color: Colors.grey.withOpacity(0.5),
                  //               spreadRadius: 5,
                  //               blurRadius: 7,
                  //               offset: const Offset(
                  //                   0, 3), // changes position of shadow
                  //             ),
                  //           ],
                  //         ),
                  //         child: IconButton(
                  //           padding: const EdgeInsets.all(8),
                  //           icon: Image.asset(
                  //               'assets/themes/icons/point-objects.png',
                  //               width: 30),
                  //           onPressed: () {},
                  //         ),
                  //       ),
                  //       SizedBox(height: 12),
                  //       Container(
                  //         decoration: BoxDecoration(
                  //           color: Colors.white,
                  //           borderRadius: BorderRadius.circular(10),
                  //           boxShadow: [
                  //             BoxShadow(
                  //               color: Colors.grey.withOpacity(0.5),
                  //               spreadRadius: 5,
                  //               blurRadius: 7,
                  //               offset: const Offset(
                  //                   0, 3), // changes position of shadow
                  //             ),
                  //           ],
                  //         ),
                  //         child: IconButton(
                  //           padding: const EdgeInsets.all(8),
                  //           icon: Image.asset(
                  //               'assets/themes/icons/dome-camera.png',
                  //               width: 30),
                  //           onPressed: () {},
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  Positioned(
                    bottom: 20.0,
                    child: SizedBox(
                      height: 150.0,
                      width: MediaQuery.of(context).size.width,
                      child: PageView.builder(
                        controller: controller.pageController,
                        itemCount:
                            Get.find<DeviceController>().lDeviceStage.length,
                        itemBuilder: (BuildContext context, int index) {
                          return _deviceList(index);
                        },
                      ),
                    ),
                  )
                ],
              ),
      ),
    );
  }

  _deviceList(index) {
    final DeviceStageModel device =
        Get.find<DeviceController>().lDeviceStage[index];

    return GetBuilder<GMapController>(
      init: Get.find<GMapController>(),
      builder: (controller) => AnimatedBuilder(
        animation: controller.pageController,
        builder: (BuildContext context, Widget? widget) {
          double value = 1;
          if (controller.pageController.position.haveDimensions) {
            value = (controller.pageController.page! - index);
            value = (1 - (value.abs() * 0.3) + 0.06).clamp(0.0, 1.0);
          }
          return Center(
            child: SizedBox(
              height: Curves.easeInOut.transform(value) * 155.0,
              width: Curves.easeInOut.transform(value) * 350.0,
              child: widget,
            ),
          );
        },
        child: InkWell(
          onTap: () {
            Get.find<GMapController>()
                .setIndexDevice(controller.pageController.page!.toInt());
            //LatLng latlg= new LatLng(latitude, longitude)
            double? latBase = Get.find<DeviceController>()
                .lDeviceStage[controller.pageController.page!.toInt()]
                .latitude;

            double? longBase = Get.find<DeviceController>()
                .lDeviceStage[controller.pageController.page!.toInt()]
                .longitude;

            LatLng positionData = LatLng(latBase, longBase);
            //debugPrint("Vao day");
            // if (lat_ > 0) {
            Get.find<GMapController>().moveCamera(positionData);
            //}
          },
          child: Stack(
            children: [
              Center(
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 20.0,
                  ),
                  height: 130.0,
                  width: 275.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black54,
                          offset: Offset(0.0, 4.0),
                          blurRadius: 10.0,
                        ),
                      ]),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 7.0, horizontal: 15.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          device.vehicleNumber,
                          style: TextStyle(
                              fontSize: 12.5,
                              fontWeight: FontWeight.bold,
                              color: statusColor(device.state)),
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                device.stateStr
                                    .toString()
                                    .replaceAll(RegExp('\r\n'), ''),
                                style: const TextStyle(fontSize: 10.0),
                              ),
                              Text(
                                timeToString(device.dateSave).toString(),
                                style: const TextStyle(fontSize: 10.0),
                              ),
                            ]),
                        Text(
                          device.addr! == 'khong xac dinh'
                              ? (device.latitude.toString() +
                                  "," +
                                  device.longitude.toString())
                              : (device.addr! != ""
                                  ? device.addr!
                                  : device.latitude.toString() +
                                      "," +
                                      device.longitude.toString()),
                          // '184/1 Nguyễn Văn Khối, Phường 9, Q Gò Vấp, Tp Hồ Chí Minh ',
                          style: const TextStyle(fontSize: 10.0),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // ignore: prefer_const_constructors
                              Text(
                                (device.StatusExt!),
                                style: const TextStyle(fontSize: 10.0),
                              ),
                            ]),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  List<String> searchTerms = Get.find<GMapController>().searchTerms;
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        Get.find<GMapController>().closeSearch();
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    debugPrint('buildResults');
    List<DeviceStageModel> matchQuery = [];
    List<DeviceStageModel> listDvStage =
        Get.find<DeviceController>().lDeviceStage;
    for (var item2 in listDvStage) {
      if (item2.vehicleNumber.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(item2);
      }
    }
    if (matchQuery.isEmpty) {
      return const Center(child: Text('Không tìm thấy thông tin xe...'));
    }

    return ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (context, index) {
          var result = matchQuery[index];
          // return SearchItemWiget(
          //   value: result,
          //   fnClose: () {
          //     close(context, null);
          //   },
          // );
          return Card(
            child: InkWell(
              onTap: () {
                Get.find<GMapController>().setSearch(result);
                close(context, null);
              },
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    CircleAvatar(
                        child: const Icon(Icons.directions_car,
                            color: Colors.white),
                        backgroundColor: statusColor(result.state)),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      height: 40,
                      width: 2,
                      color: statusColor(result.state),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      result.vehicleNumber,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: statusColor(result.state)),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    debugPrint('buildSuggestions');
    List<DeviceStageModel> matchQuery = [];
    List<DeviceStageModel> listDvStage =
        Get.find<DeviceController>().lDeviceStage;
    for (var item2 in listDvStage) {
      if (item2.vehicleNumber.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(item2);
      }
    }
    if (matchQuery.isEmpty) {
      return const Center(child: Text('Không tìm thấy thông tin xe...'));
    } else {
      return ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (context, index) {
          var result = matchQuery[index];
          // return SearchItemWiget(
          //   value: result,
          //   fnClose: () {
          //     close(context, null);
          //   },
          // );
          return Card(
            child: InkWell(
              onTap: () {
                Get.find<GMapController>().setSearch(result);
                close(context, null);
              },
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    CircleAvatar(
                        child: const Icon(Icons.directions_car,
                            color: Colors.white),
                        backgroundColor: statusColor(result.state)),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      height: 40,
                      width: 2,
                      color: statusColor(result.state),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      result.vehicleNumber,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: statusColor(result.state)),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    }
  }
}

class SearchItemWiget extends StatelessWidget {
  SearchItemWiget({Key? key, required this.value, required this.fnClose})
      : super(key: key);
  var value;
  VoidCallback fnClose;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          Get.find<GMapController>().setSearch(value);
          fnClose;
        },
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              CircleAvatar(
                  child: const Icon(Icons.directions_car, color: Colors.white),
                  backgroundColor: statusColor(value.state)),
              const SizedBox(
                width: 10,
              ),
              Container(
                height: 40,
                width: 2,
                color: statusColor(value.state),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                value.vehicleNumber,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: statusColor(value.state)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
