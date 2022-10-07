import 'package:flutter/material.dart';
import 'package:ias/view/asset_holder/asset_holder.dart';
import 'package:ias/view/history/history.dart';
import 'package:ias/view/checker/check_page.dart';
import 'package:ias/view/setting/setting_page.dart';
import 'package:ias/data/model/menu_data.dart';

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
    name: SettingPage.pageName,
    icon: Icons.settings,
    path: SettingPage.pathName,
  ),
];
