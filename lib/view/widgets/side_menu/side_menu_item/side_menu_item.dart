import 'package:flutter/material.dart';

import '../../../../data/model/menu_data.dart';
import '../../responsiveness.dart';
import 'horizontal_menu_item.dart';
import 'vertical_menu_item.dart';

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
