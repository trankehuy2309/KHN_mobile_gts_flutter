// ignore_for_file: must_be_immutable, deprecated_member_use

import 'dart:async';

import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:khn_tracking/src/core/controllers/dashboard_report.dart';
import 'package:khn_tracking/src/models/report_distance.dart';
import 'package:photo_view/photo_view.dart';
import 'package:khn_tracking/src/core/controllers/_controller.dart';
//import 'package:khn_tracking/src/core/controllers/device_controller.dart';
import 'package:khn_tracking/src/helper/ulti.dart';
import 'package:khn_tracking/src/models/device_model.dart';
import 'package:khn_tracking/src/models/report_model.dart';
import 'package:khn_tracking/src/views/widgets/_widgets.dart';

Timer? _intervalCurrentData;

class GMapFocus extends StatefulWidget {
  GMapFocus({Key? key, required this.device}) : super(key: key);
  DeviceStageModel device;

  @override
  _GMapFocusState createState() => _GMapFocusState();
}

class _GMapFocusState extends State<GMapFocus>
    with SingleTickerProviderStateMixin {
  final List<Tab> tabs = <Tab>[
    Tab(text: "home-map".tr),
    Tab(text: "dv-detail".tr),
    Tab(text: "history".tr),
    Tab(text: "picture".tr),
    Tab(text: "camera".tr),
  ];
  TabController? _tabController;
  @override
  void initState() {
    super.initState();
    Get.find<DeviceController>().intervalDispose();
    dvInfo(widget.device.deviceID);
    intervalDispose();
    intervalCurrentData();
    _tabController = TabController(vsync: this, length: tabs.length);
  }

  Future<void> dvInfo(int deviceId) async {
    widget.device = await Get.find<DeviceController>().getDeviceInfo(deviceId);
  }

  void intervalCurrentData() {
    _intervalCurrentData =
        Timer.periodic(const Duration(seconds: 20), (timer) async {
      dvInfo(widget.device.deviceID);
    });
  }

  void intervalDispose() {
    if (_intervalCurrentData != null) {
      _intervalCurrentData!.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => {
              intervalDispose(),
              Get.back(),
            },
          ),
          title: Text(widget.device.vehicleNumber),
          centerTitle: true,
          bottom: TabBar(
            isScrollable: true,
            unselectedLabelColor: Colors.white,
            labelColor: Colors.white,
            indicatorSize: TabBarIndicatorSize.tab,
            indicator: const BubbleTabIndicator(
              indicatorHeight: 25.0,
              indicatorColor: Colors.cyan,
              tabBarIndicatorSize: TabBarIndicatorSize.tab,
            ),
            tabs: tabs,
            controller: _tabController,
          )),
      body: GetBuilder<DeviceController>(
        init: Get.find<DeviceController>(),
        builder: (controller) => controller.loading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                controller: _tabController,
                children: [
                    // widget.device.latitude > 0
                    //? DemoMapFocus(device: widget.device)
                    // : DemoDeviceInfo(device: widget.device),

                    DemoMapFocus(device: widget.device),
                    DemoDeviceInfo(device: widget.device),
                    DemoReportHistory(deviceId: widget.device.deviceID),
                    widget.device.isCamera
                        ? const DemoCamPicture()
                        : const NotFoundCamera(),
                    const Waitting(),
                  ]),
      ),
    );
  }
}

class Waitting extends StatelessWidget {
  const Waitting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Center(
        child: Column(
          children: [
            SizedBox(
              height: 300.0,
              child: Ink.image(
                image: const NetworkImage(
                    "https://cdn.dribbble.com/users/77598/screenshots/16399264/media/d86ceb1ad552398787fb76f343080aa6.gif"),
                fit: BoxFit.cover,
              ),
            ),
            Text('developing'.tr,
                style: const TextStyle(fontSize: 18, color: Colors.cyan)),
          ],
        ),
      ),
    );
  }
}

