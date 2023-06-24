// ignore_for_file: file_names
// import 'package:flutter/material.dart';
// import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:khn_tracking/src/core/controllers/_controller.dart';

// class TabSearchWidget extends StatelessWidget {
//   const TabSearchWidget({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     ReportController c = Get.put(ReportController());
//     return c.searchSuss.value == 0
//         ? const TabSearchFirstWidget()
//         : const TabSearchSecondWidget();
//   }
// }

// class TabSearchFirstWidget extends StatefulWidget {
//   const TabSearchFirstWidget({Key? key}) : super(key: key);

//   @override
//   _TabSearchFirstState createState() => _TabSearchFirstState();
// }

// class _TabSearchFirstState extends State<TabSearchFirstWidget> {
//   final _formKey = GlobalKey<FormState>();
//   final _formKey2 = GlobalKey<FormState>();
//   DateTime? timeStart = null, timeEnd = null;

//   @override
//   Widget build(BuildContext context) {
//     ReportController c = Get.put(ReportController());
//     return DefaultTabController(
//       length: 4, // length of tabs
//       initialIndex: 0,
//       child: Container(
//         color: Colors.white,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: <Widget>[
//             TabBar(
//               labelColor: Theme.of(context).primaryColor,
//               unselectedLabelColor: Colors.grey,
//               tabs: [
//                 Tab(text: 'Hôm nay'),
//                 Tab(text: 'Hôm qua'),
//                 Tab(text: 'Tuần này'),
//                 Tab(text: 'Tuần trước'),
//               ],
//             ),
//             Container(
//                 height: 220, //height of TabBarView
//                 decoration: BoxDecoration(
//                   border: Border(
//                     top: BorderSide(color: Colors.grey, width: 0.5),
//                   ),
//                 ),
//                 child: TabBarView(children: <Widget>[
//                   Container(
//                       child: Form(
//                     key: _formKey,
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         ListTile(
//                           minVerticalPadding: 0.0,
//                           minLeadingWidth: 10.0,
//                           horizontalTitleGap: 5,
//                           leading: Icon(Icons.lock_clock,
//                               color: Theme.of(context).primaryColor),
//                           title: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsets.only(right: 8.0),
//                                 child: Text('Bắt đầu'),
//                               ),
//                               Flexible(
//                                 child: TextButton(
//                                     onPressed: () {
//                                       DatePicker.showDateTimePicker(context,
//                                           showTitleActions: true,
//                                           // minTime: DateTime(2021, 5, 5, 20, 50),
//                                           maxTime: TProcess.getNow(),
//                                           onChanged: (date) {},
//                                           onConfirm: (date) {
//                                         setState(() {
//                                           timeStart = date as DateTime;
//                                         });
//                                       }, locale: LocaleType.vi);
//                                     },
//                                     child: Text(
//                                       '${timeStart != null ? timeToString(timeStart!, 1) : timeToString(TProcess.getFirstDay(), 1)}',
//                                     )),
//                               ),
//                             ],
//                           ),
//                         ),
//                         ListTile(
//                           minVerticalPadding: 0.0,
//                           minLeadingWidth: 10.0,
//                           horizontalTitleGap: 5,
//                           leading: Icon(Icons.lock_clock,
//                               color: Theme.of(context).primaryColor),
//                           title: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsets.only(right: 8.0),
//                                 child: Text('Kết thúc'),
//                               ),
//                               Flexible(
//                                 child: TextButton(
//                                     onPressed: () {
//                                       DatePicker.showDateTimePicker(context,
//                                           showTitleActions: true,
//                                           minTime: timeStart != null
//                                               ? timeStart
//                                               : DateTime(2020, 1, 1, 0, 0),
//                                           maxTime: TProcess.getNow(),
//                                           onChanged: (date) {
//                                         print('change $date in time zone ' +
//                                             date.timeZoneOffset.inHours
//                                                 .toString());
//                                       }, onConfirm: (date) {
//                                         setState(() {
//                                           timeEnd = date;
//                                         });
//                                       }, locale: LocaleType.vi);
//                                     },
//                                     child: Text(
//                                       '${timeEnd != null ? timeToString(timeEnd!, 1) : timeToString(TProcess.getNow(), 1)}',
//                                     )),
//                               ),
//                             ],
//                           ),
//                         ),
//                         ListTile(
//                           minLeadingWidth: 10.0,
//                           horizontalTitleGap: 5,
//                           leading: Icon(Icons.lock_clock,
//                               color: Theme.of(context).primaryColor),
//                           title: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsets.only(right: 8.0),
//                                 child: Text('Thiết bị'),
//                               ),
//                               Flexible(
//                                 child: TextButton(
//                                     onPressed: () {
//                                       Scaffold.of(context).openEndDrawer();
//                                     },
//                                     child: Text(
//                                       '51F9-99999',
//                                       style: TextStyle(color: Colors.blue),
//                                     )),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceAround,
//                           children: [
//                             ElevatedButton(
//                               child: Text('Xác nhận'),
//                               onPressed: () {
//                                 c.toggleSearchSuss();
//                                 print(c.searchSuss.value);
//                               },
//                               style: ElevatedButton.styleFrom(
//                                 fixedSize: const Size(120, 40),
//                               ),
//                             ),
//                             ElevatedButton(
//                               child: Text('Hủy'),
//                               onPressed: () {},
//                               style: ElevatedButton.styleFrom(
//                                 fixedSize: const Size(120, 40),
//                                 primary: Colors.grey,
//                               ),
//                             ),
//                           ],
//                         )
//                       ],
//                     ),
//                   )),
//                   Container(
//                       child: Form(
//                     key: _formKey2,
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         ListTile(
//                           minVerticalPadding: 0.0,
//                           minLeadingWidth: 10.0,
//                           horizontalTitleGap: 5,
//                           leading: Icon(Icons.lock_clock,
//                               color: Theme.of(context).primaryColor),
//                           title: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsets.only(right: 8.0),
//                                 child: Text('Bắt đầu'),
//                               ),
//                               Flexible(
//                                 child: TextButton(
//                                     onPressed: () {
//                                       DatePicker.showDateTimePicker(context,
//                                           showTitleActions: true,
//                                           // minTime: DateTime(2021, 5, 5, 20, 50),
//                                           maxTime: TProcess.getNow(),
//                                           onChanged: (date) {
//                                         print('change $date in time zone ' +
//                                             date.timeZoneOffset.inHours
//                                                 .toString());
//                                       }, onConfirm: (date) {
//                                         setState(() {
//                                           timeStart = date as DateTime;
//                                         });
//                                       }, locale: LocaleType.vi);
//                                     },
//                                     child: Text(
//                                       '${timeStart != null ? timeToString(timeStart!, 1) : timeToString(DProcess.getFirstDayOfWeek(), 1)}',
//                                     )),
//                               ),
//                             ],
//                           ),
//                         ),
//                         ListTile(
//                           minVerticalPadding: 0.0,
//                           minLeadingWidth: 10.0,
//                           horizontalTitleGap: 5,
//                           leading: Icon(Icons.lock_clock,
//                               color: Theme.of(context).primaryColor),
//                           title: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsets.only(right: 8.0),
//                                 child: Text('Kết thúc'),
//                               ),
//                               Flexible(
//                                 child: TextButton(
//                                     onPressed: () {
//                                       DatePicker.showDateTimePicker(context,
//                                           showTitleActions: true,
//                                           minTime: timeStart != null
//                                               ? timeStart
//                                               : DateTime(2020, 1, 1, 0, 0),
//                                           maxTime: TProcess.getNow(),
//                                           onChanged: (date) {
//                                         print('change $date in time zone ' +
//                                             date.timeZoneOffset.inHours
//                                                 .toString());
//                                       }, onConfirm: (date) {
//                                         setState(() {
//                                           timeEnd = date;
//                                         });
//                                       }, locale: LocaleType.vi);
//                                     },
//                                     child: Text(
//                                       '${timeEnd != null ? timeToString(timeEnd!, 1) : timeToString(TProcess.getNow(), 1)}',
//                                     )),
//                               ),
//                             ],
//                           ),
//                         ),
//                         ListTile(
//                           minLeadingWidth: 10.0,
//                           horizontalTitleGap: 5,
//                           leading: Icon(Icons.lock_clock,
//                               color: Theme.of(context).primaryColor),
//                           title: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsets.only(right: 8.0),
//                                 child: Text('Thiết bị'),
//                               ),
//                               Flexible(
//                                 child: TextButton(
//                                     onPressed: () {
//                                       Scaffold.of(context).openEndDrawer();
//                                     },
//                                     child: Text(
//                                       '51F9-99999',
//                                       style: TextStyle(color: Colors.blue),
//                                     )),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceAround,
//                           children: [
//                             ElevatedButton(
//                               child: Text('Xác nhận'),
//                               onPressed: () {},
//                               style: ElevatedButton.styleFrom(
//                                 fixedSize: const Size(120, 40),
//                               ),
//                             ),
//                             ElevatedButton(
//                               child: Text('Hủy'),
//                               onPressed: () {},
//                               style: ElevatedButton.styleFrom(
//                                 fixedSize: const Size(120, 40),
//                                 primary: Colors.grey,
//                               ),
//                             ),
//                           ],
//                         )
//                       ],
//                     ),
//                   )),
//                   Container(
//                     child: Center(
//                       child: Text('Display Tab 3',
//                           style: TextStyle(
//                               fontSize: 22, fontWeight: FontWeight.bold)),
//                     ),
//                   ),
//                   Container(
//                     child: Center(
//                       child: Text('Display Tab 4',
//                           style: TextStyle(
//                               fontSize: 22, fontWeight: FontWeight.bold)),
//                     ),
//                   ),
//                 ]))
//           ],
//         ),
//       ),
//     );
//   }
// }

// class TProcess {
//   static DateTime dtNow = DateTime.now();

//   static DateTime getNow() {
//     return dtNow;
//   }

//   static DateTime getFirstDay() {
//     return DateTime(dtNow.year, dtNow.month, dtNow.day, 0, 0);
//   }

//   static DateTime getLastDay() {
//     return DateTime(dtNow.year, dtNow.month, dtNow.day, 0, 0);
//   }
// }

// class DProcess {
//   static DateTime dtNow = DateTime.now();
//   static DateTime getLasttDay() {
//     return DateTime(dtNow.year, dtNow.month, dtNow.day, 0, 0);
//   }

//   static DateTime getFirstDayOfWeek() {
//     var weekDay = dtNow.weekday;
//     return dtNow.subtract(Duration(days: weekDay));
//   }
// }

// class MProcess {}

// String timeToString(DateTime dt, int? type) {
//   //Type 0 -> dd-MM-yyyy
//   //Type 1 -> dd-MM-yyyy hh:mm
//   //Type 2 -> hh:mm:ss
//   var formatter = new DateFormat('dd-MM-yyyy HH:mm:ss');
//   switch (type) {
//     case 0:
//       {
//         formatter = new DateFormat('dd-MM-yyyy');
//         break;
//       }
//     case 1:
//       {
//         formatter = new DateFormat('dd-MM-yyyy HH:mm');
//         break;
//       }
//     case 2:
//       {
//         formatter = new DateFormat('HH:mm:ss');
//         break;
//       }
//     default:
//       {
//         break;
//       }
//   }
//   String formattedDate = formatter.format(dt);
//   return formattedDate;
// }

// class TabSearchSecondWidget extends StatefulWidget {
//   const TabSearchSecondWidget({Key? key}) : super(key: key);

//   @override
//   _TabSearchSecondWidgetState createState() => _TabSearchSecondWidgetState();
// }

// class _TabSearchSecondWidgetState extends State<TabSearchSecondWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }
