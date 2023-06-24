// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:khn_tracking/src/core/controllers/_controller.dart';
import 'package:khn_tracking/src/core/controllers/device_controller.dart';

class TabSearchWidget extends StatelessWidget {
  const TabSearchWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(ReportController());
    return GetBuilder<ReportController>(
      init: Get.find<ReportController>(),
      builder: (controller) => controller.loading
          ? const TabSearchSecondWidget()
          : TabSearchFirstWidget(),
    );
  }
}

class TabSearchFirstWidget extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  DateTime? timeStart, timeEnd;

  TabSearchFirstWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ReportController>(
      init: Get.find<ReportController>(),
      builder: (controller) => DefaultTabController(
        length: 3, // length of tabs
        initialIndex: 0,
        child: Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TabBar(
                labelColor: Theme.of(context).primaryColor,
                unselectedLabelColor: Colors.grey,
                tabs: const [
                  Tab(text: 'Hôm nay'),
                  Tab(text: 'Hôm qua'),
                  Tab(text: 'Khác'),
                ],
              ),
              Container(
                  height: 220, //height of TabBarView
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(color: Colors.grey, width: 0.5),
                    ),
                  ),
                  child: TabBarView(children: <Widget>[
                    Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            minVerticalPadding: 0.0,
                            minLeadingWidth: 10.0,
                            horizontalTitleGap: 5,
                            leading: Icon(Icons.lock_clock,
                                color: Theme.of(context).primaryColor),
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
                                            currentTime: controller.start ??
                                                TProcess.getFirstDay(),
                                            showTitleActions: true,
                                            minTime: DateTime(2021, 1, 1, 0, 0),
                                            maxTime: controller.end ??
                                                DateTime.now(),
                                            onChanged: (date) {},
                                            onConfirm: (date) {
                                          controller.setDateTime(date, 0);
                                        }, locale: LocaleType.vi);
                                      },
                                      child: Text(
                                        controller.start != null
                                            ? timeToString(controller.start!, 1)
                                            : timeToString(
                                                TProcess.getFirstDay(), 1),
                                      )),
                                ),
                              ],
                            ),
                          ),
                          ListTile(
                            minVerticalPadding: 0.0,
                            minLeadingWidth: 10.0,
                            horizontalTitleGap: 5,
                            leading: Icon(Icons.lock_clock,
                                color: Theme.of(context).primaryColor),
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
                                            currentTime: controller.end ??
                                                TProcess.getNow(),
                                            showTitleActions: true,
                                            minTime: controller.start ??
                                                DateTime(2021, 01, 01, 0, 0),
                                            maxTime: TProcess.getNow(),
                                            onChanged: (date) {},
                                            onConfirm: (date) {
                                          controller.setDateTime(date, 1);
                                        }, locale: LocaleType.vi);
                                      },
                                      child: Text(
                                        controller.end != null
                                            ? timeToString(controller.end!, 1)
                                            : timeToString(
                                                TProcess.getNow(), 1),
                                      )),
                                ),
                              ],
                            ),
                          ),
                          ListTile(
                            minLeadingWidth: 10.0,
                            horizontalTitleGap: 5,
                            leading: Icon(Icons.lock_clock,
                                color: Theme.of(context).primaryColor),
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
                                        Scaffold.of(context).openEndDrawer();
                                      },
                                      child: Text(
                                        Get.find<DeviceController>()
                                            .dvReportCurrent!
                                            .vehicleNumber,
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor),
                                      )),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ElevatedButton(
                                child: const Text('Xác nhận'),
                                onPressed: () {
                                  if (checkD(
                                      controller.start!, controller.end!)) {
                                    controller.getListReportHistory(
                                        Get.find<DeviceController>()
                                            .dvReportCurrent!
                                            .deviceID,
                                        3);
                                  } else {
                                    String message =
                                        "Quãng thời gian không quá 1 ngày \nVui lòng nhập lại.";
                                    Get.snackbar(
                                      'Quá thời gian..',
                                      message,
                                      snackPosition: SnackPosition.TOP,
                                    );
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  fixedSize: const Size(120, 40),
                                ),
                              ),
                              ElevatedButton(
                                child: const Text('Hủy'),
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  fixedSize: const Size(120, 40),
                                  primary: Colors.grey,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Form(
                      key: _formKey2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            minVerticalPadding: 0.0,
                            minLeadingWidth: 10.0,
                            horizontalTitleGap: 5,
                            leading: Icon(Icons.lock_clock,
                                color: Theme.of(context).primaryColor),
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
                                            showTitleActions: true,
                                            // minTime: DateTime(2021, 5, 5, 20, 50),
                                            maxTime: TProcess.getNow(),
                                            onChanged: (date) {
                                          debugPrint(
                                              'change $date in time zone ' +
                                                  date.timeZoneOffset.inHours
                                                      .toString());
                                        }, onConfirm: (date) {
                                          // setState(() {
                                          //   timeStart = date as DateTime;
                                          // });
                                        }, locale: LocaleType.vi);
                                      },
                                      child: Text(
                                        timeStart != null
                                            ? timeToString(timeStart!, 1)
                                            : timeToString(
                                                DProcess.getFirstDayOfWeek(),
                                                1),
                                      )),
                                ),
                              ],
                            ),
                          ),
                          ListTile(
                            minVerticalPadding: 0.0,
                            minLeadingWidth: 10.0,
                            horizontalTitleGap: 5,
                            leading: Icon(Icons.lock_clock,
                                color: Theme.of(context).primaryColor),
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
                                            showTitleActions: true,
                                            minTime: timeStart ??
                                                DateTime(2020, 1, 1, 0, 0),
                                            maxTime: TProcess.getNow(),
                                            onChanged: (date) {
                                          debugPrint(
                                              'change $date in time zone ' +
                                                  date.timeZoneOffset.inHours
                                                      .toString());
                                        }, onConfirm: (date) {
                                          // setState(() {
                                          //   timeEnd = date;
                                          // });
                                        }, locale: LocaleType.vi);
                                      },
                                      child: Text(
                                        timeEnd != null
                                            ? timeToString(timeEnd!, 1)
                                            : timeToString(
                                                TProcess.getNow(), 1),
                                      )),
                                ),
                              ],
                            ),
                          ),
                          ListTile(
                            minLeadingWidth: 10.0,
                            horizontalTitleGap: 5,
                            leading: Icon(Icons.lock_clock,
                                color: Theme.of(context).primaryColor),
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
                                        Scaffold.of(context).openEndDrawer();
                                      },
                                      child: const Text(
                                        '51F9-99999',
                                        style: TextStyle(color: Colors.blue),
                                      )),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ElevatedButton(
                                child: const Text('Xác nhận'),
                                onPressed: () {
                                  controller.toggleSearchSuss();
                                },
                                style: ElevatedButton.styleFrom(
                                  fixedSize: const Size(120, 40),
                                ),
                              ),
                              ElevatedButton(
                                child: const Text('Hủy'),
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  fixedSize: const Size(120, 40),
                                  primary: Colors.grey,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    const Center(
                      child: Text('Display Tab 3',
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold)),
                    ),
                  ]))
            ],
          ),
        ),
      ),
    );
  }

  bool checkD(DateTime start, DateTime end) {
    var dHours = end.difference(start).inHours;
    if (dHours <= 24) return true;
    return false;
  }
}

