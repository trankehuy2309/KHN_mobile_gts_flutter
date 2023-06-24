import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_utils/google_maps_utils.dart';
import 'package:khn_tracking/src/core/repositories/report_api.dart';
import 'package:khn_tracking/src/helper/default.dart';
import 'package:khn_tracking/src/models/device_model.dart';
import 'package:khn_tracking/src/models/report_distance.dart';
import 'package:khn_tracking/src/models/report_model.dart';

import '_controller.dart';

class ReportController extends GetxController {
  final deviceController = Get.find<DeviceController>();

  // maps
  double zoomCurrent = 14.0;
  List<Marker> currentMarkers = [];
  List<BitmapDescriptor> markerIcon = [];
  late BitmapDescriptor markerStage;
  late GoogleMap _map;
  GoogleMap get map => _map;
  late CameraPosition _position;
  CameraPosition get position => _position;
  String pathPause = 'assets/icons/parking_red.png';

  late final Map<PolylineId, Polyline> _polylines = <PolylineId, Polyline>{};
  Map<PolylineId, Polyline> get polylines => _polylines;

  bool _loading = false;
  bool _loadingMap = false;
  DateTime? _start, _end;
  late int _deviceId;
  String? _vehicalNumber;

  bool get loading => _loading;
  bool get loadingMap => _loadingMap;
  DateTime? get start => _start;
  DateTime? get end => _end;
  int get deviceId => _deviceId;
  String get vehicleNumber => _vehicalNumber!;
  final double _totalDistance = 0;
  double get totalDistance => _totalDistance;

  List<ReportImageModel> _listImages = [];
  List<ReportImageModel> get listImages => _listImages;

  late ReportModel? _report;
  ReportModel? get report => _report;

  final List<DeviceStageModel> _listDatas = [];
  List<DeviceStageModel> get listDatas => _listDatas;
  @override
  void onInit() {
    super.onInit();
    var value = deviceController.deviceStage;
    _position = CameraPosition(
        target: LatLng(value!.latitude, value.longitude), zoom: 12);
    setCustomMapPin();
  }

  @override
  void onReady() {
    debugPrint('ReportController onReady');
    super.onReady();
  }

  @override
  void onClose() {
    debugPrint('ReportController onClose');
    super.onClose();
  }

  void setCustomMapPin() async {
    _loading = true;
    await setIconMarker();
    await setIconStage();
    var value = deviceController.deviceStage!;
    Point from = Point(value.latitude_last!, value.longitude_last!);
    Point to = Point(value.latitude, value.longitude);
    double angle = SphericalUtils.computeHeading(from, to);
    addMarker(value.latitude, value.longitude,
        MarkerId(value.deviceID.toString()), markerIcon[value.state], angle);
    setMap();
    interval();
    _loading = false;
    update();
  }

  addMarker(double latitude, double longitude, MarkerId id,
      BitmapDescriptor icon, double? angle) {
    currentMarkers.add(
      Marker(
          markerId: id,
          draggable: false,
          icon: icon,
          // icon: markerIcon[value.state],
          // infoWindow: InfoWindow(title: value.vehicleNumber),
          position: LatLng(latitude, longitude),
          rotation: angle ?? 0,
          onTap: () {}),
    );
  }

  Future<void> setIconMarker() async {
    for (var item in CAR_MARKER) {
      await getBytesFromAsset(item["mapIcon"]!, 35).then((onValue) {
        markerIcon.add(BitmapDescriptor.fromBytes(onValue));
      });
    }
  }

  Future<void> setIconStage() async {
    await getBytesFromAsset(pathPause, 70).then((onValue) {
      markerStage = BitmapDescriptor.fromBytes(onValue);
    });
  }

  void setMap() {
    var value = deviceController.deviceStage;

    _map = GoogleMap(
      initialCameraPosition: CameraPosition(
          target: LatLng(value!.latitude, value.longitude), zoom: 18.0),
      markers: Set.from(currentMarkers),
      polylines: Set<Polyline>.of(polylines.values),
      onMapCreated: mapCreated,
      onCameraMove: onGeoChanged,
    );
  }

  void toggleSearchSuss() {
    _loading = !_loading;
    update();
  }

  void mapCreated(controller) {
    var value = deviceController.deviceStage;
    CameraPosition(target: LatLng(value!.latitude, value.longitude), zoom: 18);
    // CameraPosition _position = CameraPosition(
    //     target: LatLng(value!.latitude, value.longitude), zoom: 18);
    // getJsonFile('assets/files/map_style.json').then(setMapStyle);
    update();
  }

