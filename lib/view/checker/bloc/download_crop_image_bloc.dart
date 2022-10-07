// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:io';

import 'package:archive/archive.dart';
import 'package:bloc/bloc.dart';
import 'package:download/download.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:lecle_downloads_path_provider/lecle_downloads_path_provider.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

import '../../../constants/string.dart';
import '../../../data/model/fileinfo.dart';
import '../../../data/model/m_bytes.dart';

part 'download_crop_image_event.dart';
part 'download_crop_image_state.dart';

class DownloadCropImageBloc
    extends Bloc<DownloadCropImageEvent, DownloadCropImageState> {
  Future<String?> _outputPath(
      String pre, Emitter<DownloadCropImageState> emit) async {
    String outFilename = pre;
    if (!kIsWeb) {
      String? savePath;
      if (Platform.isAndroid) {
        String? downloadsDirectoryPath =
            (await DownloadsPath.downloadsDirectory())?.path;
        if (downloadsDirectoryPath == null) {
          emit(DownloadCropImageError(
              errorMsg: 'Error while getting file save path'));
          return null;
        }
        savePath = downloadsDirectoryPath;
      } else {
        savePath = (await getApplicationDocumentsDirectory()).path;
      }

      String pathDir = path.join(savePath, AppString.shortName);
      Directory(pathDir).createSync();
      outFilename = path.join(pathDir, outFilename);
      if (kDebugMode) {
        print(outFilename);
      }
    }
    return outFilename;
  }

  DownloadCropImageBloc() : super(DownloadCropImageInitial()) {
    on<DownloadCropImageSaveSingleEvent>((event, emit) async {
      emit(DownloadCropImageZiping());
      await Future.delayed(const Duration(milliseconds: 10));
      var dateTimeNow = DateFormat('hmsdMyy').format(DateTime.now());
      String outFilename =
          '${event.id}_${path.basename(event.mBytes.path).substring(0, event.mBytes.extension.length)}_$dateTimeNow.png';
      var m = await _outputPath(outFilename, emit);
      if (m == null) {
        return;
      } else {
        outFilename = m;
      }
      try {
        download(event.imageBytes, outFilename);
      } on Exception catch (e) {
        emit(DownloadCropImageError(
          errorMsg: '$e',
        ));
        return;
      }
      emit(DownloadCropImageDone(
        fileName: outFilename,
        share: event.share,
      ));
    });

    on<DownloadCropImageSaveEvent>((event, emit) async {
      emit(DownloadCropImageZiping());
      await Future.delayed(const Duration(milliseconds: 10));
      final List<Uint8List> pixels;
      pixels = event.pixels;
      var dateTimeNow = DateFormat('hmsdMyy').format(DateTime.now());
      String outFilename =
          '${path.basename(event.mainImage.path).substring(0, event.mainImage.extension.length)}_$dateTimeNow.zip';
      var m = await _outputPath(outFilename, emit);
      if (m == null) {
        return;
      } else {
        outFilename = m;
      }

      Archive archive = Archive();

      // main file
      if (kDebugMode) {
        print(event.mainImage.path);
      }
      String mainImageName = path.basename(event.mainImage.path);
      ArchiveFile archiveFiles = ArchiveFile(
        mainImageName,
        event.mainImage.bytes.lengthInBytes,
        event.mainImage.bytes,
      );
      archive.addFile(archiveFiles);

      // pixel files
      List<String> pixelsName = [];
      for (var i = 0; i < pixels.length; i++) {
        Uint8List pixleBytes = pixels[i];
        String fileName = '$i.png';
        ArchiveFile pixel = ArchiveFile(
          fileName,
          pixleBytes.lengthInBytes,
          pixleBytes,
        );
        pixelsName.add(fileName);
        archive.addFile(pixel);
      }

      Map<String, dynamic> fileinfo = Fileinfo(
        appName: event.packageInfo.appName,
        webAppUrl: AppString.webAppUrl,
        appVersion: event.packageInfo.version,
        pixelsName: pixelsName,
        mainImageName: mainImageName,
      ).toMap();

      const JsonEncoder encoderJson = JsonEncoder.withIndent('  ');

      final String jsonString = encoderJson.convert(fileinfo);

      archive.addFile(
        ArchiveFile(
          'fileinfo.json',
          jsonString.codeUnits.length,
          jsonString.codeUnits,
        ),
      );

      var bytesRaw = await compute<Archive, OutputArchiveBytes>(
        archiveEncoding,
        archive,
      );

      try {
        download(bytesRaw.bytes!, outFilename);
      } on Exception catch (e) {
        emit(DownloadCropImageError(
          errorMsg: '$e',
        ));
        return;
      }
      emit(DownloadCropImageDone(fileName: outFilename));
    });
  }
}

class OutputArchiveBytes {
  final List<int>? bytes;
  OutputArchiveBytes({
    this.bytes,
  });
}

OutputArchiveBytes archiveEncoding(Archive archive) {
  ZipEncoder encoder = ZipEncoder();
  OutputStream outputStream = OutputStream(
    byteOrder: LITTLE_ENDIAN,
  );
  return OutputArchiveBytes(
    bytes: encoder.encode(
      archive,
      level: Deflate.BEST_SPEED,
      output: outputStream,
    ),
  );
}
