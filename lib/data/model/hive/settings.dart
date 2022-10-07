import 'package:hive/hive.dart';

part 'settings.g.dart';

@HiveType(typeId: 0)
class Settings {
  @HiveField(0, defaultValue: false)
  bool privacyPolicyAgree;

  Settings({
    this.privacyPolicyAgree=false,
  });
}
