import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:preloadwebapptemplate/constants/string.dart';

import '../../../data/model/hive/settings.dart';
part 'setting_config_state.dart';

class SettingConfigCubit extends Cubit<SettingConfigState> {
  late final Box<Settings> box;
  final String boxName = '${AppString.shortName}settingsv1.0';

  late Settings localSettings;

  SettingConfigCubit() : super(SettingConfigInitial()) {
    hiveInit();
  }

  Future<void> hiveSave() async {
    await box.put(boxName, localSettings);
  }

  void hiveInit() async {
    box = await Hive.openBox<Settings>(boxName);
    var raw = box.get(boxName);
    if (raw != null) {
      localSettings = raw;
    } else {
      localSettings = Settings();
    }
    emit(SettingConfigLoaded());
  }

  Future<void> changePrivacyPolicyAgree() async {
    localSettings.privacyPolicyAgree = true;
    await hiveSave();
    emit(SettingConfigUpdate(msg: 'Privacy Policy Agree'));
  }
}
