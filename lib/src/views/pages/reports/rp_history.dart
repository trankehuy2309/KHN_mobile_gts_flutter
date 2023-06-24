import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:khn_tracking/src/core/controllers/dashboard_report.dart';
import 'package:khn_tracking/src/helper/ulti.dart';
import 'package:khn_tracking/src/models/report_distance.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:share_plus/share_plus.dart';

import '_report.dart';

class ReportHistory extends StatelessWidget {
  const ReportHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String verhicleNumber =
        Get.find<DashboardReportController>().device!.vehicleNumber;

    final DataTableSource _data = MyData();
    return GetBuilder<DashboardReportController>(
        init: Get.find<DashboardReportController>(),
        builder: (controller) => Scaffold(
            appBar: AppBar(
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => {Get.back()},
                ),
                centerTitle: true,
                title: const Text('Báo cáo hành trình'),
                actions: controller.reportModel == null
                    ? []
                    : [
                        IconButton(
                          icon: const Icon(Icons.download),
                          onPressed: () => downloadPdf(
                              Get.find<DashboardReportController>()
                                  .device!
                                  .vehicleNumber,
                              'Báo cáo hành trình ${Get.find<DashboardReportController>().device!.vehicleNumber}_${Get.find<DashboardReportController>().start.millisecondsSinceEpoch}'),
                        ),
                        IconButton(
                          icon: const Icon(Icons.share),
                          onPressed: () => sharePdf(
                              Get.find<DashboardReportController>()
                                  .device!
                                  .vehicleNumber,
                              'Báo cáo hành trình ${Get.find<DashboardReportController>().device!.vehicleNumber}_${Get.find<DashboardReportController>().start.millisecondsSinceEpoch}'),
                        )
                      ]),
            body: controller.reportModel == null
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
                        child: PaginatedDataTable(
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
                      )),
                    ],
                  )));
  }

  Future<void> downloadPdf(String vehicleNumber, String fileName) async {
    ReportModel report = Get.find<DashboardReportController>().reportModel!;
    List<DataModel> listDatas = report.listData!;
    List<DataModel> data = [];

    if (listDatas.isNotEmpty) data.add(listDatas[0]);
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
    // data.add(listDatas[listDatas.length]);
    var chunks = [];
    int chunkSize = 300;
    for (var i = 0; i < data.length; i += chunkSize) {
      chunks.add(data.sublist(
          i, i + chunkSize > data.length ? data.length : i + chunkSize));
    }

    final pdf = pw.Document();
    List<pw.Table> dataArr = [];
    for (int i = 0; i < chunks.length; i++) {
      var item = await tableCon(chunks[i], i);
      dataArr.add(item);
    }
    // final table = await tableCon(data);
    // final table2 = await tableCon(data);

    final font = await PdfGoogleFonts.nunitoBold();
    final fontI = await PdfGoogleFonts.nunitoItalic();

    // final Uint8List fontData = File('open-sans.ttf').readAsBytesSync();
    // final ttf = pw.Font.ttf(fontData.buffer.asByteData());

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          var it = pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.center,
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              mainAxisSize: pw.MainAxisSize.max,
              children: [
                pw.Container(
                  child: pw.Text('Hành trình xe chạy'.toUpperCase(),
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(
                        fontSize: 20,
                        font: font,
                      )),
                ),
                pw.Text(
                    'Từ ${DateFormat('HH:mm dd-MM-yyyy').format(Get.find<DashboardReportController>().start)} đến ${DateFormat('HH:mm dd-MM-yyyy').format(Get.find<DashboardReportController>().end)}',
                    style: pw.TextStyle(font: fontI)),
                pw.Text('Đơn vị kinh doanh vận tải: ....................',
                    style: pw.TextStyle(font: fontI)),
                pw.Text('Biển số xe: $vehicleNumber',
                    style: pw.TextStyle(font: fontI)),
                pw.Divider(
                  color: PdfColors.grey,
                ),
              ]);
          List<pw.Widget> result = [];
          result.add(it);
          for (int i = 0; i < dataArr.length; i++) {
            result.add(dataArr[i]);
          }
          return result.map((e) => e).toList();
        },
      ),
    );

    final path = (await getApplicationDocumentsDirectory()).path;
    final file = File("$path/$fileName.pdf");
    await file.writeAsBytes(await pdf.save());
    OpenFile.open('$path/$fileName.pdf');
  }

  Future<pw.Table> tableCon(List<DataModel> data, int step) async {
    final font = await PdfGoogleFonts.nunitoExtraLight();

    const tableHeaders = ['#', 'Thời điểm', 'Tọa độ', 'Địa điểm', 'Ghi chú'];

    final table = pw.Table.fromTextArray(
      columnWidths: const {
        0: pw.FixedColumnWidth(30),
        1: pw.FlexColumnWidth(2),
        2: pw.FlexColumnWidth(2.2),
        3: pw.FlexColumnWidth(4),
        4: pw.FlexColumnWidth(1),
      },
      cellStyle: pw.TextStyle(font: font, fontSize: 10),
      border: null,
      headers: tableHeaders,
      data: List<List<dynamic>>.generate(
        data.length,
        (index) => <dynamic>[
          step * 300 + index + 1,
          DateFormat('HH:mm dd-MM-yyyy').format(data[index].dateSave),
          '${data[index].latitude},${data[index].longitude}',
          data[index].addr,
          data[index].speed == 0 ? 'Dừng' : '',
        ],
      ),
      headerStyle: pw.TextStyle(
        font: font,
        color: PdfColors.black,
        fontWeight: pw.FontWeight.bold,
      ),
      rowDecoration: const pw.BoxDecoration(
        border: pw.Border(
          bottom: pw.BorderSide(
            width: .5,
          ),
        ),
      ),
      cellAlignment: pw.Alignment.center,
      cellAlignments: {
        0: pw.Alignment.centerLeft,
        3: pw.Alignment.centerRight,
        4: pw.Alignment.centerRight
      },
    );
    return table;
  }

  Future<void> sharePdf(String vehicleNumber, String fileName) async {
    await downloadPdf(vehicleNumber, fileName);
    final path = (await getApplicationDocumentsDirectory()).path;
    Share.shareFiles(['$path/$fileName.pdf']);
  }
}

// The "soruce" of the table
class MyData extends DataTableSource {
  // Generate some made-up data
  final List<DataModel> _data =
      Get.find<DashboardReportController>().getDataReportHistory();

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
