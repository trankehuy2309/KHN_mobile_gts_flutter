class ReportTotalDistance {
  String vehicleNumber;
  DateTime timeFrom;
  DateTime timeTo;
  double totalDistance;
  double speedAvg;
  double speedMax;

  ReportTotalDistance(
      {required this.vehicleNumber,
      required this.timeFrom,
      required this.timeTo,
      required this.totalDistance,
      required this.speedAvg,
      required this.speedMax});
}

ReportTotalDistance getReportTotalDistance() {
  return ReportTotalDistance(
    vehicleNumber: '51B-11111',
    timeFrom: DateTime.parse("2021-11-03 06:20:38Z"),
    timeTo: DateTime.parse("2021-11-03 23:20:38Z"),
    totalDistance: 40.0,
    speedAvg: 30.0,
    speedMax: 50.0,
  );
}
