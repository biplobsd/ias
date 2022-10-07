part of 'download_crop_image_bloc.dart';

@immutable
abstract class DownloadCropImageState {}

class DownloadCropImageInitial extends DownloadCropImageState {}

class DownloadCropImageZiping extends DownloadCropImageState {}

class DownloadCropImageError extends DownloadCropImageState {
  final String errorMsg;
  DownloadCropImageError({
    required this.errorMsg,
  });
}

class DownloadCropImageDone extends DownloadCropImageState {
  final String fileName;
  DownloadCropImageDone({
    required this.fileName,
  });
}
