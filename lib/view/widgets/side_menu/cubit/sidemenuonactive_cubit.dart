import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:preloadwebapptemplate/view/widgets/side_menu/model/menu_data.dart';

part 'sidemenuonactive_state.dart';

class SidemenuonactiveCubit extends Cubit<SidemenuonactiveState> {
  final GlobalKey<NavigatorState> navigationKey = GlobalKey();
  late MenuData currentMenu;

  SidemenuonactiveCubit({required this.currentMenu})
      : super(SidemenuonactiveInitial(
          menuData: currentMenu.copyWith(isActive: true),
        ));

  void onActiveCall(MenuData menuData) {
    emit(SidemenuonactiveUpdate(menuData: menuData));
  }

  Future<void> navigateTo(MenuData menuData) async {
    if (!menuData.path.contains(currentMenu.path)) {
      await navigationKey.currentState!.pushReplacementNamed(menuData.path);
      currentMenu = menuData;
    }
  }

  goBack() => navigationKey.currentState!.pop();
}
