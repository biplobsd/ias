import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ndialog/ndialog.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:preloadwebapptemplate/constants/string.dart';
import 'package:preloadwebapptemplate/constants/theme/bloc/theme_bloc.dart';
import 'package:preloadwebapptemplate/route/routes.dart';

import 'package:preloadwebapptemplate/view/layout/layout.dart';
import 'package:preloadwebapptemplate/view/setting/cubit/setting_config_cubit.dart';

import '../constants/theme/theme_manager.dart';
import '../core/cubit/top_context_cubit.dart';
import '../data/provider/horizon_api.dart';
import '../data/repository/horizon.dart';
import '../utility/function/helper.dart';
import 'privacy_policy/cubit/get_privacy_policy_cubit.dart';
import 'privacy_policy/privacy_policy.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var horizon = Horizon(horizonApi: HorizonApi());
    var settingConfCubit = SettingConfigCubit();
    return MultiBlocProvider(
      providers: [
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
          BlocListener<SettingConfigCubit, SettingConfigState>(
            listener: (context, state) async {
              if (state is SettingConfigLoaded &&
                  !settingConfCubit.localSettings.privacyPolicyAgree) {
                var topContext =
                    context.read<TopContextCubit>().topContextBackup;

                await NDialog(
                  title: const Text('Statement'),
                  content: const SizedBox(
                    height: 500,
                    width: 1080,
                    child: PrivacyPolicy(),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        SystemNavigator.pop();
                      },
                      child: const Text('Exit'),
                    ),
                    TextButton(
                      onPressed: () async {
                        await settingConfCubit
                            .changePrivacyPolicyAgree()
                            .whenComplete(() => Navigator.pop(topContext));
                      },
                      child: const Text('Agree'),
                    )
                  ],
                ).show(
                  topContext,
                  transitionType: DialogTransitionType.Bubble,
                );
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
