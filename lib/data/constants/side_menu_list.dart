import 'package:flutter/material.dart';
import 'package:preloadwebapptemplate/view/asset_holder/asset_holder.dart';
import 'package:preloadwebapptemplate/view/history/history.dart';
import 'package:preloadwebapptemplate/view/checker/check_page.dart';
import 'package:preloadwebapptemplate/view/setting/setting_page.dart';
import 'package:preloadwebapptemplate/data/model/menu_data.dart';

final List<MenuData> sideMenuList = [
  MenuData(
    name: 'Checker',
    icon: Icons.check,
    path: CheckerPage.pathName,
  ),
  MenuData(
      name: 'Asset Holder',
      icon: Icons.assessment_outlined,
      path: AssetHolderPage.pathName),
  MenuData(
    name: 'History',
    icon: Icons.history,
    path: HistoryPage.pathName,
  ),
  MenuData(
    name: 'Settings',
    icon: Icons.settings,
    path: SettingPage.pathName,
  ),
];
