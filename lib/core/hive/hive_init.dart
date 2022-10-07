
import 'package:hive_flutter/hive_flutter.dart';

import '../../constants/string.dart';
import '../../data/model/hive/settings.dart';

class HiveInit {
  static Future<void> fireUp() async {
    await Hive.initFlutter(AppString.shortName);
    Hive.registerAdapter(SettingsAdapter());
  }
}
