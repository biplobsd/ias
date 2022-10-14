import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/constants/side_menu_list.dart';
import '../../data/model/menu_data.dart';
import '../widgets/responsiveness.dart';
import '../widgets/side_menu/cubit/sidemenuonactive_cubit.dart';
import '../widgets/side_menu/side_menu.dart';
import '../widgets/top_nav.dart';
import 'large/large_page.dart';
import 'small/small_page.dart';


class SiteLayoutPage extends StatelessWidget {
  static const String pathName = '/sitelayout';

  const SiteLayoutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MenuData initialPage = sideMenuList.first;
    return BlocProvider(
      create: (context) => SidemenuonactiveCubit(currentMenu: initialPage),
      child: const SiteLayoutPageScreen(),
    );
  }
}

class SiteLayoutPageScreen extends StatelessWidget {
  const SiteLayoutPageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
    return Scaffold(
      key: scaffoldKey,
      appBar: !kIsWeb && Platform.isAndroid
          ? AppBar(
              titleSpacing: 0,
              leadingWidth: 0,
              toolbarHeight: 35,
              elevation: 0,
              backgroundColor: Colors.transparent,
              leading: const SizedBox(),
              title: topNavigationBar(context, scaffoldKey),
            )
          : topNavigationBar(context, scaffoldKey),
      drawer: ResponsiveWidget.isSmallScreen(context)
          ? const Drawer(
              child: SideMenu(),
            )
          : null,
      body: const ResponsiveWidget(
        largePage: LargeScreen(),
        smallPage: SmallPage(),
      ),
    );
  }
}
