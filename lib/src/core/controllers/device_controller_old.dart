import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:map4d_map/map4d_map.dart';
import 'package:khn_tracking/src/core/repositories/home_api.dart';
import 'package:khn_tracking/src/models/device_model.dart';

class DeviceController extends GetxController {
  Timer? _intervalData, _intervalCurrentData;
  bool _loading = false;
  bool get loading => _loading;
  bool _isSearch = false;
  bool get isSearch => _isSearch;
  late int _currentGroupID;
  int _currentIndexGroup = 0;
  int get currentGroupID => _currentGroupID;
  int get currentIndexGroup => _currentIndexGroup;
  MFBitmap? _markerIcon;
  double _panelPosition = -120;
  double get panelPosition => _panelPosition;

  final position = const MFCameraPosition(
      bearing: 2.0, target: MFLatLng(10.7553411, 106.4150405), zoom: 6);

  late MFMapViewController _controller;

  late List<DeviceGroupModel> listDGroup;
  List<DeviceLessModel>? searchDv;
  late DeviceStageModel? _dvStageCurent;
  DeviceStageModel? get dvStageCurent => _dvStageCurent;

  Map<MFMarkerId, MFMarker> markers = <MFMarkerId, MFMarker>{};

  @override
  void onClose() {
    // debugPrint('onClose');
    intervalCancel();
  }

  Future<void> initMarker() async {
    _markerIcon ??= await MFBitmap.fromAssetImage(
        const ImageConfiguration(), 'assets/icons/car_blue.png');
    update();
  }

