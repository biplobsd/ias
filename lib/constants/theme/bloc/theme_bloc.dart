import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeLight()) {
    on<ThemeToggleEvent>((event, emit) async {
      await toggleTheme(event.context, event.isDark, emit);
    });
  }

  Future<void> toggleTheme(
      BuildContext context, bool isDark, Emitter<ThemeState> emit) async {
    if (isDark) {
      emit(ThemeDark());
      AdaptiveTheme.of(context).setDark();

      // compute<IsolateThemeChange, void>(
      //   changeThemeNow,
      //   IsolateThemeChange(context: context, isDark: isDark),
      // );
    } else {
      emit(ThemeLight());
      AdaptiveTheme.of(context).setLight();
      // compute<IsolateThemeChange, void>(
      //   changeThemeNow,
      //   IsolateThemeChange(context: context, isDark: isDark),
      // );
    }
  }
}

void changeThemeNow(IsolateThemeChange themeIso) {
  if (themeIso.isDark) {
    AdaptiveTheme.of(themeIso.context).setDark();
  } else {
    AdaptiveTheme.of(themeIso.context).setLight();
  }
}

class IsolateThemeChange {
  final BuildContext context;
  final bool isDark;

  IsolateThemeChange({
    required this.context,
    required this.isDark,
  });
}
