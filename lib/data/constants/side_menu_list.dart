import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utility/function/helper.dart';
import '../../view/checker/check_page.dart';
import '../../view/cubit/save_file_location_cubit.dart';
import '../../view/privacy_policy/privacy_policy.dart';
import '../../view/setting/setting_page.dart';
import '../model/menu_data.dart';
final SaveFileLocationCubit saveFileLocationCubit = SaveFileLocationCubit();

final List<MenuData> sideMenuList = [
  MenuData(
    name: CheckerPage.pageName,
    icon: Icons.horizontal_split,
    path: CheckerPage.pathName,
  ),
  if (!kIsWeb)
    MenuData(
      name: 'Save files',
      icon: Icons.save_rounded,
      path: '',
      isOpen: () async {
        var rawDir = await Helper.getDataDirectory();
        if (rawDir == null) {
          return;
        }
        if (Platform.isAndroid) {
          saveFileLocationCubit.showMsg(rawDir);
        } else {
          await launchUrl(
            Uri.directory(
              rawDir,
            ),
          );
        }
      },
    ),
  MenuData(
    name: PrivacyPolicy.pageName,
    icon: Icons.privacy_tip,
    path: PrivacyPolicy.pathName,
  ),
  MenuData(
    name: SettingPage.pageName,
    icon: Icons.settings,
    path: SettingPage.pathName,
  ),
];
