import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:khn_tracking/src/core/controllers/_controller.dart';
import 'package:khn_tracking/src/core/controllers/dashboard_report.dart';
import 'package:khn_tracking/src/core/services/local_storage_locale.dart';
import 'package:khn_tracking/src/helper/ulti.dart';
import 'package:khn_tracking/src/models/device_model.dart';
import 'package:khn_tracking/src/views/pages/reports/rp_image.dart';

import '_report.dart';

class CategoryReport {
  const CategoryReport(
    this.id,
    this.name,
  );

  final String name;
  final int id;
}

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  final _formKey = GlobalKey<FormState>();
  late CategoryReport selectedCat;
  List<CategoryReport> categoryReports = <CategoryReport>[
    const CategoryReport(1, 'Báo cáo tổng quãng đường'),
    const CategoryReport(2, 'Báo cáo hành trình'),
    const CategoryReport(3, 'Báo cáo tốc độ xe'),
    const CategoryReport(4, 'Báo cáo dừng đỗ'),
    const CategoryReport(5, 'Báo cáo thời gian lái xe liên tục'),
    const CategoryReport(6, 'Biểu đồ tiêu thụ nhiên liệu'),
    const CategoryReport(7, 'Báo cáo tổng hợp theo xe'),
    // const CategoryReport(8, 'Báo cáo tổng hợp theo lái xe'),
    const CategoryReport(9, 'Báo cáo quá tốc độ giới hạn'),
    const CategoryReport(10, 'Báo cáo hình ảnh'),
  ];

  @override
  void initState() {
    selectedCat = categoryReports[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => DashboardReportController());
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('report'.tr),
          centerTitle: true),
      body: GetBuilder<DashboardReportController>(
        init: Get.find<DashboardReportController>(),
        builder: (controller) => SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SafeArea(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 15.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(color: Colors.teal)),
                  child: GetBuilder<DeviceController>(
                    init: Get.find<DeviceController>(),
                    builder: (controllerDevice) => Form(
                      key: _formKey,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            child: DropdownButton<CategoryReport>(
                              isExpanded: true,
                              value: selectedCat,
                              onChanged: (CategoryReport? newValue) {
                                setState(() {
                                  selectedCat = newValue!;
                                });
                              },
                              items: categoryReports.map((CategoryReport user) {
                                return DropdownMenuItem<CategoryReport>(
                                  value: user,
                                  child: Text(user.name,
                                      textAlign: TextAlign.center,
                                      style:
                                          const TextStyle(color: Colors.black),
                                      overflow: TextOverflow.ellipsis),
                                );
                              }).toList(),
                            ),
                            // decoration: ThemeHelper().inputBoxDecorationShaddow(),
                          ),
                          SizedBox(
                            height: 40,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Thiết bị'),
                                Flexible(
                                  child: TextButton(
                                      onPressed: () {
                                        // controller.openSearch();
                                        showSearch(
                                          context: context,
                                          delegate: CustomSearchDelegate(),
                                        );
                                        // Scaffold.of(context).openEndDrawer();
                                      },
                                      child: Text(
                                        controller.device != null
                                            ? controller.device!.vehicleNumber
                                            : 'Chọn biển số',
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor),
                                      )),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 40,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Từ :'),
                                Row(
                                  children: [
                                    TextButton(
                                      onPressed: () async {
                                        final DateTime? newDate =
                                            await showDatePicker(
                                          context: context,
                                          locale: await getLocale(),
                                          initialDate: controller.start,
                                          firstDate: DateTime(2021, 1),
                                          lastDate: DateTime.now(),
                                          helpText: 'dateStart'.tr,
                                        );
                                        controller.updateDateStart(newDate!);
                                      },
                                      child: Text(DateFormat('dd-MM-yyyy')
                                          .format(controller.start)),
                                    ),
                                    const SizedBox(width: 8),
                                    TextButton(
                                        onPressed: () async {
                                          final TimeOfDay? newHours =
                                              await showTimePicker(
                                            context: context,
                                            initialTime: TimeOfDay(
                                                hour: controller.start.hour,
                                                minute:
                                                    controller.start.minute),
                                            builder: (BuildContext context,
                                                Widget? child) {
                                              return MediaQuery(
                                                data: MediaQuery.of(context)
                                                    .copyWith(
                                                        alwaysUse24HourFormat:
                                                            true),
                                                child: child!,
                                              );
                                            },
                                          );
                                          controller.updateTimeStart(newHours!);
                                        },
                                        child: Text(
                                          DateFormat('HH:mm')
                                              .format(controller.start),
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColor),
                                        )),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 40,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Đến:'),
                                Row(
                                  children: [
                                    TextButton(
                                        onPressed: () async {
                                          final DateTime? newDate =
                                              await showDatePicker(
                                            context: context,
                                            locale: await getLocale(),
                                            initialDate: controller.end,
                                            firstDate: DateTime(2021, 1),
                                            lastDate: DateTime.now(),
                                            helpText: 'dateEnd'.tr,
                                          );
                                          controller.updateDateEnd(newDate!);
                                        },
                                        child: Text(DateFormat('dd-MM-yyyy')
                                            .format(controller.end))),
                                    const SizedBox(width: 8),
                                    TextButton(
                                        onPressed: () async {
                                          final TimeOfDay? newHours =
                                              await showTimePicker(
                                            context: context,
                                            initialTime: TimeOfDay(
                                                hour: controller.end.hour,
                                                minute: controller.end.minute),
                                            builder: (BuildContext context,
                                                Widget? child) {
                                              return MediaQuery(
                                                data: MediaQuery.of(context)
                                                    .copyWith(
                                                        alwaysUse24HourFormat:
                                                            true),
                                                child: child!,
                                              );
                                            },
                                          );
                                          controller.updateTimeEnd(newHours!);
                                        },
                                        child: Text(
                                          DateFormat('HH:mm')
                                              .format(controller.end),
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColor),
                                        )),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            alignment: Alignment.centerRight,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                minimumSize: MaterialStateProperty.all(
                                    const Size(100, 40)),
                              ),
                              child: controller.loading
                                  ? const SizedBox(
                                      child: CircularProgressIndicator(
                                          color: Colors.white),
                                      height: 20.0,
                                      width: 20.0)
                                  : const Text("Tra cứu"),
                              // child: SizedBox(
                              //     child: CircularProgressIndicator(
                              //         color: Colors.white),
                              //     height: 20.0,
                              //     width: 20.0),
                              onPressed: controller.loading
                                  ? null
                                  : () async {
                                      if (controller.device == null) {
                                        _showDialog(context,
                                            'Vui lòng chọn biển số cần tìm.');
                                      } else if (controller.end
                                          .isBefore(controller.start)) {
                                        _showDialog(context,
                                            'Ngày bắt đầu không được lớn hơn ngày kết thúc.');
                                      } else if (controller.end
                                              .difference(controller.start)
                                              .inHours >
                                          24) {
                                        _showDialog(context,
                                            'Thời gian tìm kiếm không quá 24 giờ.');
                                      } else {
                                        await controller
                                            .getReportType(selectedCat.id);
                                        switch (selectedCat.id) {
                                          case 1:
                                            {
                                              Get.to(
                                                  () => const ReportDistance());
                                              break;
                                            }
                                          case 2:
                                            {
                                              Get.to(
                                                  () => const ReportHistory());
                                              break;
                                            }
                                          case 3:
                                            {
                                              Get.to(() =>
                                                  const ReportHistorySpeed());
                                              break;
                                            }
                                          case 4:
                                            {
                                              Get.to(() =>
                                                  const ReportPauseStop());
                                              break;
                                            }
                                          case 5:
                                            {
                                              Get.to(
                                                  () => const ReportRunning());
                                              break;
                                            }
                                          case 6:
                                            {
                                              Get.to(() => ReportLineOil());
                                              break;
                                            }
                                          case 7:
                                            {
                                              Get.to(
                                                  () => const ReportAllByCar());
                                              break;
                                            }
                                          // case 8:
                                          //   {
                                          //     Get.to(() => const ReportAllByDriver());
                                          //     break;
                                          //   }
                                          case 9:
                                            {
                                              Get.to(
                                                  () => const ReportMaxSpeed());
                                              break;
                                            }
                                          case 10:
                                            {
                                              Get.to(() => const ReportImage());
                                              break;
                                            }
                                          default:
                                            {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const ReportDistance()),
                                              );
                                            }
                                        }
                                      }
                                    },
                            ),
                          ),
                        ],
                      ),
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

  void _showDialog(BuildContext context, String message) {
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
                  color: Colors.red,
                ),
                child: const Center(
                    child: Text('Thông báo',
                        style: TextStyle(fontSize: 16, color: Colors.white)))),
            content: Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Text(message),
            ),
          );
        });
  }
}

