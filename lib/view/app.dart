import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:preloadwebapptemplate/constants/string.dart';
import 'package:preloadwebapptemplate/constants/theme/cubit/theme_cubit.dart';
import 'package:preloadwebapptemplate/route/routes.dart';

import 'package:preloadwebapptemplate/view/layout/layout.dart';

import '../constants/theme/theme_manager.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ThemeCubit(),
        ),
      ],
      child: const ApplyMore(),
    );
  }
}

class ApplyMore extends StatelessWidget {
  const ApplyMore({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const OverlaySupport.global(child: MainApp());
  }
}

class MainApp extends StatelessWidget {
  const MainApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: ThemeManager.buildTheme(Brightness.light),
      dark: ThemeManager.buildTheme(Brightness.dark),
      initial: AdaptiveThemeMode.light,
      builder: (light, dark) => MaterialApp(
        title: AppString.appName,
        debugShowCheckedModeBanner: false,
        onGenerateRoute: Routes().onGenerateRoute,
        theme: light,
        darkTheme: dark,
        initialRoute: SiteLayoutPage.pathName,
      ),
    );
  }
}
