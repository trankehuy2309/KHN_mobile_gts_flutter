// ignore_for_file: non_constant_identifier_names

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:khn_tracking/src/core/controllers/dashboard_report.dart';
import 'package:khn_tracking/src/models/report_distance.dart';

import '_report.dart';

class ReportLineOil extends StatelessWidget {
  ReportLineOil({Key? key}) : super(key: key);
  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];
  String verhicleNumber =
      Get.find<DashboardReportController>().device!.vehicleNumber;
  ReportOilModel? dataM = Get.find<DashboardReportController>().reportOil;
  DateTime timeStart = Get.find<DashboardReportController>().start;
  DateTime timeEnd = Get.find<DashboardReportController>().end;
  int f = (Get.find<DashboardReportController>()
      .end
      .difference(Get.find<DashboardReportController>().start)
      .inHours);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => {Get.back()},
        ),
        centerTitle: true,
        title: const Text('Biểu đồ xăng dầu'),
      ),
      body: dataM == null
          ? DataNullable()
          : Container(
              decoration: BoxDecoration(
                  // borderRadius: BorderRadius.all(
                  //   Radius.circular(18),
                  // ),
                  color: dataM!.flagFuel == 1
                      ? const Color(0xff232d37)
                      : Colors.transparent),
              child: Center(
                child: dataM!.flagFuel == 0
                    ? DataNullable(
                        message: 'Thiết bị chưa tích hợp cảm biến xăng dầu.')
                    : ListView(
                        children: [
                          SizedBox(
                            height: 24,
                            child: ListTile(
                              title: Text('Biển số xe:  $verhicleNumber',
                                  style: const TextStyle(color: Colors.white)),
                              dense: true,
                            ),
                          ),
                          SizedBox(
                            height: 50,
                            child: ListTile(
                              title: const Text('Thời gian',
                                  style: TextStyle(color: Colors.white)),
                              dense: true,
                              subtitle: Text(
                                  '${DateFormat('HH:mm dd-MM-yyyy').format(Get.find<DashboardReportController>().start)} - ${DateFormat('HH:mm dd-MM-yyyy').format(Get.find<DashboardReportController>().end)}',
                                  style: const TextStyle(color: Colors.white)),
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          Stack(
                            children: <Widget>[
                              AspectRatio(
                                aspectRatio: 1.70,
                                child: Container(
                                  decoration: const BoxDecoration(
                                      // borderRadius: BorderRadius.all(
                                      //   Radius.circular(18),
                                      // ),
                                      color: Color(0xff232d37)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        right: 18.0,
                                        left: 12.0,
                                        top: 24,
                                        bottom: 12),
                                    child: LineChart(
                                      mainData(),
                                    ),
                                  ),
                                ),
                              ),
                              // SizedBox(
                              //   width: 60,
                              //   height: 34,
                              //   child: TextButton(
                              //     onPressed: () {},
                              //     child: Text(
                              //       'Oil',
                              //       style:
                              //           TextStyle(fontSize: 12, color: Colors.white),
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                        ],
                      ),
              ),
            ),
    );
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 0.5,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 0.5,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: SideTitles(showTitles: false),
        topTitles: SideTitles(showTitles: false),
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          interval: 1,
          getTextStyles: (context, value) => const TextStyle(
              color: Color(0xff68737d),
              fontWeight: FontWeight.bold,
              fontSize: 16),
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return TimeCalc(1);
              case 2:
                return TimeCalc(2);
              case 3:
                return TimeCalc(3);
              case 4:
                return TimeCalc(4);
              case 5:
                return TimeCalc(5);
              case 6:
                return TimeCalc(6);
            }
            return '';
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          interval: 1,
          getTextStyles: (context, value) => const TextStyle(
            color: Color(0xff67727d),
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 100:
                return '100 lít';
              case 200:
                return '200 lít';
              case 300:
                return '300 lít';
              case 400:
                return '400 lít';
              case 500:
                return '500 lít';
              case 600:
                return '600 lít';
              case 700:
                return '700 lít';
              case 800:
                return '800 lít';
              case 900:
                return '900 lít';
              case 1000:
                return '1000 lít';
            }
            return '';
          },
          reservedSize: 32,
          margin: 12,
        ),
      ),
      borderData: FlBorderData(
          show: true,
          border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: 0,
      maxX: 6,
      minY: 0,
      maxY: dataM!.volumeOilBarrel.toDouble(),
      lineBarsData: [
        LineChartBarData(
          spots: dataM!.data!.map((e) {
            FlSpot f = FlSpot(TimeToDecl(e.dateSave), e.oilValue.toDouble());
            return f;
          }).toList(),
          isCurved: true,
          colors: gradientColors,
          barWidth: 2,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors:
                gradientColors.map((color) => color.withOpacity(0.3)).toList(),
          ),
        ),
      ],
    );
  }

  double TimeToDecl(DateTime timeC) {
    int e = timeC.difference(timeStart).inMinutes;
    return (e * 1.0 / 60) * 6 / f;
  }

  String TimeCalc(int caseI) {
    double f = (timeEnd.difference(timeStart).inHours) * 4 / 24;

    return DateFormat('HH:mm')
        .format(timeStart.add(Duration(hours: caseI * f.round())));
  }
}
