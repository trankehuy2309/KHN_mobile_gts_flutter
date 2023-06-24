import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:khn_tracking/src/core/controllers/dashboard_report.dart';
import 'package:get/get.dart';
import 'package:khn_tracking/src/models/report_distance.dart';

import '_report.dart';

class ReportRunning extends StatelessWidget {
  const ReportRunning({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<ReportRunningModel> data =
        Get.find<DashboardReportController>().reportRunning;
    String verhicleNumber =
        Get.find<DashboardReportController>().device!.vehicleNumber;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => {Get.back()},
        ),
        centerTitle: true,
        title: const Text('Báo cáo thời gian lái xe liên tục'),
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
                                label: Text(
                                  'Họ tên lái xe',
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                ),
                              ),
                              DataColumn(
                                label: SizedBox(
                                  child: Text(
                                    'Số GPLX',
                                    style:
                                        TextStyle(fontStyle: FontStyle.italic),
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: SizedBox(
                                  width: 80,
                                  child: Text(
                                    'Loại hình hoạt động',
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: SizedBox(
                                  width: 50,
                                  child: Text(
                                    'Thời điểm bắt đầu',
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 4,
                                    style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: SizedBox(
                                  width: 50,
                                  child: Text(
                                    'Tọa độ',
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 4,
                                    style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: SizedBox(
                                  width: 50,
                                  child: Text(
                                    'Địa điểm',
                                    style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: SizedBox(
                                  width: 50,
                                  child: Text(
                                    'Thời điểm kết thúc',
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 4,
                                    style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: SizedBox(
                                  width: 50,
                                  child: Text(
                                    'Tọa độ',
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 4,
                                    style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: SizedBox(
                                  width: 50,
                                  child: Text(
                                    'Địa điểm',
                                    style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: SizedBox(
                                  width: 50,
                                  child: Text(
                                    'Thời gian lái xe',
                                    style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: SizedBox(
                                  width: 50,
                                  child: Text(
                                    'Ghi chú',
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 4,
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
                                        item.nameDriver ?? '',
                                      ))),
                                      DataCell(SizedBox(
                                          child: Text(
                                        item.driverLicense ?? '',
                                      ))),
                                      DataCell(Text(
                                        item.typeTransportName,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                      )),
                                      DataCell(Text(
                                          DateFormat('HH:mm dd-MM-yyyy')
                                              .format(item.start))),
                                      DataCell(Text(item.coordinatesStart)),
                                      DataCell(SizedBox(
                                        width: 200,
                                        child: Text(
                                          item.addressStart,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 3,
                                        ),
                                      )),
                                      DataCell(Text(
                                          DateFormat('HH:mm dd-MM-yyyy')
                                              .format(item.end))),
                                      DataCell(Text(item.coordinatesEnd)),
                                      DataCell(SizedBox(
                                        width: 200,
                                        child: Text(
                                          item.addressEnd,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 3,
                                        ),
                                      )),
                                      DataCell(Text(
                                          '${(item.stimedriver.round()).toString()} phút')),
                                      const DataCell(Text('')),
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
