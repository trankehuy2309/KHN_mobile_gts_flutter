import 'package:flutter/material.dart';

import '../../widgets/text_column.dart';

class WorkTextColumn extends StatelessWidget {
  const WorkTextColumn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const TextColumn(
      title: 'Hiệu quả',
      text: 'Giám sát hành trình, truyền phát trực tiếp dữ liệu hành trình.',
    );
  }
}
