import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khn_tracking/src/views/pages/report_del/widgets/tab_search_widget.dart';

import '../control_page.dart';
import 'widgets/end_draw_widget.dart';
import 'widgets/menu_widget.dart';

class ReportDriverPage extends StatefulWidget {
  const ReportDriverPage({Key? key}) : super(key: key);

  @override
  _ReportDriverPageState createState() => _ReportDriverPageState();
}

class _ReportDriverPageState extends State<ReportDriverPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      endDrawer: const EndDrawReport(),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => {Get.to(() => const ControlPage())},
        ),
        title: const Text('Báo cáo HĐ tài xế'),
        centerTitle: true,
        actions: const [
          PopUpMenuWidget(),
        ],
      ),
      body: Stack(children: const [
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: TabSearchWidget(),
        )
      ]),
    );
  }
}
