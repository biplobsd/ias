import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ias/view/layout/large/large_page.dart';
import 'package:ias/view/layout/small/small_page.dart';
import 'package:ias/view/widgets/responsiveness.dart';
import 'package:ias/view/widgets/side_menu/cubit/sidemenuonactive_cubit.dart';
import 'package:ias/data/model/menu_data.dart';
import 'package:ias/data/constants/side_menu_list.dart';
import 'package:ias/view/widgets/side_menu/side_menu.dart';
import 'package:ias/view/widgets/top_nav.dart';

class SiteLayoutPage extends StatelessWidget {
  static const String pathName = '/sitelayout';

  const SiteLayoutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MenuData initialPage = sideMenuList[0];
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
      appBar: topNavigationBar(context, scaffoldKey),
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