class CustomSearchDelegate extends SearchDelegate {
  List<String> searchTerms = Get.find<DeviceController>().searchTerms;
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
        Get.find<DeviceController>().closeSearch();
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    debugPrint('buildResults');
    List<DeviceStageModel> matchQuery = [];
    //List<DeviceGroupModel> listDGroup = Get.find<DeviceController>().listGroup;
    List<DeviceStageModel> listDvStage =
        Get.find<DeviceController>().lDeviceStage;
    // for (var item in listDGroup) {
    // ignore: unnecessary_null_comparison
    if (listDvStage != null) {
      for (var item2 in listDvStage) {
        if (item2.vehicleNumber.toLowerCase().contains(query.toLowerCase())) {
          matchQuery.add(item2);
        }
      }
    }
    if (matchQuery.isEmpty) {
      return const Center(child: Text('Không tìm thấy thông tin xe...'));
    }

    return ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (context, index) {
          var result = matchQuery[index];
          return Card(
            child: InkWell(
              onTap: () {
                Get.find<DashboardReportController>().setDeviceState(result);
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
    //List<DeviceGroupModel> listDGroup = Get.find<DeviceController>().listGroup;
    List<DeviceStageModel> listDvStage =
        Get.find<DeviceController>().lDeviceStage;
    // for (var item in listDGroup) {
    // ignore: unnecessary_null_comparison
    if (listDvStage != null) {
      for (var item2 in listDvStage) {
        if (item2.vehicleNumber.toLowerCase().contains(query.toLowerCase())) {
          matchQuery.add(item2);
        }
      }
    }
    if (matchQuery.isEmpty) {
      return const Center(child: Text('Không tìm thấy thông tin xe...'));
    } else {
      return ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (context, index) {
          var result = matchQuery[index];
          return Card(
            child: InkWell(
              onTap: () {
                Get.find<DashboardReportController>().setDeviceState(result);
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
