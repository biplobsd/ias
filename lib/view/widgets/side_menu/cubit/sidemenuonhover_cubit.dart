import 'package:bloc/bloc.dart';
import 'package:preloadwebapptemplate/view/widgets/side_menu/model/menu_data.dart';
import 'package:preloadwebapptemplate/view/widgets/side_menu/model/side_menu_list.dart';
import 'package:meta/meta.dart';

part 'sidemenuonhover_state.dart';

class SidemenuonhoverCubit extends Cubit<SidemenuonhoverState> {
  SidemenuonhoverCubit()
      : super(
          SidemenuonhoverInitial(
            menuData: sideMenuList[0],
          ),
        );

  void onHoverCall(MenuData menuData) {
    emit(SidemenuonhoverUpdate(menuData: menuData));
  }
}
