import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:preloadwebapptemplate/constants/string.dart';
import 'package:preloadwebapptemplate/constants/theme/cubit/theme_cubit.dart';
import 'package:preloadwebapptemplate/route/routes.dart';

import 'package:preloadwebapptemplate/view/layout/layout.dart';

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
    var mainThemeColor = const MaterialColor(
      0xFFba0000,
      <int, Color>{
        50: Color(0xFFFFEBEE),
        100: Color(0xFFFFCDD2),
        200: Color(0xFFEF9A9A),
        300: Color(0xFFE57373),
        400: Color(0xFFEF5350),
        500: Color(0xFFba0000),
        600: Color(0xFFE53935),
        700: Color(0xFFD32F2F),
        800: Color(0xFFC62828),
        900: Color(0xFFba0000),
      },
    );
    return AdaptiveTheme(
      light: ThemeData(
        brightness: Brightness.light,
        primarySwatch: mainThemeColor,
      ),
      dark: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: mainThemeColor,
      ),
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
