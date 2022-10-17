part of 'frame_update_cubit.dart';

@immutable
abstract class FrameUpdateState {}

class FrameUpdateInitial extends FrameUpdateState {}

class FrameUpdateFrameUpdate extends FrameUpdateState {
  final int frameLen;
  FrameUpdateFrameUpdate({
    required this.frameLen,
  });
}
