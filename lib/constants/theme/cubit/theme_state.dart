part of 'theme_cubit.dart';

@immutable
abstract class ThemeState {
  late final ThemeMode themeMode;
}

class ThemeLight extends ThemeState {
  @override
  // ignore: overridden_fields
  final ThemeMode themeMode = ThemeMode.light;
}

class ThemeDark extends ThemeState {
  @override
  // ignore: overridden_fields
  final ThemeMode themeMode = ThemeMode.dark;
}
