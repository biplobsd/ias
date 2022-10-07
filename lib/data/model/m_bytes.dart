import 'dart:typed_data';

class MBytes {
  final Uint8List bytes;
  final String path;
  final String extension;
  final bool isAnim;
  MBytes({
    required this.isAnim,
    required this.bytes,
    required this.path,
    required this.extension,
  });
}