  void onGeoChanged(CameraPosition position) {
    zoomCurrent = position.zoom;
    update();
  }

  void interval() {}

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    Codec codec = await instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  Future<void> getListReportHistory(int deviceId, int type) async {
    switch (type) {
      case 0:
        {
          _end = DateTime.now();
          _start = _end!.subtract(const Duration(hours: 1));
          await getData(deviceId, _start!, _end!);
          break;
        }
      case 1:
        {
          _end = DateTime.now();
          _start = _end!.subtract(const Duration(hours: 8));
          await getData(deviceId, _start!, _end!);
          break;
        }
      case 2:
        {
          _end = DateTime.now();
          _start = DateTime(_end!.year, _end!.month, _end!.day, 0, 0);
          await getData(deviceId, _start!, _end!);
          break;
        }
      case 3:
        {
          // _end = DateTime.now();
          // _start = _end!.subtract(const Duration(days: 1));
          await getData(deviceId, _start!, _end!);
          break;
        }
    }
    update();
  }

  void changeTime1Day() {
    _start = _end!.subtract(const Duration(days: 1));
  }

  Future<void> getData(int deviceId, DateTime _start, DateTime _end) async {
    _loadingMap = true;
    Future.delayed(const Duration(milliseconds: 20), () {
      update();
    });

    try {
      await ReportAPI.getHistoryDevice(deviceId, _start, _end).then((res) {
        // debugPrint(res.toString());

        _report = ReportModel.fromJson(res);
      });
      await refeshMap(deviceId);
    } catch (e) {
      debugPrint(e.toString());
    }
    _loadingMap = false;
    update();
  }

  Future<void> refeshMap(int deviceId) async {
    currentMarkers = [];
    List<LatLng> latlng = [];
    bool addM = true;
    for (var i = 1; i < _report!.listData!.length - 1; i++) {
      if (_report!.listData![i].speed == 0.0) {
        var elm = _report!.listData![i - 1];

        if (elm.speed == 0.0 && addM) {
          addMarker(
              _report!.listData![i].latitude,
              _report!.listData![i].longitude,
              MarkerId('pause-' + i.toString() + deviceId.toString()),
              markerStage,
              0);
          addM = false;
        } else {
          addM = true;
        }
      }
      LatLng _new = LatLng(
          _report!.listData![i].latitude, _report!.listData![i].longitude);
      latlng.add(_new);
    }

    addMarker(_report!.listData![0].latitude, _report!.listData![0].longitude,
        MarkerId('start' + deviceId.toString()), markerIcon[4], 0);
    addMarker(
        _report!.listData!.last.latitude,
        _report!.listData!.last.longitude,
        MarkerId('end' + deviceId.toString()),
        markerIcon[4],
        0);

    final Polyline polyline = Polyline(
      polylineId: PolylineId(deviceId.toString()),
      visible: true,
      width: 3,
      color: Colors.blue,
      //latlng is List<LatLng>
      points: latlng,
      onTap: () {},
    );
    final PolylineId polylineId = PolylineId(deviceId.toString());
    polylines[polylineId] = polyline;
  }

  Future<void> getListImageFromTo(
      int deviceId, int? page, int? limit, DateTime? from, DateTime? to) async {
    _loading = true;
    Future.delayed(const Duration(milliseconds: 20), () {
      update();
    });
    try {
      await ReportAPI.getListImageFromTo(deviceId, page, limit, from, to)
          .then((res) {
        _listImages = List<ReportImageModel>.from(
            res.map((e) => ReportImageModel.fromJson(e)).toList());
      });
    } catch (e) {
      debugPrint(e.toString());
    }
    _loading = false;
    update();
  }

  void setDateTime(DateTime dt, int type) {
    //type 0: start - 1: end
    switch (type) {
      case 0:
        _start = dt;
        break;
      case 1:
        _end = dt;
        break;
    }
    update();
  }

  List<DataModel> getDataReportHistory() {
    List<DataModel> data = [];
    if (_report != null) {
      List<DataModel>? listDatas = _report!.listData;
      data.add(listDatas![0]);
      for (var i = 1; i < listDatas.length - 1; i++) {
        if (listDatas[i].speed == 0.0) {
          var elm = listDatas[i - 1];
          if (elm.speed == 0.0) {
            continue;
          } else {
            data.add(listDatas[i]);
          }
        } else {
          data.add(listDatas[i]);
        }
      }
    }
    return data;
  }
}
