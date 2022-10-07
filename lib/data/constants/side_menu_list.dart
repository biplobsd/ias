import 'package:flutter/material.dart';

import '../../view/asset_holder/asset_holder.dart';
import '../../view/checker/check_page.dart';
import '../../view/history/history.dart';
import '../../view/privacy_policy/privacy_policy.dart';
import '../../view/setting/setting_page.dart';
import '../model/menu_data.dart';

final List<MenuData> sideMenuList = [
  MenuData(
    name: CheckerPage.pageName,
    icon: Icons.check,
    path: CheckerPage.pathName,
  ),
  MenuData(
      name: AssetHolderPage.pageName,
      icon: Icons.assessment_outlined,
      path: AssetHolderPage.pathName),
  MenuData(
    name: HistoryPage.pageName,
    icon: Icons.history,
    path: HistoryPage.pathName,
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
