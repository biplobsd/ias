import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/cubit/top_context_cubit.dart';
import '../../data/constants/side_menu_list.dart';
import '../../route/routes.dart';
import 'side_menu/cubit/sidemenuonactive_cubit.dart';

Navigator localNavigator(BuildContext context) => Navigator(
      key: BlocProvider.of<SidemenuonactiveCubit>(context).navigationKey,
      initialRoute: sideMenuList.first.path,
      onGenerateRoute: Routes(
        horizon: context.read<TopContextCubit>().horizon,
      ).onGenerateRoute,
    );
