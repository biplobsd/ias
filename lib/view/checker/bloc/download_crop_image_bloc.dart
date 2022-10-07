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
  DownloadCropImageBloc() : super(DownloadCropImageInitial()) {
    on<DownloadCropImageSaveEvent>((event, emit) async {
      emit(DownloadCropImageZiping());
      final List<Uint8List> pixels;
      final String extension;

      pixels = event.pixels as List<Uint8List>;
      extension = event.mainImage.extension;

      var dateTimeNow = DateFormat('hmsdMyy').format(DateTime.now());
      String outFilename =
          '$dateTimeNow.zip';
      if (!kIsWeb) {
        String? savePath;
        if (Platform.isAndroid) {
          String? downloadsDirectoryPath =
              (await DownloadsPath.downloadsDirectory())?.path;
          if (downloadsDirectoryPath == null) {
            emit(DownloadCropImageError(
                errorMsg: 'Error while getting file save path'));
            return;
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

      ZipEncoder encoder = ZipEncoder();
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
        String fileName = '$i.$extension';
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

      OutputStream outputStream = OutputStream(
        byteOrder: LITTLE_ENDIAN,
      );
      List<int>? bytes = encoder.encode(
        archive,
        level: Deflate.BEST_SPEED,
        output: outputStream,
      );

      try {
        download(bytes!, outFilename);
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