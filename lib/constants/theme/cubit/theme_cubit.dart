import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeLight());

  toggleTheme(BuildContext context, bool isDark) {
    if (isDark) {
      emit(ThemeDark());
      AdaptiveTheme.of(context).setDark();
    } else {
      emit(ThemeLight());
      AdaptiveTheme.of(context).setLight();
    }
  }
}
