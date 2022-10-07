import 'package:preloadwebapptemplate/constants/string.dart';
import 'package:preloadwebapptemplate/data/model/hive/settings.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveInit {
  static Future<void> fireUp() async {
    await Hive.initFlutter(AppString.shortName);
    Hive.registerAdapter(SettingsAdapter());
  }
}