  void getDeviceGroup() async {
    _loading = true;
    try {
      await DeviceAPI.getDeviceGroup().then((res) {
        listDGroup = List<DeviceGroupModel>.from(
            res.map((e) => DeviceGroupModel.fromJson(e)).toList());
      });
      _currentGroupID = listDGroup[_currentIndexGroup].vehicleGroupID;
      await DeviceAPI.getListDevieStage(_currentGroupID).then((res) {
        var listDState = List<DeviceStageModel>.from(
            res.map((e) => DeviceStageModel.fromJson(e)).toList());
        listDGroup[_currentIndexGroup].listDvStage = listDState;
      });
      _dvStageCurent = listDGroup[_currentIndexGroup].listDvStage![0];
      if (listDGroup[_currentIndexGroup].listDvStage != null) {
        for (var item in listDGroup[_currentIndexGroup].listDvStage!) {
          final MFMarkerId markerId = MFMarkerId(item.deviceID.toString());
          markers[markerId] = await setMarker(markerId, item);
        }
      }

      interval();
    } catch (error) {
      String errorMessage =
          error.toString().substring(error.toString().indexOf(' ') + 1);
      Get.snackbar(
        'Failed to login..',
        errorMessage,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
    _loading = false;
    update();
  }

  void searchDvByNumber(String vehicleNumber) async {
    _loading = true;
    try {
      await DeviceAPI.getDevieStageByVNumber(vehicleNumber).then((res) {
        if (res.toString() != "[]") {
          searchDv = List<DeviceLessModel>.from(
              res.map((e) => DeviceLessModel.fromJson(e)).toList());
        }
        // debugPrint(searchDv.toString());
      });
    } catch (error) {
      String errorMessage =
          error.toString().substring(error.toString().indexOf(' ') + 1);
      Get.snackbar(
        'Err ',
        errorMessage,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
    _loading = false;
    update();
  }

  void setMap() async {
    _loading = true;
    try {
      await DeviceAPI.getListDevieStage(_currentGroupID).then((res) {
        var listDState = List<DeviceStageModel>.from(
            res.map((e) => DeviceStageModel.fromJson(e)).toList());
        _dvStageCurent = listDState[0];
        listDGroup[_currentIndexGroup].listDvStage = listDState;
      });
      for (var item in listDGroup[_currentIndexGroup].listDvStage!) {
        final MFMarkerId markerId = MFMarkerId(item.deviceID.toString());
        markers[markerId] = await setMarker(markerId, item);
      }
      interval();
    } catch (error) {
      String errorMessage =
          error.toString().substring(error.toString().indexOf(' ') + 1);
      Get.snackbar(
        'Failed to login..',
        errorMessage,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
    _loading = false;
    update();
  }

  void interval() {
    _intervalData = Timer.periodic(const Duration(seconds: 20), (timer) async {
      await DeviceAPI.getListDevieStage(_currentGroupID).then((res) async {
        var listDState = List<DeviceStageModel>.from(
            res.map((e) => DeviceStageModel.fromJson(e)).toList());

        listDGroup[_currentIndexGroup].listDvStage = listDState;
        for (var item in listDState) {
          if (item.state == 3) {
            // debugPrint('update marker ${item.vehicleNumber}');
            MFMarkerId markerId = MFMarkerId(item.deviceID.toString());

            final MFMarker marker = markers[markerId]!;
            markers[markerId] = marker.copyWith(
              positionParam: MFLatLng(item.latitude, item.longitude),
            );
            // debugPrint('${markers[markerId]}');
          }
        }
        if (_dvStageCurent != null) {
          moveCamera(_dvStageCurent!.latitude, _dvStageCurent!.longitude);
        }

        update();
      });
    });
  }

  void intervalCurrentData(int deviceID) {
    _intervalCurrentData =
        Timer.periodic(const Duration(seconds: 20), (timer) async {
      await DeviceAPI.getDevieStageById(deviceID, true).then((res) {
        var dCurrent = DeviceStageModel.fromJson(res);
        MFMarkerId markerId = MFMarkerId(deviceID.toString());
        _changePostion(
            markerId, MFLatLng(dCurrent.latitude, dCurrent.longitude));
        panelMap(dCurrent);
        moveCamera(dCurrent.latitude, dCurrent.longitude);
        update();
      });
    });
  }

  void _changePostion(MFMarkerId markerId, MFLatLng loc) {
    final MFMarker marker = markers[markerId]!;
    markers[markerId] = marker.copyWith(positionParam: loc);
    update();
  }

  void changeCurrentGroup(int vehicleGroupID) {
    _currentIndexGroup = listDGroup
        .indexWhere((element) => element.vehicleGroupID == vehicleGroupID);
    _currentGroupID = vehicleGroupID;

    markers.clear();
    intervalCancel();
    setMap();
    update();
  }

  Future<void> toggle(int index) async {
    _loading = true;
    listDGroup[index].isShow = !listDGroup[index].isShow;
    if (listDGroup[index].listDvStage == null) {
      await DeviceAPI.getListDevieStage(listDGroup[index].vehicleGroupID)
          .then((res) async {
        var listDState = List<DeviceStageModel>.from(
            res.map((e) => DeviceStageModel.fromJson(e)).toList());

        listDGroup[index].listDvStage = listDState;
      });
    }
    _loading = false;
    update();
  }

  Future<void> setCurentDv(int deviceId) async {
    intervalCancel();
    markers.clear();
    // get
    await DeviceAPI.getDevieStageById(deviceId, true).then((res) {
      _dvStageCurent = DeviceStageModel.fromJson(res);
      _isSearch = false;
    });

    // setmap
    await setMapCurrent(_dvStageCurent!).then((res) {
      panelMap(_dvStageCurent!);

      intervalCurrentData(deviceId);
    });
    update();
  }

  Future<MFMarker> setMapCurrent(DeviceStageModel dv) async {
    final MFMarkerId markerId = MFMarkerId(dv.deviceID.toString());

    MFMarker marker = MFMarker(
        consumeTapEvents: true,
        markerId: markerId,
        position: MFLatLng(dv.latitude, dv.longitude),
        icon: _markerIcon!,
        onTap: () {
          panelMap(dv);
        });
    return markers[markerId] = marker;
  }

  // Future<void> _createMarkerImageFromAsset(BuildContext context) async {
  //   if (_markerIcon == null) {
  //     final ImageConfiguration imageConfiguration =
  //         createLocalImageConfiguration(context, size: Size.square(48));
  //     _markerIcon = await MFBitmap.fromAssetImage(
  //         imageConfiguration, 'assets/icons/car_blue.png');
  //   }
  // }

  void intervalCancel() {
    // debugPrint('--------intervalCancel--------');
    if (_intervalData != null) {
      _intervalData!.cancel();
    }
    if (_intervalCurrentData != null) {
      _intervalCurrentData!.cancel();
    }
  }
  /////////////////////////////////
  ///          4D MAP           //
  ///////////////////////////////

  Future<MFMarker> setMarker(MFMarkerId markerId, DeviceStageModel item) async {
    MFMarker marker = MFMarker(
        consumeTapEvents: true,
        markerId: markerId,
        position: MFLatLng(item.latitude, item.longitude),
        icon: _markerIcon!,
        onTap: () {
          moveCamera(item.latitude, item.longitude);
          panelMap(item);
        });
    return marker;
  }

  void panelMap(DeviceStageModel data) {
    _panelPosition = 0;
    _dvStageCurent = data;
    update();
  }

  void onMapCreated(MFMapViewController controller) {
    _controller = controller;
  }

  void onCameraMoveStarted() {}

  void onCameraMove(MFCameraPosition position) {}

  void onCameraIdle() {
    // print('onCameraIdle');
  }

  void moveCamera(double lat, double lng) {
    // MFCameraPosition cameraPosition =
    //     MFCameraPosition(bearing: 2.0, target: MFLatLng(lat, lng), zoom: 16);
    // final cameraUpdate = MFCameraUpdate.newLatLngZoom(MFLatLng(lat, lng), 10.0);
    // final cameraUpdate = MFCameraUpdate.newCameraPosition(cameraPosition);
    final cameraUpdate = MFCameraUpdate.newLatLng(MFLatLng(lat, lng));
    _controller.moveCamera(cameraUpdate);
  }

  void onTap(MFLatLng coordinate) {
    // FocusScopeNode currentFocus = FocusScope.of(context);
    // if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
    //   FocusManager.instance.primaryFocus!.unfocus();
    // }
    _panelPosition = -120;
    update();
  }

  void openSearch() {
    if (!_isSearch) {
      _panelPosition = -120;
      markers.clear();
      intervalCancel();
      _isSearch = true;
    }
    update();
  }

  void closeSearch() {
    _isSearch = false;
    update();
  }
}
