import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_switch/flutter_switch.dart';

import '../../constants/theme/bloc/theme_bloc.dart';

class ThemeChangeSwitch extends StatelessWidget {
  const ThemeChangeSwitch({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return FlutterSwitch(
          value: AdaptiveTheme.of(context).mode.isDark,
          borderRadius: 30.0,
          padding: 5.0,
          activeColor: Theme.of(context).primaryColor.withOpacity(0.2),
          inactiveColor: Theme.of(context).colorScheme.background.withOpacity(0.2),
          activeIcon: const Icon(
            Icons.nightlight_round,
            color: Color(0xFFF8E3A1),
          ),
          inactiveIcon: const Icon(
            Icons.wb_sunny,
            color: Color(0xFFFFDF5D),
          ),
          onToggle: (val) {
            BlocProvider.of<ThemeBloc>(context).add(
              ThemeToggleEvent(
                context: context,
                isDark: val,
              ),
            );
          },
        );
      },
    );
  }
}
