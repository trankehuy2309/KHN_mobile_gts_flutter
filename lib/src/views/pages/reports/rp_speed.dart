import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:khn_tracking/src/core/controllers/dashboard_report.dart';
import 'package:khn_tracking/src/models/report_distance.dart';

import '_report.dart';

class ReportHistorySpeed extends StatelessWidget {
  const ReportHistorySpeed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<ReportSpeedModel> data =
        Get.find<DashboardReportController>().reportSpeed;
    String verhicleNumber =
        Get.find<DashboardReportController>().device!.vehicleNumber;
    DataTableSource _data = MyDataSpeed();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => {Get.back()},
        ),
        centerTitle: true,
        title: const Text('Báo cáo vận tốc xe'),
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
                Scrollbar(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Scrollbar(
                      child: PaginatedDataTable(
                        source: _data,
                        columns: const <DataColumn>[
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
                                'Thời điểm',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontStyle: FontStyle.italic),
                              ),
                            ),
                          ),
                          DataColumn(
                            label: SizedBox(
                              width: 60,
                              child: Text(
                                'Tốc độ (km/h)',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: TextStyle(fontStyle: FontStyle.italic),
                              ),
                            ),
                          ),
                          DataColumn(
                            label: SizedBox(
                              width: 30,
                              child: Text(
                                'Ghi chú',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: TextStyle(fontStyle: FontStyle.italic),
                              ),
                            ),
                          ),
                        ],
                        columnSpacing: 20,
                        horizontalMargin: 5,
                        rowsPerPage: 8,
                        showCheckboxColumn: false,
                        // onRowsPerPageChanged:
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}

class MyDataSpeed extends DataTableSource {
  // Generate some made-up data
  String verhicleNumber =
      Get.find<DashboardReportController>().device!.vehicleNumber;
  final List<ReportSpeedModel> _data =
      Get.find<DashboardReportController>().reportSpeed;

  @override
  bool get isRowCountApproximate => false;
  @override
  int get rowCount => _data.length;
  @override
  int get selectedRowCount => 0;
  @override
  DataRow getRow(int index) {
    return DataRow(
      cells: <DataCell>[
        DataCell(Text(verhicleNumber)),
        DataCell(Text(
          DateFormat('HH:mm dd-MM-yyyy').format(_data[index].datesave),
        )),
        DataCell(Text(_data[index].speed.toString())),
        const DataCell(
          Text(''),
        ),
      ],
    );
  }
}
