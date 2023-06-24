import 'package:flutter/material.dart';

import '../../widgets/text_column.dart';

class EducationTextColumn extends StatelessWidget {
  const EducationTextColumn({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const TextColumn(
      title: 'Đơn giản',
      text:
          'Giao diện trực quan, đầy đủ đáp ứng cho cá nhân, doanh nghiệp vận tải.',
    );
  }
}
