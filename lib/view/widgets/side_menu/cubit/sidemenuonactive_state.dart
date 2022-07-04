part of 'sidemenuonactive_cubit.dart';

@immutable
abstract class SidemenuonactiveState {
  final MenuData menuData;
  const SidemenuonactiveState({
    required this.menuData,
  });

  bool isThatWidget(MenuData menuData) {
    return menuData.name == this.menuData.name && this.menuData.isActive;
  }
}

class SidemenuonactiveInitial extends SidemenuonactiveState {
  const SidemenuonactiveInitial({
    required MenuData menuData,
  }) : super(menuData: menuData);
}

class SidemenuonactiveUpdate extends SidemenuonactiveState {
  const SidemenuonactiveUpdate({
    required MenuData menuData,
  }) : super(menuData: menuData);
}
