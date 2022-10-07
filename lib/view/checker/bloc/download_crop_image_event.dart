part of 'download_crop_image_bloc.dart';

@immutable
abstract class DownloadCropImageEvent {}

class DownloadCropImageSaveEvent extends DownloadCropImageEvent {
  final MBytes mainImage;
  final List<dynamic> pixels;
  final PackageInfo packageInfo;
  DownloadCropImageSaveEvent({
    required this.mainImage,
    required this.pixels,
    required this.packageInfo,
  });
}
