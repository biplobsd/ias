part of 'anim_image_bloc.dart';

@immutable
abstract class AnimImageState {}

class AnimImageInitial extends AnimImageState {}

class AnimImageCroping extends AnimImageState {
  final int pixelLength;
  final int breakPoint;
  final Uint8List imageBytes;
  AnimImageCroping({
    required this.pixelLength,
    required this.breakPoint,
    required this.imageBytes,
  });
}

class AnimImageCropingBuildComplated extends AnimImageCroping {
  final int done;
  final int frameSize;
  AnimImageCropingBuildComplated({
    required super.pixelLength,
    required super.breakPoint,
    required super.imageBytes,
    required this.done,
    required this.frameSize,
  });
}

class AnimImageCroped extends AnimImageState {
  final List<Uint8List> cropedAnim;
  final MBytes mBytes;

  AnimImageCroped({
    required this.cropedAnim,
    required this.mBytes,
  });
}

class AnimImageStop extends AnimImageState {}

class AnimImageEncodeingLoop extends AnimImageState {}

class AnimImageDecodeing extends AnimImageState {}

class AnimImageEncodingUpdate extends AnimImageState {
  final int total;
  final int count;
  AnimImageEncodingUpdate({
    required this.total,
    required this.count,
  });
}

class AnimImageError extends AnimImageState {}
