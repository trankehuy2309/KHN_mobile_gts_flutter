// ignore_for_file: must_be_immutable

import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:khn_tracking/src/core/controllers/_controller.dart';
import 'package:khn_tracking/src/core/controllers/device_controller.dart';
import 'package:khn_tracking/src/helper/ulti.dart';
import 'package:khn_tracking/src/models/device_model.dart';
import 'package:khn_tracking/src/models/mock/data_image.dart';
import 'package:khn_tracking/src/views/widgets/_widgets.dart';

class GMapFocus extends StatefulWidget {
  GMapFocus({Key? key, required this.device}) : super(key: key);
  DeviceStageModel device;

  @override
  _GMapFocusState createState() => _GMapFocusState();
}

class _GMapFocusState extends State<GMapFocus>
    with SingleTickerProviderStateMixin {
  final List<Tab> tabs = const <Tab>[
    Tab(text: "Giám sát"),
    Tab(text: "Chi tiết"),
    Tab(text: "Lịch sử"),
    Tab(text: "Hình ảnh"),
    Tab(text: "Camera"),
  ];
  TabController? _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: tabs.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => {Get.back()},
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
                    const DemoMapFocus(),
                    DemoDeviceInfo(device: widget.device),
                    DemoReportHistory(deviceId: widget.device.deviceID),
                    const DemoCamPicture(),
                    const dvCurrentMap(),
                  ]),
      ),
    );
  }
}

// ignore: camel_case_types
class dvCurrentMap extends StatelessWidget {
  const dvCurrentMap({Key? key}) : super(key: key);

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
            const Text('Chức năng đang được phát triển...',
                style: TextStyle(fontSize: 18, color: Colors.cyan)),
          ],
        ),
      ),
    );
  }
}