class TProcess {
  static DateTime dtNow = DateTime.now();

  static DateTime getNow() {
    return dtNow;
  }

  static DateTime getFirstDay() {
    return DateTime(dtNow.year, dtNow.month, dtNow.day, 0, 0);
  }

  static DateTime getLastDay() {
    return DateTime(dtNow.year, dtNow.month, dtNow.day, 0, 0);
  }
}

class DProcess {
  static DateTime dtNow = DateTime.now();
  static DateTime getLasttDay() {
    return DateTime(dtNow.year, dtNow.month, dtNow.day, 0, 0);
  }

  static DateTime getFirstDayOfWeek() {
    var weekDay = dtNow.weekday;
    return dtNow.subtract(Duration(days: weekDay));
  }
}

class MProcess {}

String timeToString(DateTime dt, int? type) {
  //Type 0 -> dd-MM-yyyy
  //Type 1 -> dd-MM-yyyy hh:mm
  //Type 2 -> hh:mm:ss
  var formatter = DateFormat('dd-MM-yyyy HH:mm:ss');
  switch (type) {
    case 0:
      {
        formatter = DateFormat('dd-MM-yyyy');
        break;
      }
    case 1:
      {
        formatter = DateFormat('dd-MM-yyyy HH:mm');
        break;
      }
    case 2:
      {
        formatter = DateFormat('HH:mm:ss');
        break;
      }
    default:
      {
        break;
      }
  }
  String formattedDate = formatter.format(dt);
  return formattedDate;
}

class TabSearchSecondWidget extends StatelessWidget {
  const TabSearchSecondWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ReportController>(
      init: Get.find<ReportController>(),
      builder: (controller) => Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: const TextSpan(
                      style: TextStyle(color: Colors.grey),
                      children: [
                        WidgetSpan(
                          child: Icon(Icons.lock_clock, size: 16),
                        ),
                        TextSpan(
                          text: " 16:20:20 01/12/2021",
                        ),
                      ],
                    ),
                  ),
                  RichText(
                    text: const TextSpan(
                      style: TextStyle(color: Colors.grey),
                      children: [
                        TextSpan(
                          text: "43 km/h ",
                        ),
                        WidgetSpan(
                          child: Icon(Icons.lock_clock, size: 16),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              const ExpansionTile(
                  title: Text(''), children: <Widget>[Text('data')]),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('50F1 00123',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          TextButton(
                            child: Column(
                              children: const <Widget>[
                                Icon(Icons.add),
                                Text("Xem lại")
                              ],
                            ),
                            onPressed: () {},
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          TextButton(
                            child: Column(
                              children: const <Widget>[
                                Icon(Icons.add),
                                Text("Tìm kiếm")
                              ],
                            ),
                            onPressed: () {
                              controller.toggleSearchSuss();
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
