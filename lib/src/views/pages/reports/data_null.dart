import 'package:flutter/material.dart';

class DataNullable extends StatelessWidget {
  DataNullable({Key? key, this.message}) : super(key: key);
  String? message;

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(message ?? 'Không tìm thấy dữ liệu...'));
  }
}
