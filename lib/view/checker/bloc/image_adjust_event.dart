part of 'image_adjust_bloc.dart';

@immutable
abstract class ImageAdjustEvent {}

class ImageAdjustImportImageEvent extends ImageAdjustEvent {
  ImageAdjustImportImageEvent();
}

class ImageAdjustClearEvent extends ImageAdjustEvent {}
