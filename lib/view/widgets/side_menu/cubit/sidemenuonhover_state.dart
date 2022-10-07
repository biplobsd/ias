part of 'sidemenuonhover_cubit.dart';

@immutable
abstract class SidemenuonhoverState {
  final MenuData menuData;
  const SidemenuonhoverState({
    required this.menuData,
  });

  bool isThatWidget(MenuData menuData) {
    return menuData.name == this.menuData.name && this.menuData.isHover;
  }
}

class SidemenuonhoverInitial extends SidemenuonhoverState {
  const SidemenuonhoverInitial({
    required MenuData menuData,
  }) : super(menuData: menuData);
}

class SidemenuonhoverUpdate extends SidemenuonhoverState {
  const SidemenuonhoverUpdate({
    required MenuData menuData,
  }) : super(menuData: menuData);
}
