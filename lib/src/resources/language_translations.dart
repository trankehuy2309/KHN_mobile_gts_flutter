import 'package:get/get.dart';

import 'value/st_en_us.dart';
import 'value/st_vi_vn.dart';

class LanguageTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': en,
        'vi_VN': vi,
      };
}
