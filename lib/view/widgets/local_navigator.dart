import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:preloadwebapptemplate/constants/theme/cubit/theme_cubit.dart';
import 'package:preloadwebapptemplate/route/routes.dart';
import 'package:preloadwebapptemplate/view/widgets/side_menu/cubit/sidemenuonactive_cubit.dart';
import 'package:preloadwebapptemplate/data/constants/side_menu_list.dart';

Navigator localNavigator(BuildContext context) => Navigator(
      key: BlocProvider.of<SidemenuonactiveCubit>(context).navigationKey,
      initialRoute: sideMenuList[0].path,
      onGenerateRoute: Routes(
        horizon: context.read<ThemeCubit>().horizon,
      ).onGenerateRoute,
    );
