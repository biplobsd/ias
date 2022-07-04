import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:preloadwebapptemplate/view/widgets/side_menu/model/menu_data.dart';
import 'package:preloadwebapptemplate/view/widgets/side_menu/model/side_menu_list.dart';

part 'sidemenuonactive_state.dart';

class SidemenuonactiveCubit extends Cubit<SidemenuonactiveState> {
  final GlobalKey<NavigatorState> navigationKey = GlobalKey();
  String currentRouteName = sideMenuList[0].path;

  SidemenuonactiveCubit()
      : super(SidemenuonactiveInitial(
          menuData: sideMenuList[0].copyWith(isActive: true),
        ));

  void onActiveCall(MenuData menuData) {
    emit(SidemenuonactiveUpdate(menuData: menuData));
  }

  Future<void> navigateTo(String routeName) async {
    if (!routeName.contains(currentRouteName)) {
      currentRouteName = routeName;
      await navigationKey.currentState!.pushReplacementNamed(routeName);
    }
  }

  goBack() => navigationKey.currentState!.pop();
}
