import 'package:flutter/material.dart';

import '../../widgets/text_column.dart';

class CommunityTextColumn extends StatelessWidget {
  const CommunityTextColumn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const TextColumn(
      title: 'Dễ dàng',
      text: 'Theo dõi mọi hoạt động trên thiết bị của bạn.',
    );
  }
}
