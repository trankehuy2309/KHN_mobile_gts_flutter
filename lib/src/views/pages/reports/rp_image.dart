import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';

import '../../../core/controllers/dashboard_report.dart';
import '../../../helper/ulti.dart';
import '../../../models/report_model.dart';

class ReportImage extends StatelessWidget {
  const ReportImage({Key? key}) : super(key: key);

  void open(BuildContext context, final ReportImageModel item) => showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            child: PhotoView(
              tightMode: true,
              imageProvider: NetworkImage(item.relativeURL),
              heroAttributes: const PhotoViewHeroAttributes(tag: "someTag"),
            ),
          );
        },
      );
  @override
  Widget build(BuildContext context) {
    final List<ReportImageModel> data =
        Get.find<DashboardReportController>().listDataImg;
    final String vehicleNumber =
        Get.find<DashboardReportController>().device!.vehicleNumber;
    String title_ = 'BC hình ảnh ' + vehicleNumber;

    String noImg =
        "https://cdn.dribbble.com/users/77598/screenshots/16399264/media/d86ceb1ad552398787fb76f343080aa6.gif";
    if (data.isEmpty) {
      // ignore: unnecessary_new
      ReportImageModel obj = new ReportImageModel(
        relativeURL: noImg,
        timeImg: DateTime.now(),
        lat_: 0,
        long_: 0,
        addr: "",
      );
      data.add(obj);
    }
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => {Get.back()},
        ),
        centerTitle: true,
        title: Text(title_),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 4,
          mainAxisSpacing: 4,
          childAspectRatio: 1 / 1,
        ),
        itemCount: data.length,
        itemBuilder: (context, index) {
          return Card(
              margin: const EdgeInsets.all(4.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                      child: Image.network(
                        data[index].relativeURL,
                        //"https://cdn.dribbble.com/users/77598/screenshots/16399264/media/d86ceb1ad552398787fb76f343080aa6.gif",
                        fit: BoxFit.fill,
                      ),
                      onTap: () {
                        open(context, data[index]);
                      }),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment
                              .center, // Align however you like (i.e .centerRight, centerLeft)
                          child: Text(
                              data[index].camName! +
                                  "_" +
                                  timeToString(
                                    data[index].timeImg,
                                  ),
                              style: const TextStyle(
                                  fontSize: 12.0, fontWeight: FontWeight.bold)),
                        ),
                        const SizedBox(height: 8),
                        Text(data[index].addr!,
                            // '184/1 Nguyễn Văn Khối, Phường 9, quận Gò Vấp, Tp Hồ Chí Minh',
                            style: const TextStyle(fontSize: 11.0),
                            maxLines: 2),
                      ],
                    ),
                  )
                ],
              ));
        },
      ),
    );
  }
}
