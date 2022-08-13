import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:preloadwebapptemplate/constants/string.dart';

import 'package:preloadwebapptemplate/constants/theme/cubit/theme_cubit.dart';

import 'package:preloadwebapptemplate/view/widgets/custom_text.dart';
import 'package:preloadwebapptemplate/view/widgets/power_by.dart';
import 'package:preloadwebapptemplate/view/widgets/responsiveness.dart';

import '../../core/cubit/top_context_cubit.dart';

AppBar topNavigationBar(BuildContext context, GlobalKey<ScaffoldState> key) {
  context.read<TopContextCubit>().topContextBackup = context;
  return AppBar(
    leadingWidth: !ResponsiveWidget.isSmallScreen(context) ? 145 : null,
    toolbarHeight: !ResponsiveWidget.isSmallScreen(context) ? 140 : null,
    leading: !ResponsiveWidget.isSmallScreen(context)
        ? Container(
            padding: const EdgeInsets.only(left: 20, top: 5),
            child: Image.asset(
              'assets/logo.png',
              fit: BoxFit.fill,
            ))
        : IconButton(
            onPressed: () {
              FocusManager.instance.primaryFocus?.unfocus();
              key.currentState!.openDrawer();
            },
            icon: const Icon(Icons.menu),
          ),
    elevation: 0,
    title: Row(children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: AppString.appName,
            size: 20,
            color: Theme.of(context).hoverColor.withOpacity(0.7),
            weight: FontWeight.bold,
          ),
          const SizedBox(
            height: 3,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 0.3),
            child: PowerBy(),
          )
        ],
      ),
      const Spacer(),
      BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return FlutterSwitch(
            value: AdaptiveTheme.of(context).mode.isDark,
            borderRadius: 30.0,
            padding: 5.0,
            activeColor: Theme.of(context).primaryColor.withOpacity(0.2),
            inactiveColor: Theme.of(context).backgroundColor.withOpacity(0.2),
            activeIcon: const Icon(
              Icons.nightlight_round,
              color: Color(0xFFF8E3A1),
            ),
            inactiveIcon: const Icon(
              Icons.wb_sunny,
              color: Color(0xFFFFDF5D),
            ),
            onToggle: (val) {
              BlocProvider.of<ThemeCubit>(context).toggleTheme(context, val);
            },
          );
        },
      ),
      if (!ResponsiveWidget.isSmallScreen(context))
        const SizedBox(
          width: 10,
        ),
    ]),
    iconTheme: IconThemeData(
      color: Theme.of(context).hintColor.withOpacity(0.7),
    ),
    backgroundColor: Colors.transparent,
  );
}
