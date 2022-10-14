import 'dart:typed_data';

class MBytes {
  final Uint8List bytes;
  final String path;
  final String extension;
  final String? dateTimeNow;
  MBytes({
    required this.bytes,
    required this.path,
    required this.extension,
    this.dateTimeNow,
  });

  MBytes copyWith({
    Uint8List? bytes,
    String? path,
    String? extension,
    String? dateTimeNow,
  }) {
    return MBytes(
      bytes: bytes ?? this.bytes,
      path: path ?? this.path,
      extension: extension ?? this.extension,
      dateTimeNow: dateTimeNow ?? this.dateTimeNow,
    );
  }
}
