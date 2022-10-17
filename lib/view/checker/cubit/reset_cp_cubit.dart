import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../bloc/anim_image_bloc.dart';
import '../bloc/image_adjust_bloc.dart';
import 'frame_update_cubit.dart';

part 'reset_cp_state.dart';

class ResetCpCubit extends Cubit<ResetCpState> {
  AnimImageBloc animImageBloc;
  ImageAdjustBloc imageAdjustBloc;
  FrameUpdateCubit frameUpdateCubit;
  ResetCpCubit({
    required this.animImageBloc,
    required this.imageAdjustBloc,
    required this.frameUpdateCubit,
  }) : super(ResetCpInitial());

  void reset() {
    emit(ResetCpReseting());
    try {
      //
      imageAdjustBloc.add(ImageAdjustClearEvent());
      animImageBloc.add(AnimImageResetEvent());
      frameUpdateCubit.reset();
      //
    } catch (e) {
      emit(ResetCpError(msg: e.toString()));
      return;
    }
    emit(ResetCpReseted());
  }
}
