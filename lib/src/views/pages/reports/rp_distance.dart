import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:khn_tracking/src/core/controllers/dashboard_report.dart';
import 'package:khn_tracking/src/models/report_distance.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:share_plus/share_plus.dart';

import '_report.dart';

class ReportDistance extends StatelessWidget {
  const ReportDistance({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String verhicleNumber =
        Get.find<DashboardReportController>().device!.vehicleNumber;
    ReportModel? data = Get.find<DashboardReportController>().reportModel;
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => {Get.back()},
          ),
          centerTitle: true,
          title: const Text('Báo cáo quãng đường'),
          actions: data == null
              ? []
              : [
                  IconButton(
                    icon: const Icon(Icons.download),
                    onPressed: () => downloadPdf(
                        Get.find<DashboardReportController>()
                            .device!
                            .vehicleNumber,
                        'Báo cáo quãng đường ${verhicleNumber}_${Get.find<DashboardReportController>().start.millisecondsSinceEpoch}'),
                  ),
                  IconButton(
                    icon: const Icon(Icons.share),
                    onPressed: () => sharePdf(
                        Get.find<DashboardReportController>()
                            .device!
                            .vehicleNumber,
                        'Báo cáo quãng đường ${verhicleNumber}_${Get.find<DashboardReportController>().start.millisecondsSinceEpoch}'),
                  )
                ]),
      body: data == null
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
                            columns: const <DataColumn>[
                              DataColumn(
                                label: Text(
                                  'Biển số',
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Từ lúc',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                ),
                              ),
                              DataColumn(
                                label: SizedBox(
                                  width: 80,
                                  child: Text(
                                    'Đến lúc',
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style:
                                        TextStyle(fontStyle: FontStyle.italic),
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: SizedBox(
                                  width: 50,
                                  child: Text(
                                    'Quãng đường (km)',
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
                                    'Vận tốc trung bình (km/h)',
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
                                    'Tốc độ tối đa (km/h)',
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 4,
                                    style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                            rows: <DataRow>[
                              DataRow(
                                cells: <DataCell>[
                                  DataCell(Text(
                                      Get.find<DashboardReportController>()
                                          .device!
                                          .vehicleNumber
                                          .toString())),
                                  DataCell(SizedBox(
                                      width: 80,
                                      child: Text(
                                        DateFormat('dd-MM-yyyy HH:mm').format(
                                            Get.find<
                                                    DashboardReportController>()
                                                .start),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                      ))),
                                  DataCell(SizedBox(
                                      width: 80,
                                      child: Text(
                                        DateFormat('dd-MM-yyyy HH:mm').format(
                                            Get.find<
                                                    DashboardReportController>()
                                                .end),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                      ))),
                                  DataCell(Text(data.distances.toString())),
                                  DataCell(Text(data.speedAVG.toString())),
                                  DataCell(Text(data.speedMax.toString())),
                                ],
                              ),
                            ],
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

  Future<void> downloadPdf(String vehicleNumber, String fileName) async {
    ReportModel report = Get.find<DashboardReportController>().reportModel!;

    final pdf = pw.Document();

    final table = await tableCon(report, vehicleNumber);
    // final table2 = await tableCon(data);

    final font = await PdfGoogleFonts.nunitoBold();
    final fontI = await PdfGoogleFonts.nunitoItalic();

    // final Uint8List fontData = File('open-sans.ttf').readAsBytesSync();
    // final ttf = pw.Font.ttf(fontData.buffer.asByteData());

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        orientation: pw.PageOrientation.natural,
        build: (pw.Context context) {
          return pw.Column(children: [
            pw.Column(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                crossAxisAlignment: pw.CrossAxisAlignment.center,
                mainAxisSize: pw.MainAxisSize.max,
                children: [
                  pw.Container(
                    child: pw.Text('Báo cáo quãng đường'.toUpperCase(),
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
                ]),
            table
          ]);
        },
      ),
    );

    final path = (await getApplicationDocumentsDirectory()).path;
    final file = File("$path/$fileName.pdf");
    await file.writeAsBytes(await pdf.save());
    OpenFile.open('$path/$fileName.pdf');
  }

  Future<pw.Table> tableCon(ReportModel data, String vehicleNumber) async {
    final font = await PdfGoogleFonts.nunitoExtraLight();

    const tableHeaders = [
      'Biển số',
      'Tổng quãng đường (km)',
      'Vận tốc trung bình (km/h)',
      'Vận tốc tối đa (km/h)'
    ];
    List<List<dynamic>> tableData = [
      [vehicleNumber, data.distances, data.speedAVG, data.speedMax]
    ];
    final table = pw.Table.fromTextArray(
      columnWidths: const {
        0: pw.FlexColumnWidth(1),
        1: pw.FlexColumnWidth(1),
        2: pw.FlexColumnWidth(1),
        3: pw.FlexColumnWidth(1),
      },
      cellStyle: pw.TextStyle(font: font, fontSize: 10),
      border: null,
      headers: tableHeaders,
      data: tableData,
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
