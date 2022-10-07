part of 'image_adjust_bloc.dart';

@immutable
abstract class ImageAdjustState {}

class ImageAdjustInitial extends ImageAdjustState {}

class ImageAdjustClear extends ImageAdjustState {}

class ImageAdjustImageUploading extends ImageAdjustState {}

class ImageAdjustImageError extends ImageAdjustState {}

class ImageAdjustImageImporting extends ImageAdjustState {}

class ImageAdjustUpdated extends ImageAdjustState {}

class ImageAdjustCapturing extends ImageAdjustState {}

class ImageAdjustCaptureUpdate extends ImageAdjustState {
  final int pixelLength;
  final int breakPoint;
  ImageAdjustCaptureUpdate({
    required this.pixelLength,
    required this.breakPoint,
  });
}

class ImageAdjustCroping extends ImageAdjustState {}

class ImageAdjustCropUpdate extends ImageAdjustState {
  final int lengthComplated;
  final int index;
  final Uint8List pixelCropData;
  ImageAdjustCropUpdate({
    required this.lengthComplated,
    required this.index,
    required this.pixelCropData,
  });
}

class ImageAdjustCroped extends ImageAdjustState {
  final List<dynamic> pixelCropData;
  final MBytes mainImage;
  final bool isBuild;
  final bool isFinal;
  ImageAdjustCroped({
    required this.pixelCropData,
    required this.mainImage,
    this.isBuild = true,
    this.isFinal = false,
  });
}
