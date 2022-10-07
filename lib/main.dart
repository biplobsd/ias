import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'core/hive/hive_init.dart';
import 'view/app.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveInit.fireUp();
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(const MyApp());
}
