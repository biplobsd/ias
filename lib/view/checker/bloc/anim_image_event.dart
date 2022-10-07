// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'anim_image_bloc.dart';

@immutable
abstract class AnimImageEvent {}

class AnimImageStartEvent extends AnimImageEvent {
  final MBytes mBytes;
  final int pixelLength;
  final int breakPoint;

  AnimImageStartEvent({
    required this.mBytes,
    required this.breakPoint,
    required this.pixelLength,
  });
}

class AnimImageCaptureEvent extends AnimImageEvent {
  final int pixelLength;
  final int breakPoint;
  final Uint8List imageBytes;
  AnimImageCaptureEvent({
    required this.pixelLength,
    required this.breakPoint,
    required this.imageBytes,
  });
}

class AnimImageResumeEvent extends AnimImageEvent {
  final List<crop.Image> pixelCropData;
  AnimImageResumeEvent({
    required this.pixelCropData,
  });
}

class AnimImageEncodingResumeEvent extends AnimImageEvent {
  AnimImageEncodingResumeEvent(
  );
}

class AnimImageResetEvent extends AnimImageEvent {
  AnimImageResetEvent();
}
