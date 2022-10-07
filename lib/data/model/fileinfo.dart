import 'dart:convert';

import 'package:flutter/foundation.dart';

class Fileinfo {
  final String appName;
  final String webAppUrl;
  final String appVersion;
  final List<String> pixelsName;
  final String mainImageName;
  Fileinfo({
    required this.appName,
    required this.webAppUrl,
    required this.appVersion,
    required this.pixelsName,
    required this.mainImageName,
  });

  Fileinfo copyWith({
    String? appName,
    String? webAppUrl,
    String? appVersion,
    List<String>? pixelsName,
    String? mainImageName,
  }) {
    return Fileinfo(
      appName: appName ?? this.appName,
      webAppUrl: webAppUrl ?? this.webAppUrl,
      appVersion: appVersion ?? this.appVersion,
      pixelsName: pixelsName ?? this.pixelsName,
      mainImageName: mainImageName ?? this.mainImageName,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'appName': appName,
      'webAppUrl': webAppUrl,
      'appVersion': appVersion,
      'pixelsName': pixelsName,
      'mainImageName': mainImageName,
    };
  }

  factory Fileinfo.fromMap(Map<String, dynamic> map) {
    return Fileinfo(
      appName: map['appName'] as String,
      webAppUrl: map['webAppUrl'] as String,
      appVersion: map['appVersion'] as String,
      pixelsName: List<String>.from((map['pixelsName'] as List<String>)),
      mainImageName: map['mainImageName'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Fileinfo.fromJson(String source) =>
      Fileinfo.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Fileinfo(appName: $appName, webAppUrl: $webAppUrl, appVersion: $appVersion, pixelsName: $pixelsName, mainImageName: $mainImageName)';
  }

  @override
  bool operator ==(covariant Fileinfo other) {
    if (identical(this, other)) return true;

    return other.appName == appName &&
        other.webAppUrl == webAppUrl &&
        other.appVersion == appVersion &&
        listEquals(other.pixelsName, pixelsName) &&
        other.mainImageName == mainImageName;
  }

  @override
  int get hashCode {
    return appName.hashCode ^
        webAppUrl.hashCode ^
        appVersion.hashCode ^
        pixelsName.hashCode ^
        mainImageName.hashCode;
  }
}
