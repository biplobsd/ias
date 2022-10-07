import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

import 'package:image/image.dart' as crop;

import '../../../data/model/m_bytes.dart';

part 'anim_image_event.dart';
part 'anim_image_state.dart';

class AnimImageBloc extends Bloc<AnimImageEvent, AnimImageState> {
  late List<crop.Image> anim;
  late List<Uint8List> pixelBytes;
  late bool runningLock;
  MBytes? mBytes;
  int? frameSize;
  crop.Image? currentImage;
  late int count;

  void _reset() {
    count = 0;
    anim = [];
    pixelBytes = [];
    mBytes = null;
    frameSize = null;
    currentImage = null;
    runningLock = false;
  }

  void _emitNremove({required Emitter<AnimImageState> emit}) async {
    if (anim.isNotEmpty) {
      currentImage = anim.removeAt(0);
      var imgBytes = crop.encodePng(currentImage!) as Uint8List;
      pixelBytes.add(imgBytes);
      emit(
        AnimImageSplitting(
          imageBytes: imgBytes,
          id: count,
        ),
      );
      count++;
    } else {
      runningLock = false;
      emit(
        AnimImageSplittingComplated(
          pixelBytes: pixelBytes,
          mBytes: mBytes!,
        ),
      );
    }
  }

  AnimImageBloc() : super(AnimImageInitial()) {
    on<AnimImageStartEvent>((event, emit) async {
      _reset();
      emit(AnimImageDecodeing());
      mBytes = event.mBytes;
      runningLock = true;
      var animRaw = await compute<DecodeImageModel, DecodeImgOut>(
        decodeImage,
        DecodeImageModel(
          bytes: event.mBytes.bytes,
          extension: mBytes!.extension,
        ),
      );
      anim = animRaw.list!;

      frameSize = anim.length;
      emit(
        AnimImageFrameSizeUpdate(
          frameLen: frameSize!,
        ),
      );
    });

    on<AnimImageResumeEvent>((event, emit) {
      _emitNremove(
        emit: emit,
      );
    });

    on<AnimImageResetEvent>((event, emit) {
      _reset();
      emit(AnimImageInitial());
    });
  }
}

class DecodeImageModel {
  Uint8List bytes;
  String extension;
  DecodeImageModel({
    required this.bytes,
    required this.extension,
  });
}

class DecodeImgOut {
  List<crop.Image>? list;
  DecodeImgOut({
    this.list,
  });
}

DecodeImgOut decodeImage(DecodeImageModel dIM) {
  List<crop.Image>? decodeAnim;
  decodeAnim = crop.decodeAnimation(dIM.bytes)!.toList();
  return DecodeImgOut(list: decodeAnim);
}
