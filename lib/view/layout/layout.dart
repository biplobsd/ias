import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:preloadwebapptemplate/view/layout/large/large_page.dart';
import 'package:preloadwebapptemplate/view/layout/small/small_page.dart';
import 'package:preloadwebapptemplate/view/widgets/responsiveness.dart';
import 'package:preloadwebapptemplate/view/widgets/side_menu/cubit/sidemenuonactive_cubit.dart';
import 'package:preloadwebapptemplate/view/widgets/side_menu/side_menu.dart';
import 'package:preloadwebapptemplate/view/widgets/top_nav.dart';

class SiteLayoutPage extends StatelessWidget {
  static const String pathName = '/sitelayout';

  const SiteLayoutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SidemenuonactiveCubit(),
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
