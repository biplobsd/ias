import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/string.dart';
import '../../core/cubit/top_context_cubit.dart';
import 'custom_text.dart';
import 'power_by.dart';
import 'responsiveness.dart';
import 'theme_change_switch.dart';

AppBar topNavigationBar(BuildContext context, GlobalKey<ScaffoldState> key) {
  context.read<TopContextCubit>().topContextBackup = context;
  var isSmallS = ResponsiveWidget.isSmallScreen(context);
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
          if (!isSmallS)
            const Padding(
              padding: EdgeInsets.only(left: 0.3),
              child: PowerBy(),
            )
        ],
      ),
      const Spacer(),
    ]),
    iconTheme: IconThemeData(
      color: Theme.of(context).hintColor.withOpacity(0.7),
    ),
    backgroundColor: Colors.transparent,
  );
}
