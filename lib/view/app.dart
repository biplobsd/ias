
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:overlay_support/overlay_support.dart';

import '../constants/string.dart';
import '../constants/theme/bloc/theme_bloc.dart';
import '../constants/theme/theme_manager.dart';
import '../core/cubit/top_context_cubit.dart';
import '../data/provider/horizon_api.dart';
import '../data/repository/horizon.dart';
import '../route/routes.dart';
import '../utility/function/helper.dart';
import 'checker/bloc/anim_image_bloc.dart';
import 'checker/bloc/download_crop_image_bloc.dart';
import 'checker/bloc/image_adjust_bloc.dart';
import 'checker/cubit/reset_cp_cubit.dart';
import 'layout/layout.dart';
import 'privacy_policy/cubit/get_privacy_policy_cubit.dart';
import 'setting/cubit/setting_config_cubit.dart';
import 'widgets/side_menu/cubit/packageinfo_cubit.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var horizon = Horizon(horizonApi: HorizonApi());
    var settingConfCubit = SettingConfigCubit();
    var animImageBloc = AnimImageBloc();
    var imageAdjustBloc = ImageAdjustBloc();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PackageinfoCubit(),
        ),
        BlocProvider(
          create: (context) => ThemeBloc(),
        ),
        BlocProvider(
          create: (context) => TopContextCubit(horizon: horizon),
        ),
        BlocProvider(
          create: (context) => settingConfCubit,
          lazy: false,
        ),
        BlocProvider(
          create: (context) => GetPrivacyPolicyCubit(horizon: horizon),
        ),
        BlocProvider(
          create: (context) => animImageBloc,
        ),
        BlocProvider(
          create: (context) => DownloadCropImageBloc(),
        ),
        BlocProvider(
          create: (context) => imageAdjustBloc,
        ),
        BlocProvider(
          create: (context) => ResetCpCubit(
            animImageBloc: animImageBloc,
            imageAdjustBloc: imageAdjustBloc,
          ),
        ),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<SettingConfigCubit, SettingConfigState>(
            listener: (context, state) {
              if (state is SettingConfigUpdate) {
                Helper.customToast(context, state.msg, ToastMode.success);
              }
            },
          ),
        ],
        child: ApplyMore(horizon: horizon),
      ),
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
