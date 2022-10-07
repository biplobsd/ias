part of 'image_adjust_bloc.dart';

@immutable
abstract class ImageAdjustState {}

class ImageAdjustInitial extends ImageAdjustState {}

class ImageAdjustClear extends ImageAdjustState {}

class ImageAdjustImageUploading extends ImageAdjustState {}

class ImageAdjustImageError extends ImageAdjustState {}

class ImageAdjustImageImporting extends ImageAdjustState {}

class ImageAdjustImported extends ImageAdjustState {
  final MBytes mBytes;
  ImageAdjustImported({
    required this.mBytes,
  });
}
