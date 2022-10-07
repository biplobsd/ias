import 'package:ias/data/model/hive/settings.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveInit {
  static Future<void> fireUp() async {
    await Hive.initFlutter();
    Hive.registerAdapter(SettingsAdapter());
  }
}
