import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:khn_tracking/src/core/controllers/dashboard_report.dart';
import 'package:khn_tracking/src/models/report_distance.dart';

import '_report.dart';

class ReportAllByCar extends StatelessWidget {
  const ReportAllByCar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<ReportAllByCarModel> data =
        Get.find<DashboardReportController>().reportAllByCar;
    String verhicleNumber =
        Get.find<DashboardReportController>().device!.vehicleNumber;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => {Get.back()},
        ),
        centerTitle: true,
        title: const Text('Báo cáo tổng hợp theo xe'),
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
                  height: 40,
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
                                label: Text(
                                  'Tổng km',
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                ),
                              ),
                              DataColumn(
                                label: SizedBox(
                                  width: 50,
                                  child: Text(
                                    'Tỷ lệ quá tốc độ 5 - 10km/h',
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
                                    'Tỷ lệ quá tốc độ 10 - 20km/h',
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
                                    'Tỷ lệ quá tốc độ 20 - 35km/h',
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
                                    'Tỷ lệ quá tốc độ trên 35km/h',
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
                                    'Số lần quá tốc độ 5 - 10km/h',
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
                                    'Số lần quá tốc độ 10 - 20km/h',
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
                                    'Số lần quá tốc độ 20 - 35km/h',
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
                                    'Số lần quá tốc độ trên 35km/h',
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
                                    'Tổng số lần dừng đỗ',
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
                                      DataCell(Text(
                                        item.typeTransportName,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                      )),
                                      DataCell(Text(item.distance + ' km')),
                                      DataCell(
                                          Text(item.tyle1.toString() + ' %')),
                                      DataCell(
                                          Text(item.tyle2.toString() + ' %')),
                                      DataCell(
                                          Text(item.tyle3.toString() + ' %')),
                                      DataCell(
                                          Text(item.tyle4.toString() + ' %')),
                                      DataCell(Text(item.solan1.toString())),
                                      DataCell(Text(item.solan2.toString())),
                                      DataCell(Text(item.solan3.toString())),
                                      DataCell(Text(item.solan4.toString())),
                                      DataCell(
                                          Text(item.sPause_Stop.toString())),
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
