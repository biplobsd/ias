import 'package:flutter/material.dart';

import 'package:ias/view/widgets/responsiveness.dart';

class AssetHolderPage extends StatelessWidget {
  static const String pathName = '/assetHolder';
  static const String pageName = 'Asset Holder';
  const AssetHolderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const AssetHolderPageScreen();
  }
}

class AssetHolderPageScreen extends StatelessWidget {
  const AssetHolderPageScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isSmall = !ResponsiveWidget.isLargeScreen(context);
    double sizedRPadding = !ResponsiveWidget.isSmallScreen(context) ? 25 : 10;
    return const Scaffold(
      body: Center(
        child: Text("Asset holder"),
      ),
    );
  }
}
