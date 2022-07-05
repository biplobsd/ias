import 'package:flutter/material.dart';
import 'package:preloadwebapptemplate/view/widgets/responsiveness.dart';
import 'package:preloadwebapptemplate/data/model/menu_data.dart';
import 'package:preloadwebapptemplate/view/widgets/side_menu/side_menu_item/horizontal_menu_item.dart';
import 'package:preloadwebapptemplate/view/widgets/side_menu/side_menu_item/vertical_menu_item.dart';

class SideMenuItem extends StatelessWidget {
  final MenuData itemData;
  final void Function()? onTap;
  const SideMenuItem({
    required this.itemData,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (ResponsiveWidget.isCustomScreen(context)) {
      return VerticalMenuItem(itemData: itemData, onTap: onTap);
    }

    return HorizontalMenuItem(itemData: itemData, onTap: onTap);
  }
}
