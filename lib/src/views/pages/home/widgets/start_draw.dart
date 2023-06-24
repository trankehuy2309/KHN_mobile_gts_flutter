import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khn_tracking/src/core/controllers/device_controller_old.dart';
import 'package:khn_tracking/src/models/device_model.dart';

class StartDrawHome extends StatelessWidget {
  const StartDrawHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DeviceController>(
      init: Get.find<DeviceController>(),
      builder: (controller) => Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            SizedBox(
              child: DrawerHeader(
                decoration: const BoxDecoration(
                  color: Colors.blue,
                ),
                child: Stack(
                  children: [
                    Center(
                      child: Text(
                        'Danh sách xe'.toUpperCase(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      top: 0,
                      bottom: 0,
                      child: IconButton(
                        color: Colors.white,
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.only(top: 0.0),
                itemCount: 22,
                itemBuilder: (context, index) {
                  return Ink(
                    color: Colors.blueGrey,
                    child: ListTile(
                      title: const Text("profession.heading"),
                      onTap: () {},
                      leading: index == 0
                          ? const Icon(
                              Icons.home,
                            )
                          : const Icon(Icons.description),
                    ),
                  );
                },
              ),
            ),
          ],

          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.
          // child: ListView(
          //   scrollDirection: Axis.vertical,
          //   shrinkWrap: true,
          //   // Important: Remove any padding from the ListView.
          //   padding: EdgeInsets.zero,
          //   children: [
          //     Container(
          //       height: 100,
          //       child: DrawerHeader(
          //         decoration: BoxDecoration(
          //           color: Colors.blue,
          //         ),
          //         child: Stack(
          //           children: [
          //             Center(
          //               child: Text(
          //                 'Danh sách xe'.toUpperCase(),
          //                 textAlign: TextAlign.center,
          //                 style: TextStyle(
          //                   color: Colors.white,
          //                   fontSize: 20,
          //                   fontWeight: FontWeight.bold,
          //                 ),
          //               ),
          //             ),
          //             Positioned(
          //               left: 0,
          //               top: 0,
          //               bottom: 0,
          //               child: IconButton(
          //                 color: Colors.white,
          //                 icon: Icon(Icons.arrow_back),
          //                 onPressed: () {
          //                   Navigator.of(context).pop();
          //                 },
          //               ),
          //             )
          //           ],
          //         ),
          //       ),
          //     ),
          //     ListView.builder(
          //       scrollDirection: Axis.vertical,
          //       shrinkWrap: true,
          //       itemCount: controller.listDGroup.length,
          //       itemBuilder: (BuildContext context, int index) {
          //         return Card(
          //           child: Column(
          //             mainAxisSize: MainAxisSize.min,
          //             children: [
          //               Stack(
          //                 children: [
          //                   ListTile(
          //                     leading: Icon(Icons.album,
          //                         color: controller.currentGroup == index
          //                             ? Theme.of(context).primaryColor
          //                             : Colors.grey),
          //                     title: Text(
          //                         '${controller.listDGroup[index].vehicleGroup} (${controller.listDGroup[index].countdv})'),
          //                     onTap: () {
          //                       controller.changeCurrentGroup(index);
          //                       Navigator.of(context).pop();
          //                     },
          //                   ),
          //                   Positioned(
          //                     right: 0,
          //                     top: 0,
          //                     bottom: 0,
          //                     child: IconButton(
          //                         icon: Icon(Icons.arrow_drop_down),
          //                         color: Theme.of(context).primaryColor,
          //                         onPressed: () {
          //                           debugPrint('click');
          //                         }),
          //                   )
          //                 ],
          //               ),
          //               controller.currentGroup == index
          //                   ? ListView.builder(
          //                       scrollDirection: Axis.vertical,
          //                       shrinkWrap: true,
          //                       itemCount: controller.listDState.length,
          //                       itemBuilder: (BuildContext context, int index) {
          //                         return ItemCarHome(
          //                             data: controller.listDState[index]);
          //                       },
          //                     )
          //                   : Container(),
          //             ],
          //           ),
          //         );
          //       },
          //     ),
          //   ],
          // ),
        ),
      ),

      // Drawer(
      //   child: Padding(
      //     padding: const EdgeInsets.only(top: 30.0),
      //     child: Column(
      //       mainAxisAlignment: MainAxisAlignment.start,
      //       mainAxisSize: MainAxisSize.max,
      //       children: <Widget>[
      //         Padding(
      //             padding:
      //                 const EdgeInsets.only(top: 16.0, left: 8.0, right: 8.0),
      //             child: Row(
      //               children: [
      //                 Center(
      //                   child: Text(
      //                     'Danh sách xe'.toUpperCase(),
      //                     textAlign: TextAlign.center,
      //                     style: TextStyle(
      //                       fontSize: 20,
      //                       fontWeight: FontWeight.bold,
      //                       color: Theme.of(context).primaryColor,
      //                     ),
      //                   ),
      //                 ),
      //                 IconButton(
      //                     icon: Icon(Icons.arrow_back),
      //                     color: Theme.of(context).primaryColor,
      //                     onPressed: () {
      //                       Navigator.of(context).pop();
      //                     })
      //               ],
      //             )
      //             //  Center(
      //             //   child: ListTile(
      //             //     leading: Icon(Icons.album),
      //             //     title: Text(
      //             //       'Danh sách nhóm xe'.toUpperCase(),
      //             //       textAlign: TextAlign.center,
      //             //       style: TextStyle(
      //             //         fontSize: 20,
      //             //         fontWeight: FontWeight.bold,
      //             //         color: Theme.of(context).primaryColor,
      //             //       ),
      //             //     ),
      //             //     onTap: () {
      //             //       Navigator.pop(context);
      //             //     },
      //             //   ),
      //             // ),
      //             ),
      //         Padding(
      //           padding: const EdgeInsets.all(8.0),
      //           child: ListView.builder(
      //             scrollDirection: Axis.vertical,
      //             shrinkWrap: true,
      //             itemCount: controller.listDGroup.length,
      //             itemBuilder: (BuildContext context, int index) {
      //               return Card(
      //                 child: Column(
      //                   mainAxisSize: MainAxisSize.min,
      //                   children: [
      //                     Stack(
      //                       children: [
      //                         ListTile(
      //                           leading: Icon(Icons.album,
      //                               color: controller.currentGroup == index
      //                                   ? Theme.of(context).primaryColor
      //                                   : Colors.grey),
      //                           title: Text(
      //                               '${controller.listDGroup[index].vehicleGroup} (${controller.listDGroup[index].countdv})'),
      //                           onTap: () {
      //                             controller.changeCurrentGroup(index);
      //                             Navigator.of(context).pop();
      //                           },
      //                         ),
      //                         Positioned(
      //                           right: 0,
      //                           top: 0,
      //                           bottom: 0,
      //                           child: IconButton(
      //                               icon: Icon(Icons.arrow_drop_down),
      //                               color: Theme.of(context).primaryColor,
      //                               onPressed: () {
      //                                 debugPrint('click');
      //                               }),
      //                         )
      //                       ],
      //                     ),
      //                     controller.currentGroup == index
      //                         ? ListView.builder(
      //                             scrollDirection: Axis.vertical,
      //                             shrinkWrap: true,
      //                             itemCount: controller.listDState.length,
      //                             itemBuilder:
      //                                 (BuildContext context, int index) {
      //                               return ItemCarHome(
      //                                   data: controller.listDState[index]);
      //                             },
      //                           )
      //                         : Container(),
      //                   ],
      //                 ),
      //               );
      //             },
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}

class ItemCarHome extends StatelessWidget {
  DeviceStageModel data;

  ItemCarHome({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        ListTile(
          leading: const Icon(
            Icons.directions_car,
          ),
          title: Text(data.vehicleNumber),
          subtitle: const Text('a'),
        ),
      ]),
    );
  }
}
