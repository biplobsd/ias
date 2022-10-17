import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'frame_update_state.dart';

class FrameUpdateCubit extends Cubit<FrameUpdateState> {
  FrameUpdateCubit() : super(FrameUpdateInitial());

  void update(int size) => emit(FrameUpdateFrameUpdate(frameLen: size));

  void reset() => emit(FrameUpdateInitial());
}
