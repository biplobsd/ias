import 'dart:typed_data';

class MBytes {
  final Uint8List bytes;
  final String path;
  final String extension;
  MBytes({
    required this.bytes,
    required this.path,
    required this.extension,
  });
}
