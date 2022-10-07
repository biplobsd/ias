import 'package:flutter/material.dart';
import 'package:ias/constants/constants.dart';

class ResponsiveWidget extends StatelessWidget {
  final Widget? largePage;
  final Widget? mediumPage;
  final Widget? smallPage;

  const ResponsiveWidget(
      {required this.largePage, this.smallPage, this.mediumPage, Key? key})
      : super(key: key);

  static bool isSmallScreen(BuildContext context) =>
      MediaQuery.of(context).size.width < mediumScreenSize;

  static bool isMediumScreen(BuildContext context) =>
      MediaQuery.of(context).size.width >= mediumScreenSize &&
      MediaQuery.of(context).size.width < largeScreenSize;

  static bool isLargeScreen(BuildContext context) =>
      MediaQuery.of(context).size.width >= largeScreenSize;

  static bool isCustomScreen(BuildContext context) =>
      MediaQuery.of(context).size.width >= mediumScreenSize &&
      MediaQuery.of(context).size.width <= customScreenSize;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: ((context, constraints) {
        double width = constraints.maxWidth;
        if (width >= largeScreenSize) {
          return largePage ?? Container();
        } else if (width < largeScreenSize && width >= mediumScreenSize) {
          return mediumPage ?? largePage ?? Container();
        } else {
          return smallPage ?? largePage ?? Container();
        }
      }),
    );
  }
}
