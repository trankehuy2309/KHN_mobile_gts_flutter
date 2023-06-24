// ignore_for_file: unnecessary_new

import 'dart:async';

import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_utils/google_maps_utils.dart';
import 'package:khn_tracking/src/helper/default.dart';
import 'package:khn_tracking/src/models/device_model.dart';

import 'device_controller.dart';

class GMapController extends GetxController {
  late dynamic deviceController;

  bool _loading = false;
  bool get loading => _loading;
  bool _isInterval = true;
  bool get isInterval => _isInterval;
  bool _isSearch = false;
  bool get isSearch => _isSearch;
  String _title = "";
  String get title => _title;
  final List<String> _searchTerms = [];
  List<String> get searchTerms => _searchTerms;

  List<BitmapDescriptor> markerIcon = [];

  Timer? _intervalMap;
  late GoogleMapController _controller;

  int prevPage = 0;
  PageController _pageController =
      PageController(initialPage: 0, viewportFraction: 0.8);
  PageController get pageController => _pageController;
  final position =
      const CameraPosition(target: LatLng(10.7553411, 106.4150405), zoom: 6);
  double zoomCurrent = 14.0;
  List<Marker> allMarkers = [];
  List<Marker> currentMarkers = [];
  int _indexDeviceStage = 0;
  int get indexDeviceStage => _indexDeviceStage;

  @override
  void onInit() {
    super.onInit();
    Get.put(DeviceController());
    deviceController = Get.find<DeviceController>();
    intervalDispose();
    setCustomMapPin();
    _pageController = PageController(initialPage: 0, viewportFraction: 0.8)
      ..addListener(_onScroll);
  }

  @override
  void onClose() {
    intervalDispose();
    super.onClose();
  }

  void setCustomMapPin() async {
    _loading = true;
    await deviceController.getGroupDevice();
    await setIconMarker();
    int countLoad = 0;
    while (deviceController.lDeviceStage == null) {
      if (countLoad >= 20) {
        break;
      }
      countLoad += 1;
      await Future.delayed(const Duration(seconds: 2));
      deviceController.getGroupDevice();
    }
    if (countLoad >= 20) {
      return;
    }

    deviceController.lDeviceStage.asMap().forEach((index, value) {
      Point from = Point(value.latitude_last!, value.longitude_last!);
      Point to = Point(value.latitude, value.longitude);
      double angle = SphericalUtils.computeHeading(from, to);

      // not show deviceexp
      if (value.state != 5) {
        // get position current or position last
        LatLng positionData = value.state != 6
            ? LatLng(value.latitude, value.longitude)
            : LatLng(value.latitude_last!, value.longitude_last!);
        allMarkers.add(
          Marker(
              markerId: MarkerId(value.deviceID.toString()),
              draggable: false,
              icon: markerIcon[value.state],
              // ignore: prefer_const_constructors
              infoWindow: InfoWindow(title: value.vehicleNumber),
              position: positionData,
              rotation: angle,
              onTap: () {
                _title = new Text(
                  value.vehicleNumber,
                  style: const TextStyle(fontSize: 10.0),
                ) as String;
                _onToPage(index);
                moveCamera(positionData);
              }),
        );
      }
    });

    interval();
    _loading = false;
    update();
  }

  Future<void> setIconMarker() async {
    for (var item in CAR_MARKER) {
      await getBytesFromAsset(item["mapIcon"]!, 35).then((onValue) {
        markerIcon.add(BitmapDescriptor.fromBytes(onValue));
      });
    }
  }

  void mapCreated(controller) {
    _controller = controller;
    getJsonFile('assets/files/map_style.json').then(setMapStyle);
    update();
  }

  Future<String> getJsonFile(String path) async {
    return await rootBundle.loadString(path);
  }

  void setMapStyle(String mapStyles) {
    _controller.setMapStyle(mapStyles);
  }

  void onGeoChanged(CameraPosition position) {
    zoomCurrent = position.zoom;
    update();
  }