class NotFoundCamera extends StatelessWidget {
  const NotFoundCamera({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Center(
        child: Column(
          children: [
            SizedBox(
              height: 300.0,
              child: Ink.image(
                image: const NetworkImage(
                    "https://cdn.dribbble.com/users/77598/screenshots/16399264/media/d86ceb1ad552398787fb76f343080aa6.gif"),
                fit: BoxFit.cover,
              ),
            ),
            Text('dv-noCam'.tr,
                style: const TextStyle(fontSize: 18, color: Colors.cyan)),
          ],
        ),
      ),
    );
  }
}

class DemoMapFocus extends StatelessWidget {
  DemoMapFocus({Key? key, required this.device}) : super(key: key);
  DeviceStageModel device;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ReportController>(
      init: Get.find<ReportController>(),
      builder: (controller) => controller.loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Stack(
              children: <Widget>[
                SizedBox(
                    height: MediaQuery.of(context).size.height - 50.0,
                    width: MediaQuery.of(context).size.width,
                    child: controller.map),
                Positioned(
                  bottom: 20.0,
                  child: SizedBox(
                      height: 150.0,
                      width: MediaQuery.of(context).size.width,
                      child: MapPinPillComponent(device: device)),
                )
              ],
            ),
    );
  }
}

class DemoDeviceInfo extends StatelessWidget {
  DemoDeviceInfo({Key? key, required this.device}) : super(key: key);
  DeviceStageModel device;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DeviceController>(
      init: Get.find<DeviceController>(),
      initState: Get.find<DeviceController>().setDvInfo,
      builder: (controller) => controller.loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 8,
                  ),
                  Card(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ListTileItemWidget(
                            Icons.album, 'Tên thiết bị', device.vehicleNumber),
                        ListTileItemWidget(
                            Icons.album, 'Phiên bản', device.version),
                        ListTileItemWidget(Icons.album, 'IMEI', device.imei),
                        ListTileItemWidget(
                            Icons.album, 'SIM', device.serialNumberInf_),
                      ],
                    ),
                  ),
                  Card(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ListTileItemWidget(Icons.album, 'ACC',
                            (device.statusKey == true ? 'Mở' : 'Tắt')),
                        ListTileItemWidget(Icons.album, 'Máy lạnh',
                            (device.cooler == true ? 'Mở' : 'Tắt')),
                        ListTileItemWidget(Icons.album, 'Cửa',
                            (device.statusDoor == true ? 'Đóng' : 'Mở')),
                        //oil_val
                        ListTileItemWidget(Icons.album, 'Nhiên liệu',
                            (device.oilval == null ? '#' : device.oilval!)),
                        ListTileItemWidget(Icons.album, 'Thời gian cập nhật',
                            timeToString(device.dateSave)),
                        ListTileItemWidget(Icons.album, 'Tốc độ',
                            '${device.speed.toString()} km/h'),
                        ListTileItemWidget(
                            Icons.album, 'Vĩ độ', device.latitude.toString()),
                        ListTileItemWidget(Icons.album, 'Kinh độ',
                            device.longitude.toString()),
                        ListTileItemWidget(
                            Icons.album, 'Địa chỉ', device.addr!),
                      ],
                    ),
                  ),
                  Card(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ListTileItemWidget(Icons.album, 'Hết hạn',
                            timeToString(device.dateExpired)),
                        ListTileItemWidget(
                            Icons.album, 'Biển số xe', device.vehicleNumber),
                        ListTileItemWidget(
                            Icons.album, 'Tên lái xe', device.theDriver),
                        const ListTileItemWidget(
                            Icons.album, 'Số liên lạc', '#'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

class DemoReportHistory extends StatelessWidget {
  DemoReportHistory({Key? key, required this.deviceId}) : super(key: key);
  int deviceId;
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => DashboardReportController());

    return GetBuilder<ReportController>(
      init: Get.find<ReportController>(),
      builder: (controller) => controller.loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Stack(
              alignment: Alignment.center,
              children: <Widget>[
                controller.loadingMap
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : SizedBox(
                        height: MediaQuery.of(context).size.height - 50.0,
                        width: MediaQuery.of(context).size.width,
                        child: GoogleMap(
                          initialCameraPosition: controller.position,
                          markers: Set.from(controller.currentMarkers),
                          polylines:
                              Set<Polyline>.of(controller.polylines.values),
                          onMapCreated: controller.mapCreated,
                          onCameraMove: controller.onGeoChanged,
                        ),
                      ),
                Positioned(
                  left: 10,
                  right: 10,
                  top: 10,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.zero,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        child: const DemoToggleButton(),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  right: 12,
                  top: 60,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: IconButton(
                      padding: const EdgeInsets.all(8),
                      icon: Image.asset('assets/themes/icons/fine-print.png',
                          width: 30),
                      onPressed: () {
                        Get.to(() => DemoListReport(
                            vehicleNumber: Get.find<DeviceController>()
                                .deviceStage!
                                .vehicleNumber,
                            start: controller.start!,
                            end: controller.end!));
                      },
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}

class DemoCamPicture extends StatefulWidget {
  const DemoCamPicture({Key? key}) : super(key: key);

  @override
  _DemoCamPictureState createState() => _DemoCamPictureState();
}

class _DemoCamPictureState extends State<DemoCamPicture> {
  static const double _endReachedThreshold = 200;
  static const int _itemsPerPage = 10;

  final ScrollController _controller = ScrollController();
  DeviceStageModel device = Get.find<DeviceController>().deviceStage!;

  final List<ReportImageModel> _datas = [];
  int _nextPage = 1;
  bool _loading = true;
  bool _canLoadMore = true;

  @override
  void initState() {
    _controller.addListener(_onScroll);

    _getDatas();

    super.initState();
  }

  Future<void> _getDatas() async {
    _loading = true;

    await Get.find<ReportController>().getListImageFromTo(
        device.deviceID, _nextPage, _itemsPerPage, null, null);
    final newDatas = Get.find<ReportController>().listImages;

    setState(() {
      _datas.addAll(newDatas);
      debugPrint(_nextPage.toString());

      _nextPage++;

      if (newDatas.length < _itemsPerPage) {
        _canLoadMore = false;
      }

      _loading = false;
    });
  }

  void _onScroll() {
    if (!_controller.hasClients || _loading) return;

    final thresholdReached =
        _controller.position.extentAfter < _endReachedThreshold;

    if (thresholdReached) {
      _getDatas();
    }
  }

  Future<void> _refresh() async {
    _canLoadMore = true;
    _datas.clear();
    _nextPage = 1;
    await _getDatas();
  }

  Widget _buildDataItem(BuildContext context, int index) {
    return Card(
        margin: const EdgeInsets.all(4.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
                child: Image.network(
                  _datas[index].relativeURL,
                  //"https://cdn.dribbble.com/users/77598/screenshots/16399264/media/d86ceb1ad552398787fb76f343080aa6.gif",
                  fit: BoxFit.fill,
                ),
                onTap: () {
                  open(context, index);
                }),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      _datas[index].camName! +
                          "_" +
                          timeToString(_datas[index].timeImg),
                      style: const TextStyle(
                          fontSize: 12.0, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text(_datas[index].addr!,
                      // '184/1 Nguyễn Văn Khối, Phường 9, quận Gò Vấp, Tp Hồ Chí Minh',
                      style: const TextStyle(fontSize: 11.0),
                      maxLines: 2),
                ],
              ),
            )
          ],
        ));
  }

  void open(BuildContext context, final int index) => showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            child: PhotoView(
              tightMode: true,
              imageProvider: NetworkImage(_datas[index].relativeURL),
              heroAttributes: const PhotoViewHeroAttributes(tag: "someTag"),
            ),
          );
        },
      );

  @override
  Widget build(BuildContext context) {
    return _datas.isEmpty
        ? SizedBox(
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 300.0,
                    child: Ink.image(
                      image: const NetworkImage(
                          "https://cdn.dribbble.com/users/77598/screenshots/16399264/media/d86ceb1ad552398787fb76f343080aa6.gif"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  const Text('Không tìm thấy dữ liệu trong ngày...',
                      style: TextStyle(fontSize: 18, color: Colors.cyan)),
                ],
              ),
            ),
          )
        : CustomScrollView(
            controller: _controller,
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            slivers: [
              CupertinoSliverRefreshControl(
                onRefresh: _refresh,
              ),
              SliverPadding(
                padding: const EdgeInsets.all(4),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 4,
                    mainAxisSpacing: 4,
                    childAspectRatio: 1 / 1,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    _buildDataItem,
                    childCount: _datas.length,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: _canLoadMore
                    ? Container(
                        padding: const EdgeInsets.only(bottom: 16),
                        alignment: Alignment.center,
                        child: const CircularProgressIndicator(),
                      )
                    : const SizedBox(),
              ),
            ],
          );
  }
}

