import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ias/core/cubit/top_context_cubit.dart';
import 'package:ias/route/routes.dart';
import 'package:ias/view/widgets/side_menu/cubit/sidemenuonactive_cubit.dart';
import 'package:ias/data/constants/side_menu_list.dart';

Navigator localNavigator(BuildContext context) => Navigator(
      key: BlocProvider.of<SidemenuonactiveCubit>(context).navigationKey,
      initialRoute: sideMenuList[0].path,
      onGenerateRoute: Routes(
        horizon: context.read<TopContextCubit>().horizon,
      ).onGenerateRoute,
    );
