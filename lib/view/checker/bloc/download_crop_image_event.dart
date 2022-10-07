part of 'download_crop_image_bloc.dart';

@immutable
abstract class DownloadCropImageEvent {}

class DownloadCropImageSaveEvent extends DownloadCropImageEvent {
  final MBytes mainImage;
  final List<Uint8List> pixels;
  final PackageInfo packageInfo;
  DownloadCropImageSaveEvent({
    required this.mainImage,
    required this.pixels,
    required this.packageInfo,
  });
}

class DownloadCropImageSaveSingleEvent extends DownloadCropImageEvent {
  final Uint8List imageBytes;
  final int id;
  final MBytes mBytes;
  DownloadCropImageSaveSingleEvent({
    required this.imageBytes,
    required this.id,
    required this.mBytes,
  });
}