// class GalleryPhotoViewWrapper extends StatefulWidget {
//   GalleryPhotoViewWrapper({
//     this.loadingBuilder,
//     this.backgroundDecoration,
//     this.initialIndex = 0,
//     required this.galleryItems,
//     this.scrollDirection = Axis.horizontal,
//   }) : pageController = PageController(initialPage: initialIndex);

//   final LoadingBuilder? loadingBuilder;
//   final BoxDecoration? backgroundDecoration;
//   final int initialIndex;
//   final PageController pageController;
//   final List<ReportImageModel> galleryItems;
//   final Axis scrollDirection;

//   @override
//   State<StatefulWidget> createState() {
//     return _GalleryPhotoViewWrapperState();
//   }
// }

// class _GalleryPhotoViewWrapperState extends State<GalleryPhotoViewWrapper> {
//   late int currentIndex = widget.initialIndex;

//   void onPageChanged(int index) {
//     setState(() {
//       currentIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: widget.backgroundDecoration,
//         constraints: BoxConstraints.expand(
//           height: MediaQuery.of(context).size.height,
//         ),
//         child: Stack(
//           alignment: Alignment.bottomRight,
//           children: <Widget>[
//             PhotoViewGallery.builder(
//               scrollPhysics: const BouncingScrollPhysics(),
//               builder: _buildItem,
//               itemCount: widget.galleryItems.length - 1,
//               loadingBuilder: widget.loadingBuilder,
//               backgroundDecoration: widget.backgroundDecoration,
//               pageController: widget.pageController,
//               onPageChanged: onPageChanged,
//               scrollDirection: widget.scrollDirection,
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   Text(
//                     timeToString(widget.galleryItems[currentIndex].timeImg),
//                     style: const TextStyle(
//                       color: Colors.white,
//                       fontSize: 17.0,
//                       decoration: null,
//                     ),
//                   ),
//                   Text(
//                     widget.galleryItems[currentIndex].addr,
//                     style: const TextStyle(
//                       color: Colors.white,
//                       fontSize: 17.0,
//                       decoration: null,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   PhotoViewGalleryPageOptions _buildItem(BuildContext context, int index) {
//     final ReportImageModel item = widget.galleryItems[index];
//     return PhotoViewGalleryPageOptions(
//       imageProvider: NetworkImage(item.relativeURL),
//       initialScale: PhotoViewComputedScale.contained,
//       minScale: PhotoViewComputedScale.contained,
//       maxScale: PhotoViewComputedScale.covered * 4.1,
//       heroAttributes: PhotoViewHeroAttributes(tag: item.timeImg),
//     );
//   }
// }

// class GalleryExampleItemThumbnail extends StatelessWidget {
//   const GalleryExampleItemThumbnail({
//     Key? key,
//     required this.galleryExampleItem,
//     required this.onTap,
//   }) : super(key: key);

//   final DataImage galleryExampleItem;

//   final GestureTapCallback onTap;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 5.0),
//       child: GestureDetector(
//         onTap: onTap,
//         child: Hero(
//           tag: galleryExampleItem.id,
//           child: Ink.image(
//             image: NetworkImage(galleryExampleItem.imageUrl),
//             fit: BoxFit.cover,
//           ),
//         ),
//       ),
//     );
//   }
// }

class DemoListReport extends StatelessWidget {
  DemoListReport(
      {Key? key,
      required this.vehicleNumber,
      required this.start,
      required this.end})
      : super(key: key);
  String vehicleNumber;
  DateTime start, end;

  @override
  Widget build(BuildContext context) {
    ReportModel report = Get.find<ReportController>().report!;
    final DataTableSource _data = MyData();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => {Get.back()},
        ),
        centerTitle: true,
        title: Text('Lộ trình $vehicleNumber'),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 24,
            child: ListTile(
              title: Text('Tổng quãng đường:  ${report.distances} km'),
              dense: true,
            ),
          ),
          SizedBox(
            height: 40,
            child: ListTile(
              title: const Text('Thời gian'),
              dense: true,
              subtitle: Text('${timeToString(start)} - ${timeToString(end)}'),
            ),
          ),
          const SizedBox(height: 10),
          PaginatedDataTable(
            source: _data,
            columns: const [
              DataColumn(
                label: Text(
                  'Thời gian',
                ),
              ),
              DataColumn(
                label: Text(
                  'Tốc độ',
                ),
              ),
              DataColumn(
                label: Text(
                  'Địa chỉ',
                ),
              ),
            ],
            columnSpacing: 20,
            horizontalMargin: 5,
            rowsPerPage: 8,
            showCheckboxColumn: false,
            // onRowsPerPageChanged:
          ),
        ],
      ),
    );
  }
}

