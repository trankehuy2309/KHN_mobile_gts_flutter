import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeviceEditInfo extends StatefulWidget {
  const DeviceEditInfo({Key? key}) : super(key: key);

  @override
  _DeviceEditInfoState createState() => _DeviceEditInfoState();
}

class _DeviceEditInfoState extends State<DeviceEditInfo> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => {Get.back()},
        ),
        title: const Text('Sửa thiết bị'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ListTile(
                  minLeadingWidth: 10.0,
                  horizontalTitleGap: 5,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: Text('Tên thiết bị'),
                      ),
                      Flexible(
                        child: TextField(
                          textInputAction: TextInputAction.next,
                          textAlign: TextAlign.end,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Audi 01',
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                ListTile(
                  minLeadingWidth: 10.0,
                  horizontalTitleGap: 5,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: Text('Biển số xe'),
                      ),
                      Flexible(
                        child: TextField(
                          textInputAction: TextInputAction.next,
                          textAlign: TextAlign.end,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: '123456',
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                ListTile(
                  minLeadingWidth: 10.0,
                  horizontalTitleGap: 5,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: Text('Tên lái xe'),
                      ),
                      Flexible(
                        child: TextField(
                          textInputAction: TextInputAction.next,
                          textAlign: TextAlign.end,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Nguyễn Văn A',
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                ListTile(
                  minLeadingWidth: 10.0,
                  horizontalTitleGap: 5,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: Text('Số liên lạc'),
                      ),
                      Flexible(
                        child: TextField(
                          textInputAction: TextInputAction.done,
                          textAlign: TextAlign.end,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: '0123456789',
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                ListTile(
                  minLeadingWidth: 10.0,
                  horizontalTitleGap: 5,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: Text('Biểu tượng'),
                      ),
                      Expanded(
                        flex: 1,
                        child: Wrap(
                          direction: Axis.horizontal,
                          spacing: 0,
                          children: [
                            IconButton(
                              padding: const EdgeInsets.all(0),
                              iconSize: 20,
                              icon: const Icon(Icons.car_rental),
                              onPressed: () {},
                            ),
                            IconButton(
                              padding: const EdgeInsets.all(0),
                              iconSize: 20,
                              icon: const Icon(Icons.bus_alert_rounded),
                              onPressed: () {},
                            ),
                            IconButton(
                              iconSize: 20,
                              icon: const Icon(Icons.taxi_alert),
                              onPressed: () {},
                            ),
                            IconButton(
                              iconSize: 20,
                              icon: const Icon(Icons.taxi_alert),
                              onPressed: () {},
                            ),
                            IconButton(
                              iconSize: 20,
                              color: Theme.of(context).primaryColor,
                              icon: const Icon(Icons.taxi_alert),
                              onPressed: () {},
                            ),
                            IconButton(
                              iconSize: 20,
                              icon: const Icon(Icons.arrow_forward_ios_sharp),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // ListTile(
                //   minLeadingWidth: 10.0,
                //   horizontalTitleGap: 5,
                //   title: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       Padding(
                //         padding: const EdgeInsets.only(right: 8.0),
                //         child: Text('Số liên lạc'),
                //       ),
                //       Container(
                //           child: ListView.builder(
                //               physics: const NeverScrollableScrollPhysics(),
                //               shrinkWrap: true,
                //               itemCount: 18,
                //               itemBuilder: (context, index) {
                //                 return Text('Some text');
                //               }))
                //     ],
                //   ),
                // ),
                SizedBox(
                  width: double.infinity,
                  // height: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text('Lưu'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ListIconDevice {
  IconData iconData;
  bool? isVisable = false;
  ListIconDevice({required this.iconData, this.isVisable});
}

List<ListIconDevice> getListIconDevice() {
  return [
    ListIconDevice(
      iconData: Icons.safety_divider,
      isVisable: true,
    ),
    ListIconDevice(
      iconData: Icons.car_rental,
    ),
    ListIconDevice(
      iconData: Icons.safety_divider_rounded,
    ),
    ListIconDevice(
      iconData: Icons.h_mobiledata,
    ),
    ListIconDevice(
      iconData: Icons.verified,
    ),
  ];
}
