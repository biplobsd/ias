import 'package:flutter/material.dart';

import 'package:preloadwebapptemplate/view/widgets/responsiveness.dart';

class CheckerPage extends StatelessWidget {
  const CheckerPage({Key? key}) : super(key: key);

  static const String pathName = '/checker';

  @override
  Widget build(BuildContext context) {
    return const CheckPageScreen();
  }
}

class CheckPageScreen extends StatelessWidget {
  const CheckPageScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double sizedR = !ResponsiveWidget.isSmallScreen(context) ? 200 : 100;
    double sizedRPadding = !ResponsiveWidget.isSmallScreen(context) ? 25 : 10;
    bool isSmall = ResponsiveWidget.isSmallScreen(context);
    return const Scaffold(
      body: Center(child: Text('Checker')),
    );
  }
}
