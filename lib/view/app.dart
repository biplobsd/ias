import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:preloadwebapptemplate/constants/string.dart';
import 'package:preloadwebapptemplate/constants/theme/bloc/theme_bloc.dart';
import 'package:preloadwebapptemplate/route/routes.dart';

import 'package:preloadwebapptemplate/view/layout/layout.dart';

import '../constants/theme/theme_manager.dart';
import '../core/cubit/top_context_cubit.dart';
import '../data/provider/horizon_api.dart';
import '../data/repository/horizon.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var horizon = Horizon(horizonApi: HorizonApi());
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ThemeBloc(),
        ),
        BlocProvider(
          create: (context) => TopContextCubit(horizon: horizon),
        ),
      ],
      child: ApplyMore(horizon: horizon),
    );
  }
}

class ApplyMore extends StatelessWidget {
  final Horizon horizon;
  const ApplyMore({required this.horizon, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OverlaySupport.global(
      child: MainApp(
        horizon: horizon,
      ),
    );
  }
}

class MainApp extends StatelessWidget {
  final Horizon horizon;
  const MainApp({
    required this.horizon,
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
        onGenerateRoute: Routes(horizon: horizon).onGenerateRoute,
        theme: light,
        darkTheme: dark,
        initialRoute: SiteLayoutPage.pathName,
      ),
    );
  }
}
