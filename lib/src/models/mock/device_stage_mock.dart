import 'device_mock.dart';

class DeviceStageMock extends DeviceMock {
  double lat;
  double lng;
  double speed = 0.0;
  int status;
  String address;
  DateTime dateSave;

  DeviceStageMock({
    deviceId,
    verticalNumber,
    imei,
    type,
    required this.lat,
    required this.lng,
    required this.speed,
    required this.status,
    required this.address,
    required this.dateSave,
  }) : super(
          deviceId: deviceId,
          verticalNumber: verticalNumber,
          imei: imei,
          type: type,
        );
}

List<DeviceStageMock> getDeviceStageMock() {
  return [
    DeviceStageMock(
      deviceId: 2253,
      verticalNumber: '59F1-01122',
      imei: '999999999999',
      lat: 10.88790,
      lng: 106.71819,
      speed: 38.4,
      status: 1,
      address: "71 Ấp Bắc, Phường 10, Mỹ Tho, Tiền Giang, Việt Nam",
      type: 0,
      dateSave: DateTime.parse("2021-11-03 18:49:50Z"),
    ),
    DeviceStageMock(
      deviceId: 2245,
      verticalNumber: '59F1-01121',
      imei: '999999999999',
      lat: 10.01450,
      lng: 105.77900,
      speed: 38.4,
      status: 1,
      address: "QL 1, Tân Hòa, Tp. Biên Hòa, Đồng Nai",
      type: 0,
      dateSave: DateTime.parse("2020-08-12 08:17:07Z"),
    ),
    DeviceStageMock(
      deviceId: 2242,
      verticalNumber: '59F1-01124',
      imei: '999999999999',
      lat: 13.97843,
      lng: 108.00025,
      speed: 38.4,
      status: 3,
      address: "QL 1, Hàm Thuận Bắc, Bình Thuận",
      type: 0,
      dateSave: DateTime.parse("2021-11-06 08:40:58Z"),
    ),
    DeviceStageMock(
      deviceId: 2237,
      verticalNumber: '59F1-21122',
      imei: '999999999999',
      lat: 11.25369,
      lng: 106.28384,
      speed: 38.4,
      status: 2,
      address: "ĐT823, Đức Hạnh 2, Đức Lập Hạ, Đức Hòa, Long An",
      type: 0,
      dateSave: DateTime.parse("2021-08-20 10:37:05Z"),
    ),
    DeviceStageMock(
      deviceId: 1,
      verticalNumber: '51F1-01122',
      imei: '999999999999',
      lat: 10.97962,
      lng: 106.66374,
      speed: 38.4,
      status: 3,
      address: "QL 1, Xuân Lộc, Đồng Nai",
      type: 0,
      dateSave: DateTime.parse("2021-10-31 09:26:44Z"),
    ),
    DeviceStageMock(
      deviceId: 1,
      verticalNumber: '51S1-01122',
      imei: '999999999999',
      lat: 10.82370,
      lng: 106.76500,
      speed: 38.4,
      status: 4,
      address: "139 Phạm Ngũ Lão, Hiệp Thành, Thủ Dầu Một, Bình Dương",
      type: 0,
      dateSave: DateTime.parse("2021-07-26 12:12:55Z"),
    ),
    DeviceStageMock(
      deviceId: 1,
      verticalNumber: '59F4-01122',
      imei: '999999999999',
      lat: 10.73438,
      lng: 106.68118,
      speed: 38.4,
      status: 1,
      address: "QL 1, Quảng Trạch, Quảng Bình",
      type: 0,
      dateSave: DateTime.parse("2021-11-03 09:46:26Z"),
    ),
  ];
}
