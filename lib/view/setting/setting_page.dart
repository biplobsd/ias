import 'package:flutter/material.dart';
import 'package:preloadwebapptemplate/view/widgets/responsiveness.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);
  static const String pathName = '/setting';
  static const String pageName = 'Setting';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: ResponsiveWidget.isSmallScreen(context) ? 20 : 0),
      child: const Scaffold(
        body: Center(
          child: Text('Settings'),
        ),
      ),
    );
  }
}
