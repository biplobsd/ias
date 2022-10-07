part of 'setting_config_cubit.dart';

@immutable
abstract class SettingConfigState {}

class SettingConfigInitial extends SettingConfigState {}

class SettingConfigUpdate extends SettingConfigState {
  
  final String msg;
  SettingConfigUpdate({
    required this.msg,
  });
}

class SettingConfigError extends SettingConfigState {}
class SettingConfigLoaded extends SettingConfigState {}
