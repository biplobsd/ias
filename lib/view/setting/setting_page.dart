import 'package:flutter/material.dart';

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
      body: Padding(
        padding: EdgeInsets.only(
            top: getPadding, right: getPadding, left: getPadding),
        child: SingleChildScrollView(
          child: Column(
            children: [
                Column(
                  children: const [
                    CustomTextHeader(text: 'Theme mode'),
                    ThemeChangeSwitch(),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
