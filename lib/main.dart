import 'dart:io';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'constants/string.dart';
import 'core/hive/hive_init.dart';
import 'view/app.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveInit.fireUp();
  await MobileAds.instance.initialize();
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(const MyApp());

  if (!kIsWeb && Platform.isWindows) {
    doWhenWindowReady(() {
      final win = appWindow;
      win.minSize = const Size(450, 550);
      win.size = const Size(1024, 640);
      win.alignment = Alignment.center;
      win.title = AppString.appName;
      win.show();
    });
  }
}
