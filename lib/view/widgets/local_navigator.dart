import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:preloadwebapptemplate/route/routes.dart';
import 'package:preloadwebapptemplate/view/checker/check_page.dart';
import 'package:preloadwebapptemplate/view/widgets/side_menu/cubit/sidemenuonactive_cubit.dart';

Navigator localNavigator(BuildContext context) => Navigator(
      key: BlocProvider.of<SidemenuonactiveCubit>(context).navigationKey,
      initialRoute: CheckerPage.pathName,
      onGenerateRoute: Routes().onGenerateRoute,
    );
