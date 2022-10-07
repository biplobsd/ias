import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import '../../../../data/model/menu_data.dart';

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
      currentMenu = menuData;
      await navigationKey.currentState!.pushReplacementNamed(menuData.path);
    }
  }

  goBack() => navigationKey.currentState!.pop();
}
