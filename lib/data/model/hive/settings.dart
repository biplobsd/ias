import 'package:hive/hive.dart';
part 'settings.g.dart';

@HiveType(typeId: 1)
class Settings {
  @HiveField(0)
  bool isOnlyShowRule;

  Settings({
    required this.isOnlyShowRule,
  });

  @override
  String toString() =>
      'Settings(isOnlyShowRule: $isOnlyShowRule)';
}
