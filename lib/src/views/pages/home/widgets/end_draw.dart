import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khn_tracking/src/core/controllers/device_controller_old.dart';
import 'package:khn_tracking/src/models/device_model.dart';

class EndDrawHome extends StatelessWidget {
  const EndDrawHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DeviceController>(
      init: Get.find<DeviceController>(),
      builder: (controller) => SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Drawer(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 150,
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
                ExpansionPanelList(
                  animationDuration: const Duration(milliseconds: 700),
                  expansionCallback: (int index, bool isExpanded) {
                    controller.toggle(index);
                  },
                  children: controller.listDGroup
                      .map<ExpansionPanel>((DeviceGroupModel item) {
                    return ExpansionPanel(
                      headerBuilder: (BuildContext context, bool isExpanded) {
                        return ListTile(
                          title: Text(item.vehicleGroup),
                          onTap: () {
                            controller.changeCurrentGroup(item.vehicleGroupID);
                            Navigator.of(context).pop();
                          },
                        );
                      },
                      body: item.listDvStage == null
                          ? const SizedBox(
                              child: CircularProgressIndicator(
                                  color: Colors.white),
                              height: 20.0,
                              width: 20.0,
                            )
                          : Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    children: item.listDvStage!
                                        .map<ListTile>((DeviceStageModel dv) {
                                      return ListTile(
                                        leading: const Icon(Icons.car_rental),
                                        title: Text(dv.vehicleNumber),
                                        onTap: () {
                                          controller.setCurentDv(dv.deviceID);
                                          Navigator.of(context).pop();
                                        },
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ],
                            ),
                      isExpanded: item.isShow,
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


/////////////////////
///
///Expanded(
//   child: ListView.builder(
//     padding: EdgeInsets.only(top: 0.0),
//     itemCount: controller.listDGroup.length,
//     itemBuilder: (context, index) {
//       return Ink(
//         color: true ? Colors.white : null,
//         child: ExpansionTile(
//           initiallyExpanded: true,
//           childrenPadding: EdgeInsets.all(16).copyWith(top: 0),
//           title: Text(
//             '👩 Sarah Pepperstone',
//             style: TextStyle(
//                 fontSize: 24, fontWeight: FontWeight.w500),
//           ),
//           children: [
//             Text(
//               'My name is Sarah and I am a New York City based Flutter developer. I help entrepreneurs & businesses figure out how to build scalable applications.\n\nWith over 7 years experience spanning across many industries from B2B to B2C, I live and breath Flutter.',
//               style: TextStyle(fontSize: 18, height: 1.4),
//             ),
//           ],
//         ),
//         // child: ListTile(
//         //   leading: Icon(
//         //     Icons.album,
//         //     color: controller.currentGroup == index
//         //         ? Colors.blue
//         //         : Colors.grey,
//         //   ),
//         //   title: Text(
//         //       '${controller.listDGroup[index].vehicleGroup} (${controller.listDGroup[index].countdv})'),
//         //   // trailing: Wrap(
//         //   //   spacing: 12, // space between two icons
//         //   //   children: <Widget>[
//         //   //     Icon(Icons.call), // icon-1
//         //   //     Icon(Icons.message), // icon-2
//         //   //   ],
//         //   // ),
//         //   trailing: IconButton(
//         //     icon: Icon(Icons.downhill_skiing),
//         //     onPressed: () => debugPrint('onPressed'),
//         //   ),
//         //   onTap: () {
//         //     controller.changeCurrentGroup(index);
//         //     Navigator.of(context).pop();
//         //   },
//         // ),
//       );
//     },
//   ),
// ),
//////////////////////////////