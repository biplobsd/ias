import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:preloadwebapptemplate/constants/string.dart';
import 'package:preloadwebapptemplate/constants/style.dart';
import 'package:preloadwebapptemplate/view/about/about.dart';
import 'package:preloadwebapptemplate/view/widgets/custom_text.dart';
import 'package:preloadwebapptemplate/view/widgets/responsiveness.dart';
import 'package:preloadwebapptemplate/view/widgets/side_menu/cubit/packageinfo_cubit.dart';
import 'package:preloadwebapptemplate/view/widgets/side_menu/cubit/sidemenuonactive_cubit.dart';
import 'package:preloadwebapptemplate/view/widgets/side_menu/cubit/sidemenuonhover_cubit.dart';
import 'package:preloadwebapptemplate/data/model/menu_data.dart';
import 'package:preloadwebapptemplate/data/constants/side_menu_list.dart';
import 'package:preloadwebapptemplate/view/widgets/side_menu/side_menu_item/side_menu_item.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SidemenuonhoverCubit(),
        ),
        BlocProvider(
          create: (context) => PackageinfoCubit(),
        ),
      ],
      child: const SideMenuBody(),
    );
  }
}

class SideMenuBody extends StatelessWidget {
  const SideMenuBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Expanded(
          child: ListView(children: [
            if (ResponsiveWidget.isSmallScreen(context))
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: width / 48,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: Image.asset(
                          'assets/logo.png',
                          height: 120,
                        ),
                      ),
                      Flexible(
                        child: CustomText(
                          text: AppString.appName,
                          size: 20,
                          weight: FontWeight.bold,
                          color: Theme.of(context).hintColor.withOpacity(.7),
                        ),
                      ),
                      SizedBox(
                        width: width / 48,
                      ),
                    ],
                  ),
                ],
              ),
            const SizedBox(
              height: 40,
            ),
            Divider(
              color: lightGrey.withOpacity(.1),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: sideMenuList
                  .map((itemData) => SideMenuItem(
                        itemData: itemData,
                        onTap: () {
                          var sidemenuonactivecubit =
                              BlocProvider.of<SidemenuonactiveCubit>(context);
                          sidemenuonactivecubit
                              .onActiveCall(itemData.copyWith(isActive: true));
                          if (ResponsiveWidget.isSmallScreen(context)) {
                            Navigator.pop(context);
                          }
                        },
                      ))
                  .toList(),
            )
          ]),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<PackageinfoCubit, PackageinfoState>(
            builder: (context, state) {
              if (state is PackageinfoFound) {
                var packageinfo = state.packageInfo;
                return TextButton(
                  onPressed: () async {
                    var sidemenuonactivecubit =
                        BlocProvider.of<SidemenuonactiveCubit>(context);
                    var aboutMenuData = MenuData(
                      name: About.pageName,
                      path: About.pathName,
                    );
                    sidemenuonactivecubit.onActiveCall(aboutMenuData);
                    BlocProvider.of<SidemenuonactiveCubit>(context)
                        .navigateTo(aboutMenuData);
                    if (ResponsiveWidget.isSmallScreen(context)) {
                      Navigator.pop(context);
                    }
                  },
                  child: FittedBox(
                    child: Text(
                      '${packageinfo.appName} v${state.packageInfo.version}',
                      style: TextStyle(
                          fontSize: 12, color: Theme.of(context).hintColor),
                    ),
                  ),
                );
              } else if (state is PackageinfoLoading ||
                  state is PackageinfoInitial) {
                return const CircularProgressIndicator();
              }
              return const SizedBox();
            },
          ),
        )
      ],
    );
  }
}