class DemoMapFocus extends StatelessWidget {
  const DemoMapFocus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ReportController());

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
                            Icons.album, 'Loại thiết bị', device.version),
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
                        const ListTileItemWidget(
                            Icons.album, 'Tình trạng', '#'),
                        const ListTileItemWidget(Icons.album, 'ACC', '#'),
                        ListTileItemWidget(Icons.album, 'Thời gian cập nhật',
                            timeToString(device.dateSave)),
                        ListTileItemWidget(Icons.album, 'Tốc độ',
                            '${device.speed.toString()} km/h'),
                        ListTileItemWidget(
                            Icons.album, 'Vĩ độ', device.latitude.toString()),
                        ListTileItemWidget(Icons.album, 'Kinh độ',
                            device.longitude.toString()),
                        const ListTileItemWidget(Icons.album, 'Địa chỉ', '#'),
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
    Get.lazyPut(() => ReportController());

    return GetBuilder<ReportController>(
      init: Get.find<ReportController>(),
      builder: (controller) => controller.loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Stack(
              alignment: Alignment.center,
              children: <Widget>[
                SizedBox(
                    height: MediaQuery.of(context).size.height - 50.0,
                    width: MediaQuery.of(context).size.width,
                    child: controller.map),
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
                        Get.to(() => const DemoListReport());
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
  static const int _itemsPerPage = 20;

  final ScrollController _controller = ScrollController();

  final List<DataImage> _datas = [];
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

    final newDatas =
        await getDataImagesFromServer(page: _nextPage, limit: _itemsPerPage);

    setState(() {
      _datas.addAll(newDatas);

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
        elevation: 2.0,
        child: Column(
          children: [
            SizedBox(
              height: 100.0,
              child: InkWell(
                child: Ink.image(
                  image: NetworkImage(_datas[index].imageUrl),
                  fit: BoxFit.cover,
                ),
                onTap: () {
                  open(context, index);
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
              alignment: Alignment.centerLeft,
              child: Text(timeToString(_datas[index].dateSave),
                  style: const TextStyle(
                      fontSize: 12.0, fontWeight: FontWeight.bold)),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
              alignment: Alignment.centerLeft,
              child: Text(_datas[index].addr,
                  style: const TextStyle(fontSize: 12.0)),
            ),
          ],
        ));
  }

  void open(BuildContext context, final int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GalleryPhotoViewWrapper(
          galleryItems: _datas,
          backgroundDecoration: const BoxDecoration(
            color: Colors.black,
          ),
          initialIndex: index,
          scrollDirection: Axis.vertical,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: _controller,
      slivers: <Widget>[
        CupertinoSliverRefreshControl(
          onRefresh: _refresh,
        ),
        SliverPadding(
          padding: const EdgeInsets.all(8),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 0.8,
              crossAxisCount: 2,
              crossAxisSpacing: 4,
              mainAxisSpacing: 4,
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

  Card buildCard() {
    var cardImage =
        const NetworkImage('https://source.unsplash.com/random/800x600?house');
    var supportingText = '18:10:00 20-01-2022';
    var supportingText2 =
        '184/1 Nguyễn Văn Khối, Phường 9, quận Gò Vấp, Tp Hồ Chí Minh';
    return Card(
        elevation: 2.0,
        child: Column(
          children: [
            SizedBox(
              height: 100.0,
              child: Ink.image(
                image: cardImage,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
              alignment: Alignment.centerLeft,
              child: Text(supportingText,
                  style: const TextStyle(
                      fontSize: 12.0, fontWeight: FontWeight.bold)),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
              alignment: Alignment.centerLeft,
              child:
                  Text(supportingText2, style: const TextStyle(fontSize: 12.0)),
            ),
          ],
        ));
  }
}

class GalleryPhotoViewWrapper extends StatefulWidget {
  GalleryPhotoViewWrapper({
    Key? key,
    this.loadingBuilder,
    this.backgroundDecoration,
    this.minScale,
    this.maxScale,
    this.initialIndex = 0,
    required this.galleryItems,
    this.scrollDirection = Axis.vertical,
  })  : pageController = PageController(initialPage: initialIndex),
        super(key: key);

  final LoadingBuilder? loadingBuilder;
  final BoxDecoration? backgroundDecoration;
  final dynamic minScale;
  final dynamic maxScale;
  final int initialIndex;
  final PageController pageController;
  final List<DataImage> galleryItems;
  final Axis scrollDirection;

  @override
  State<StatefulWidget> createState() {
    return _GalleryPhotoViewWrapperState();
  }
}

class _GalleryPhotoViewWrapperState extends State<GalleryPhotoViewWrapper> {
  late int currentIndex = widget.initialIndex;

  void onPageChanged(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: widget.backgroundDecoration,
        constraints: BoxConstraints.expand(
          height: MediaQuery.of(context).size.height,
        ),
        child: Stack(
          alignment: Alignment.bottomRight,
          children: <Widget>[
            PhotoViewGallery.builder(
              scrollPhysics: const BouncingScrollPhysics(),
              builder: _buildItem,
              itemCount: widget.galleryItems.length,
              loadingBuilder: widget.loadingBuilder,
              backgroundDecoration: widget.backgroundDecoration,
              pageController: widget.pageController,
              onPageChanged: onPageChanged,
              scrollDirection: widget.scrollDirection,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    timeToString(widget.galleryItems[currentIndex].dateSave),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 17.0,
                      decoration: null,
                    ),
                  ),
                  Text(
                    widget.galleryItems[currentIndex].addr,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 17.0,
                      decoration: null,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  PhotoViewGalleryPageOptions _buildItem(BuildContext context, int index) {
    final DataImage item = widget.galleryItems[index];
    return PhotoViewGalleryPageOptions(
      imageProvider: NetworkImage(item.imageUrl),
      initialScale: PhotoViewComputedScale.contained,
      minScale: PhotoViewComputedScale.contained * (0.5 + index / 10),
      maxScale: PhotoViewComputedScale.covered * 4.1,
      heroAttributes: PhotoViewHeroAttributes(tag: item.id),
    );
  }
}

class GalleryExampleItemThumbnail extends StatelessWidget {
  const GalleryExampleItemThumbnail({
    Key? key,
    required this.galleryExampleItem,
    required this.onTap,
  }) : super(key: key);

  final DataImage galleryExampleItem;

  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: GestureDetector(
        onTap: onTap,
        child: Hero(
          tag: galleryExampleItem.id,
          child: Ink.image(
            image: NetworkImage(galleryExampleItem.imageUrl),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

class DemoListReport extends StatelessWidget {
  const DemoListReport({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => {Get.back()},
        ),
        centerTitle: true,
        title: const Text('Dữ liệu truy xuất'),
      ),
      body: const Text('Hi'),
    );
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
          child: Text('4H'),
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
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
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
                ListTile(
                  minLeadingWidth: 10.0,
                  horizontalTitleGap: 5,
                  minVerticalPadding: 5,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: Text('Thiết bị'),
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
                ListTile(
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
                                      reportController.start ?? DateTime.now(),
                                  showTitleActions: true,
                                  minTime: DateTime(2021, 1, 1, 0, 0),
                                  maxTime:
                                      reportController.end ?? DateTime.now(),
                                  onChanged: (date) {}, onConfirm: (date) {
                                reportController.setDateTime(date, 0);
                              }, locale: LocaleType.vi);
                            },
                            child: Text(
                              reportController.start != null
                                  ? timeToString(reportController.start!)
                                  : timeToString(DateTime.now()),
                            )),
                      ),
                    ],
                  ),
                ),
                ListTile(
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
                                      reportController.end ?? DateTime.now(),
                                  showTitleActions: true,
                                  minTime: DateTime(2021, 1, 1, 0, 0),
                                  maxTime: DateTime.now(),
                                  onChanged: (date) {}, onConfirm: (date) {
                                reportController.setDateTime(date, 1);
                              }, locale: LocaleType.vi);
                            },
                            child: Text(
                              reportController.end != null
                                  ? timeToString(reportController.end!)
                                  : timeToString(DateTime.now()),
                            )),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          actions: [
            // ignore: deprecated_member_use
            FlatButton(
              child: const Text("Hủy bỏ"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            // ignore: deprecated_member_use
            FlatButton(
              child: const Text("Tra cứu"),
              onPressed: () {
                reportController.getListReportHistory(device.deviceID, 3);
              },
            ),
          ],
        );
      },
    );
  }
}
