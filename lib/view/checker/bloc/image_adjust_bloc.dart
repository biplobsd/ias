import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';

import '../../../data/model/m_bytes.dart';

part 'image_adjust_event.dart';
part 'image_adjust_state.dart';

class ImageAdjustBloc extends Bloc<ImageAdjustEvent, ImageAdjustState> {
  Uint8List? bytes;
  MBytes? uploadImage;
  ValueNotifier<bool> isRunning = ValueNotifier(false);

  ImageAdjustBloc() : super(ImageAdjustInitial()) {

    on<ImageAdjustImportImageEvent>((event, emit) async {
      await _importImage(event, emit);
    });

    on<ImageAdjustClearEvent>((event, emit) async {
      await _clear();
      emit(ImageAdjustClear());
    });
  }

  Future<void> _importImage(
      ImageAdjustImportImageEvent event, Emitter<ImageAdjustState> emit) async {
    emit(ImageAdjustImageUploading());
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['png', 'jpeg', 'gif', 'ttf', 'apng', 'jpg'],
      dialogTitle: 'Seleted only image file',
    );

    if (result != null && result.files.isNotEmpty) {
      Uint8List? importJsonRaw;
      PlatformFile single = result.files.first;
      String path;
      if (!kIsWeb) {
        File file = File(single.path.toString());
        if (kDebugMode) {
          print('Picked file -> ${file.path}');
        }
        importJsonRaw = await file.readAsBytes();
        path = single.path!;
      } else {
        importJsonRaw = result.files.first.bytes;
        path = single.name;
      }
      if (kDebugMode) {
        print(path);
      }
      String extension = single.extension.toString();
      if (importJsonRaw != null) {
        uploadImage = MBytes(
          isAnim: ['apng', 'gif'].contains(extension),
          bytes: importJsonRaw,
          extension: extension,
          path: path,
        );

        emit(ImageAdjustUpdated());
        return;
      }
    }
    _clear();
    emit(ImageAdjustImageError());
  }

  Future<void> _clear() async {
    bytes = null;
    uploadImage = null;
  }
}
