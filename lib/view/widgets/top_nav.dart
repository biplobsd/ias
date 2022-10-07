import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ias/constants/string.dart';

import 'package:ias/view/widgets/custom_text.dart';
import 'package:ias/view/widgets/power_by.dart';
import 'package:ias/view/widgets/responsiveness.dart';
import 'package:ias/view/widgets/theme_change_switch.dart';

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
      const ThemeChangeSwitch(),
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
