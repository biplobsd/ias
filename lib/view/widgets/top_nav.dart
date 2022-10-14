import 'dart:io';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/string.dart';
import '../../core/cubit/top_context_cubit.dart';
import 'custom_text.dart';
import 'power_by.dart';
import 'responsiveness.dart';

PreferredSize topNavigationBar(
    BuildContext context, GlobalKey<ScaffoldState> key) {
  context.read<TopContextCubit>().topContextBackup = context;
  bool isNotSmallScreen = !ResponsiveWidget.isSmallScreen(context);
  final buttonColors = WindowButtonColors(
      iconNormal: Theme.of(context).hintColor,
      mouseOver: Theme.of(context).hoverColor,
      iconMouseOver: Theme.of(context).hintColor,
      iconMouseDown: Theme.of(context).hintColor);

  final closeButtonColors = WindowButtonColors(
      mouseOver: const Color(0xFFD32F2F),
      mouseDown: const Color(0xFFB71C1C),
      iconNormal: Theme.of(context).hintColor,
      iconMouseOver: Colors.white);

  Widget appBarTitle = Row(
    children: [
      Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: AppString.appName,
            size: 20,
            color: Theme.of(context).hoverColor.withOpacity(0.7),
            weight: FontWeight.bold,
          ),
          if (kIsWeb)
            const Padding(
              padding: EdgeInsets.only(top: 3, left: 0.3),
              child: PowerBy(),
            )
        ],
      ),
      const Spacer(),
    ],
  );

  return PreferredSize(
    preferredSize: Size.fromHeight(!kIsWeb && Platform.isAndroid ? 35 : 60),
    child: Container(
      alignment: Alignment.bottomLeft,
      child: Row(
        children: [
          isNotSmallScreen
              ? Container(
                  padding: const EdgeInsets.only(left: 20, top: 0),
                  child: IconButton(
                    iconSize: 35,
                    onPressed: () {},
                    icon: SizedBox(
                      height: 35,
                      width: 35,
                      child: Image.asset(
                        'assets/logo.png',
                        fit: BoxFit.fill,
                      ),
                    ),
                  ))
              : IconButton(
                  splashRadius: 18,
                  onPressed: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    key.currentState!.openDrawer();
                  },
                  icon: const Icon(Icons.menu),
                ),
          Expanded(
            child: kIsWeb || !Platform.isWindows
                ? Row(
                    children: [
                      Expanded(
                        child: appBarTitle,
                      ),
                    ],
                  )
                : WindowTitleBarBox(
                    child: Row(children: [
                      Expanded(
                        child: MoveWindow(
                          child: appBarTitle,
                        ),
                      ),
                    ]),
                  ),
          ),
          if (!kIsWeb && Platform.isWindows)
            Align(
              alignment: Alignment.topRight,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  MinimizeWindowButton(
                    colors: buttonColors,
                    animate: true,
                  ),
                  MaximizeWindowButton(
                    colors: buttonColors,
                    animate: true,
                  ),
                  CloseWindowButton(
                    colors: closeButtonColors,
                    animate: true,
                  ),
                ],
              ),
            ),
          if (isNotSmallScreen && (kIsWeb || !Platform.isWindows))
            const SizedBox(
              width: 10,
            ),
        ],
      ),
    ),
  );
}