// The "soruce" of the table
class MyData extends DataTableSource {
  // Generate some made-up data
  final List<DataModel> _data =
      Get.find<ReportController>().getDataReportHistory();

  @override
  bool get isRowCountApproximate => false;
  @override
  int get rowCount => _data.length;
  @override
  int get selectedRowCount => 0;
  @override
  DataRow getRow(int index) {
    return DataRow(cells: [
      DataCell(
        Text(
          timeToString(_data[index].dateSave),
          style: const TextStyle(fontSize: 12.0),
        ),
      ),
      DataCell(SizedBox(
          width: 48, //SET max width
          child: Text(
              _data[index].speed == 0.0
                  ? 'Dừng'
                  : '${_data[index].speed.toString()} km',
              style: const TextStyle(fontSize: 12.0),
              overflow: TextOverflow.ellipsis))),
      DataCell(Text(
          _data[index].addr != "khong xac dinh"
              ? _data[index].addr!
              : 'updating'.tr,
          style: const TextStyle(fontSize: 12.0),
          maxLines: 2,
          overflow: TextOverflow.ellipsis)),
    ]);
  }
}

class DemoToggleButton extends StatefulWidget {
  const DemoToggleButton({Key? key}) : super(key: key);

  @override
  _DemoToggleButtonState createState() => _DemoToggleButtonState();
}

