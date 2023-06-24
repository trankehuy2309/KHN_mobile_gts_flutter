import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:khn_tracking/src/core/controllers/dashboard_report.dart';
import 'package:khn_tracking/src/models/report_distance.dart';

import '_report.dart';

class ReportMaxSpeed extends StatelessWidget {
  const ReportMaxSpeed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<ReportMaxSpeedModel> data =
        Get.find<DashboardReportController>().reportMaxSpeed;
    String verhicleNumber =
        Get.find<DashboardReportController>().device!.vehicleNumber;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => {Get.back()},
        ),
        centerTitle: true,
        title: const Text('Báo cáo quá tốc độ lái xe'),
      ),
      body: data.isEmpty
          ? DataNullable()
          : ListView(
              children: [
                SizedBox(
                  height: 24,
                  child: ListTile(
                    title: Text('Biển số xe:  $verhicleNumber'),
                    dense: true,
                  ),
                ),
                SizedBox(
                  height: 50,
                  child: ListTile(
                    title: const Text('Thời gian'),
                    dense: true,
                    subtitle: Text(
                        '${DateFormat('HH:mm dd-MM-yyyy').format(Get.find<DashboardReportController>().start)} - ${DateFormat('HH:mm dd-MM-yyyy').format(Get.find<DashboardReportController>().end)}'),
                  ),
                ),
                SafeArea(
                  child: Scrollbar(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Scrollbar(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: DataTable(
                            columnSpacing: 10,
                            headingRowHeight: 100,
                            columns: const [
                              DataColumn(
                                label: Text(
                                  '#',
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Biển số',
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                ),
                              ),
                              DataColumn(
                                label: SizedBox(
                                  child: Text(
                                    'Thời điểm',
                                    style:
                                        TextStyle(fontStyle: FontStyle.italic),
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: SizedBox(
                                  width: 80,
                                  child: Text(
                                    'Địa điểm bắt đầu',
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 3,
                                    style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: SizedBox(
                                  width: 80,
                                  child: Text(
                                    'Địa điểm kết thúc',
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 3,
                                    style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: SizedBox(
                                  width: 80,
                                  child: Text(
                                    'Tổng thời gian vi phạm',
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 3,
                                    style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: SizedBox(
                                  width: 80,
                                  child: Text(
                                    'Quãng đường vi phạm',
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 3,
                                    style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: SizedBox(
                                  width: 80,
                                  child: Text(
                                    'Tốc độ giới hạn',
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 3,
                                    style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: SizedBox(
                                  width: 80,
                                  child: Text(
                                    'Tốc độ trung bình',
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 3,
                                    style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                            rows: data
                                .map(
                                  (item) => DataRow(
                                    cells: [
                                      DataCell(Text(
                                          (data.indexOf(item) + 1).toString())),
                                      DataCell(Text(verhicleNumber)),
                                      DataCell(SizedBox(
                                          child: Text(
                                              '${item.timeStart.toString()} - ${item.timeEnd.toString()}'))),
                                      DataCell(SizedBox(
                                        width: 150,
                                        child: Text(
                                          item.address,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 3,
                                        ),
                                      )),
                                      DataCell(SizedBox(
                                        width: 150,
                                        child: Text(
                                          item.addressEnd,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 3,
                                        ),
                                      )),
                                      DataCell(Text(item.duration)),
                                      DataCell(Text(item.distance.toString())),
                                      DataCell(Text(item.speedLimit)),
                                      DataCell(Text(item.tocDoTrungBinh)),
                                    ],
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
