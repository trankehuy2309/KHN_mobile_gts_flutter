import 'device_mock.dart';

class ListDataMock extends DeviceMock {
  DateTime timeFrom;
  DateTime timeTo;
  List<DataMock> listData;

  ListDataMock({
    deviceId,
    verticalNumber,
    imei,
    type,
    required this.timeFrom,
    required this.timeTo,
    required this.listData,
  }) : super(
          deviceId: deviceId,
          verticalNumber: verticalNumber,
          imei: imei,
          type: type,
        );
}

class DataMock {
  double lat;
  double lng;
  double speed = 0.0;
  int status;
  String? address;
  DateTime dateSave;

  DataMock({
    required this.lat,
    required this.lng,
    required this.speed,
    required this.status,
    this.address,
    required this.dateSave,
  });
}

ListDataMock getListDataMock() {
  return ListDataMock(
    timeFrom: DateTime.parse("2021-11-03 18:49:50Z"),
    timeTo: DateTime.parse("2021-11-03 19:49:50Z"),
    deviceId: 2253,
    verticalNumber: '59F1-01122',
    imei: '999999999999',
    type: 0,
    listData: [
      DataMock(
        lat: 10.85782,
        lng: 106.66603,
        speed: 38.4,
        status: 1,
        dateSave: DateTime.parse("2021-11-03 06:07:23Z"),
      ),
      DataMock(
        lat: 10.86158,
        lng: 106.67136,
        speed: 38.4,
        status: 1,
        dateSave: DateTime.parse("2021-11-03 06:14:18Z"),
      ),
      DataMock(
        lat: 10.86074,
        lng: 106.69041,
        speed: 22.4,
        status: 1,
        dateSave: DateTime.parse("2021-11-03 06:17:18Z"),
      ),
      DataMock(
        lat: 10.85911,
        lng: 106.70649,
        speed: 14.4,
        status: 1,
        dateSave: DateTime.parse("2021-11-03 06:20:38Z"),
      ),
      DataMock(
        lat: 10.86005,
        lng: 106.71372,
        speed: 15.4,
        status: 1,
        dateSave: DateTime.parse("2021-11-03 06:21:38Z"),
      ),
      DataMock(
        lat: 10.87381,
        lng: 106.74634,
        speed: 14.4,
        status: 1,
        dateSave: DateTime.parse("2021-11-03 06:25:58Z"),
      ),
      DataMock(
        lat: 10.87091,
        lng: 106.77208,
        speed: 22.4,
        status: 1,
        dateSave: DateTime.parse("2021-11-03 06:29:38Z"),
      ),
    ],
  );
}