class _DemoToggleButtonState extends State<DemoToggleButton> {
  final List<bool> _isSelected = [true, false, false, false];
  DeviceStageModel device = Get.find<DeviceController>().deviceStage!;
  final reportController = Get.find<ReportController>();

  @override
  void initState() {
    _getHistory();

    super.initState();
  }

  void _getHistory() {
    reportController.getListReportHistory(device.deviceID, 0);
  }

  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      color: Colors.cyan,
      selectedColor: Colors.white,
      selectedBorderColor: Colors.cyan,
      borderColor: Colors.cyan,
      fillColor: Colors.cyan,
      borderRadius: BorderRadius.circular(18.0),
      constraints: const BoxConstraints(minHeight: 36.0),
      children: const <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text('1H'),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text('8H'),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text('Hôm nay'),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text('Tùy chọn'),
        ),
      ],
      onPressed: (int index) {
        if (index == 3) {
          _showDialog(context);
        } else {
          reportController.getListReportHistory(device.deviceID, index);
        }
        setState(() {
          for (int buttonIndex = 0;
              buttonIndex < _isSelected.length;
              buttonIndex++) {
            if (buttonIndex == index) {
              _isSelected[buttonIndex] = true;
            } else {
              _isSelected[buttonIndex] = false;
            }
          }
        });
      },
      isSelected: _isSelected,
    );
  }

  void _showDialog(BuildContext context) {
    final reportController = Get.find<ReportController>();
    DeviceStageModel device = Get.find<DeviceController>().deviceStage!;
    reportController.changeTime1Day();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return GetBuilder<ReportController>(
          init: Get.find<ReportController>(),
          builder: (controller) => AlertDialog(
            contentPadding: const EdgeInsets.all(0),
            titlePadding: EdgeInsets.zero,
            title: Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: Colors.cyan,
                ),
                child: const Center(
                    child: Text('Lộ trình tìm kiếm',
                        style: TextStyle(fontSize: 16, color: Colors.white)))),
            content: Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Lưu ý: Tra cứu không quá 24h.',
                      style: TextStyle(
                          fontSize: 14.0,
                          fontStyle: FontStyle.italic,
                          color: Colors.cyan)),
                  SizedBox(
                    height: 32,
                    child: ListTile(
                      minLeadingWidth: 10.0,
                      horizontalTitleGap: 5,
                      minVerticalPadding: 5,
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Text('device'.tr),
                          ),
                          Flexible(
                            child: TextButton(
                                onPressed: () {
                                  // Scaffold.of(context).openEndDrawer();
                                },
                                child: Text(
                                  device.vehicleNumber,
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor),
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 32,
                    child: ListTile(
                      minVerticalPadding: 0.0,
                      minLeadingWidth: 10.0,
                      horizontalTitleGap: 5,
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(right: 8.0),
                            child: Text('Bắt đầu'),
                          ),
                          Flexible(
                            child: TextButton(
                                onPressed: () {
                                  DatePicker.showDateTimePicker(context,
                                      currentTime:
                                          controller.start ?? DateTime.now(),
                                      showTitleActions: true,
                                      minTime: DateTime(2021, 1, 1, 0, 0),
                                      maxTime: controller.end ?? DateTime.now(),
                                      onChanged: (date) {}, onConfirm: (date) {
                                    controller.setDateTime(date, 0);
                                  }, locale: LocaleType.vi);
                                },
                                child: Text(
                                  controller.start != null
                                      ? timeToString(controller.start!)
                                      : timeToString(DateTime.now()),
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 32,
                    child: ListTile(
                      minVerticalPadding: 0.0,
                      minLeadingWidth: 10.0,
                      horizontalTitleGap: 5,
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(right: 8.0),
                            child: Text('Kết thúc'),
                          ),
                          Flexible(
                            child: TextButton(
                                onPressed: () {
                                  DatePicker.showDateTimePicker(context,
                                      currentTime:
                                          controller.end ?? DateTime.now(),
                                      showTitleActions: true,
                                      minTime: DateTime(2021, 1, 1, 0, 0),
                                      maxTime: DateTime.now(),
                                      onChanged: (date) {}, onConfirm: (date) {
                                    controller.setDateTime(date, 1);
                                  }, locale: LocaleType.vi);
                                },
                                child: Text(
                                  controller.end != null
                                      ? timeToString(controller.end!)
                                      : timeToString(DateTime.now()),
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              FlatButton(
                child: const Text("Hủy bỏ"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: const Text("Tra cứu"),
                onPressed: () {
                  var dHours =
                      controller.end!.difference(controller.start!).inHours;
                  if (dHours <= 24) {
                    reportController.getListReportHistory(device.deviceID, 3);
                    Navigator.of(context).pop();
                  } else {
                    debugPrint('Error');
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class MapPinPillComponent extends StatelessWidget {
  MapPinPillComponent({Key? key, required this.device}) : super(key: key);
  DeviceStageModel device;

  @override
  Widget build(BuildContext context) {
    return Container(
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
        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0), color: Colors.white),
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
                    device.stateStr.toString().replaceAll(RegExp('\r\n'), ''),
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
    );
  }
}
