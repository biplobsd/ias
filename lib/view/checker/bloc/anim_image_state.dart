part of 'anim_image_bloc.dart';

@immutable
abstract class AnimImageState {}

class AnimImageInitial extends AnimImageState {}

class AnimImageSplitting extends AnimImageState {
  final Uint8List imageBytes;
  final int id;
  final MBytes mBytes;
  AnimImageSplitting({
    required this.imageBytes,
    required this.id,
    required this.mBytes,
  });
}

class AnimImageSplittingComplated extends AnimImageState {
  final List<Uint8List> pixelBytes;
  final MBytes mBytes;
  AnimImageSplittingComplated({
    required this.pixelBytes,
    required this.mBytes,
  });
}

class AnimImageStop extends AnimImageState {}

class AnimImageFrameSizeUpdate extends AnimImageState {
  final int frameLen;
  AnimImageFrameSizeUpdate({
    required this.frameLen,
  });
}

class AnimImageDecodeing extends AnimImageState {}

class AnimImageError extends AnimImageState {}
