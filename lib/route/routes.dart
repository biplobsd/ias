import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:preloadwebapptemplate/view/about/about.dart';
import 'package:preloadwebapptemplate/view/asset_holder/asset_holder.dart';
import 'package:preloadwebapptemplate/view/history/history.dart';
import 'package:preloadwebapptemplate/view/checker/check_page.dart';
import 'package:preloadwebapptemplate/view/layout/layout.dart';
import 'package:preloadwebapptemplate/view/setting/setting_page.dart';
import 'package:preloadwebapptemplate/view/widgets/side_menu/cubit/packageinfo_cubit.dart';
import 'package:page_transition/page_transition.dart';

import '../data/repository/horizon.dart';

class Routes {
  final Horizon horizon;
  Routes({required this.horizon});
  Route? onGenerateRoute(RouteSettings settings) {
    // final args = settings.arguments;

    switch (settings.name) {
      case CheckerPage.pathName:
        return PageTransition(
          type: PageTransitionType.scale,
          alignment: Alignment.centerLeft,
          child: const CheckerPage(),
        );
      case SettingPage.pathName:
        return PageTransition(
          type: PageTransitionType.scale,
          alignment: Alignment.centerLeft,
          child: const SettingPage(),
        );
      case SiteLayoutPage.pathName:
        return PageTransition(
          type: PageTransitionType.scale,
          alignment: Alignment.centerLeft,
          child: const SiteLayoutPage(),
        );
      case AssetHolderPage.pathName:
        return PageTransition(
          type: PageTransitionType.scale,
          alignment: Alignment.centerLeft,
          child: const AssetHolderPage(),
        );
      case HistoryPage.pathName:
        return PageTransition(
          type: PageTransitionType.scale,
          alignment: Alignment.centerLeft,
          child: const HistoryPage(),
        );
      case About.pathName:
        return PageTransition(
          type: PageTransitionType.topToBottom,
          alignment: Alignment.center,
          child: BlocProvider(
            create: (context) => PackageinfoCubit(),
            child: const About(),
          ),
        );
      default:
        return null;
    }
  }
}