  moveCamera(LatLng target) {
    zoomCurrent = zoomCurrent.compareTo(14.0) > 0 ? zoomCurrent : 14.0;
    update();
    _controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: target, zoom: zoomCurrent)));
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    Codec codec = await instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  void setIndexDevice(int index) {
    _indexDeviceStage = index;
    update();
  }

  void setSearch(var value) {
    _title = value.vehicleNumber;
    update();
    deviceController.setDeviceState(value);
    int index = deviceController.lDeviceStage
        .toList()
        .indexWhere((item) => item.deviceID == value.deviceID);
    _onToPage(index);
    moveCamera(LatLng(value.latitude, value.longitude));
  }

  //--------------INTERVAL----------------
  void interval() {
    _intervalMap = Timer.periodic(const Duration(seconds: 20), (timer) async {
      if (_isInterval) {
        debugPrint('intervalMap');
        deviceController.lDeviceStage.asMap().forEach((index, value) {
          MarkerId markerId = MarkerId(value.deviceID.toString());

          int indexM = allMarkers
              .toList()
              .indexWhere((item) => item.markerId == markerId);
          Marker _marker = allMarkers[index];
          if (value.state == 5) return;

          Point from = Point(allMarkers[indexM].position.latitude,
              allMarkers[indexM].position.longitude);
          Point to = Point(value.latitude, value.longitude);
          double angle = SphericalUtils.computeHeading(from, to);
          if (angle.compareTo(5.0) > 0 || angle.compareTo(-5.0) < 0) {
            allMarkers[indexM] = _marker.copyWith(
              iconParam: markerIcon[value.state],
              positionParam: LatLng(value.latitude, value.longitude),
              onTapParam: () {
                _title = value.vehicleNumber;
                _onToPage(index);
                moveCamera(LatLng(value.latitude, value.longitude));
              },
              rotationParam: angle,
            );
          } else {
            allMarkers[indexM] = _marker.copyWith(
              iconParam: markerIcon[value.state],
              positionParam: LatLng(value.latitude, value.longitude),
              onTapParam: () {
                _title = value.vehicleNumber;
                _onToPage(index);
                moveCamera(LatLng(value.latitude, value.longitude));
              },
            );
          }
        });
        LatLng positionData =
            deviceController.lDeviceStage[_indexDeviceStage].state != 6
                ? LatLng(
                    deviceController.lDeviceStage[_indexDeviceStage].latitude,
                    deviceController.lDeviceStage[_indexDeviceStage].longitude)
                : LatLng(
                    deviceController
                        .lDeviceStage[_indexDeviceStage].latitude_last!,
                    deviceController
                        .lDeviceStage[_indexDeviceStage].longitude_last!);
        moveCamera(positionData);
        update();
      }
    });
  }

  void setIsInterval(bool value) {
    _isInterval = value;
    update();
  }

  void intervalDispose() {
    if (_intervalMap != null) {
      _intervalMap!.cancel();
    }
  }

  void _onScroll() {
    if (_pageController.page!.toInt() != _indexDeviceStage) {
      _indexDeviceStage = _pageController.page!.toInt();
      DeviceStageModel dvStageCurent =
          Get.find<DeviceController>().lDeviceStage[_indexDeviceStage];
      _title = dvStageCurent.vehicleNumber;
      debugPrint("Vao day");
      _controller.showMarkerInfoWindow(
        MarkerId(dvStageCurent.deviceID.toString()),
      );
      if (dvStageCurent.latitude > 0) {
        moveCamera(LatLng(dvStageCurent.latitude, dvStageCurent.longitude));
      }
    }
    update();
  }

  void _onToPage(index) {
    if (index != _indexDeviceStage) {
      _pageController.animateToPage(index,
          duration: const Duration(milliseconds: 100), curve: Curves.ease);
      _indexDeviceStage = index;
      // moveCamera(LatLng(
      //     Get.find<DeviceController>().lDeviceStage[_indexDeviceStage].latitude,
      //     Get.find<DeviceController>()
      //         .lDeviceStage[_indexDeviceStage]
      //         .longitude));
    }
    update();
  }

  // SEARCH
  void openSearch() {
    _isSearch = true;
    update();
  }

  void closeSearch() {
    _isSearch = false;
    update();
  }
}
