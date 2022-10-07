import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

import 'package:image/image.dart' as crop;

import '../../../data/model/m_bytes.dart';

part 'anim_image_event.dart';
part 'anim_image_state.dart';

class AnimImageBloc extends Bloc<AnimImageEvent, AnimImageState> {
  late List<crop.Image> anim;
  late List<crop.Animation> outputAnim;
  late List<Uint8List> pixelBytes;
  late bool runningLock;
  MBytes? mBytes;
  int? breakPoint;
  int? pixelLength;
  int? frameSize;
  crop.Image? currentImage;

  void _reset() {
    anim = [];
    outputAnim = [];
    pixelBytes = [];
    mBytes = null;
    breakPoint = null;
    pixelLength = null;
    frameSize = null;
    currentImage = null;
    runningLock = false;
  }

  void _emitNremove({required Emitter<AnimImageState> emit}) async {
    if (anim.isNotEmpty) {
      currentImage = anim.removeAt(0);
      var imgBytes = crop.encodePng(currentImage!) as Uint8List;
      emit(
        AnimImageCroping(
          breakPoint: breakPoint!,
          pixelLength: pixelLength!,
          imageBytes: imgBytes,
        ),
      );
    } else {
      runningLock = false;
      _encondingAnim(emit: emit);
    }
  }

  void _encondingAnim({required Emitter<AnimImageState> emit}) {
    if (outputAnim.isNotEmpty) {
      switch (mBytes!.extension) {
        case 'gif':
          pixelBytes.add(
              crop.encodeGifAnimation(outputAnim.removeAt(0)) as Uint8List);
          emit(AnimImageEncodingUpdate(
            count: outputAnim.length,
            total: pixelLength!,
          ));
          break;
        case 'apng':
          pixelBytes.add(
              crop.encodePngAnimation(outputAnim.removeAt(0)) as Uint8List);
          emit(AnimImageEncodingUpdate(
            count: outputAnim.length,
            total: pixelLength!,
          ));

          break;
      }
    } else {
      emit(AnimImageCroped(
        cropedAnim: pixelBytes,
        mBytes: mBytes!,
      ));
    }
  }

  AnimImageBloc() : super(AnimImageInitial()) {
    on<AnimImageStartEvent>((event, emit) async {
      _reset();
      emit(AnimImageDecodeing());
      mBytes = event.mBytes;
      pixelLength = event.pixelLength;
      breakPoint = event.breakPoint;
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

      for (var i = 0; i < event.pixelLength; i++) {
        outputAnim.add(crop.Animation());
      }

      _emitNremove(
        emit: emit,
      );
    });

    crop.Image imageProfileSet(crop.Image n, crop.Image o) {
      n.channels = o.channels;
      n.xOffset = o.xOffset;
      n.yOffset = o.yOffset;
      n.duration = o.duration;
      n.blendMethod = o.blendMethod;
      n.iccProfile = o.iccProfile;
      return n;
    }

    on<AnimImageResumeEvent>((event, emit) {
      for (var i = 0; i < event.pixelCropData.length; i++) {
        outputAnim[i].addFrame(
          imageProfileSet(event.pixelCropData[i], currentImage!),
        );
      }

      _emitNremove(
        emit: emit,
      );
    });

    on<AnimImageEncodingResumeEvent>((event, emit) {
      _encondingAnim(emit: emit);
    });

    on<AnimImageResetEvent>((event, emit) {
      _reset();
      emit(AnimImageInitial());
    });

    on<AnimImageCaptureEvent>((event, emit) {
      emit(AnimImageCropingBuildComplated(
        breakPoint: breakPoint!,
        pixelLength: pixelLength!,
        imageBytes: event.imageBytes,
        done: anim.length,
        frameSize: frameSize!,
      ));
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
  switch (dIM.extension) {
    case 'gif':
      decodeAnim = crop.decodeGifAnimation(dIM.bytes)!.toList();
      break;
    case 'apng':
      decodeAnim = crop.decodePngAnimation(dIM.bytes)!.toList();
      break;
    default:
      decodeAnim = null;
  }
  return DecodeImgOut(list: decodeAnim);
}
