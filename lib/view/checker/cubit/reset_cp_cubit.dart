import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../bloc/anim_image_bloc.dart';
import '../bloc/image_adjust_bloc.dart';

part 'reset_cp_state.dart';

class ResetCpCubit extends Cubit<ResetCpState> {
  AnimImageBloc animImageBloc;
  ImageAdjustBloc imageAdjustBloc;
  ResetCpCubit({
    required this.animImageBloc,
    required this.imageAdjustBloc,
  }) : super(ResetCpInitial());

  void reset() {
    emit(ResetCpReseting());
    try {
      //
      imageAdjustBloc.add(ImageAdjustClearEvent());
      animImageBloc.add(AnimImageResetEvent());
      //
    } catch (e) {
      emit(ResetCpError(msg: e.toString()));
      return;
    }
    emit(ResetCpReseted());
  }
}
