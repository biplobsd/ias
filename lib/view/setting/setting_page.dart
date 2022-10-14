import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../bloc/ads_bloc.dart';
import '../widgets/responsiveness.dart';
import '../widgets/style.dart';
import '../widgets/theme_change_switch.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);
  static const String pathName = '/setting';
  static const String pageName = 'Setting';

  @override
  Widget build(BuildContext context) {
    bool isSmall = ResponsiveWidget.isSmallScreen(context);
    double getPadding = isSmall ? 20 : 0;
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Padding(
            padding: EdgeInsets.only(
                top: getPadding, right: getPadding, left: getPadding),
            child: Column(
              children: const [
                CustomTextHeader(text: 'Theme mode'),
                ThemeChangeSwitch(),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
          BlocBuilder<AdsBloc, AdsState>(
            builder: (context, state) {
              if (state is AdsLoaded) {
                var ad = context.read<AdsBloc>().myBanners[2];
                return Container(
                  alignment: Alignment.center,
                  width: ad.size.width.toDouble(),
                  height: ad.size.height.toDouble(),
                  child: AdWidget(ad: ad),
                );
              }
              return const SizedBox();
            },
          )
        ],
      ),
    );
  }
}
