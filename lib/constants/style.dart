import 'package:flutter/material.dart';

Color light = const Color(0xFFF7F8FC);
Color lightGrey = const Color(0xFFA4A6B3);
Color dark = const Color(0xFF363740);
Color active = const Color(0xFF3C19C0);

BoxDecoration continarDeco(BuildContext context) {
  return BoxDecoration(
    color: Theme.of(context).cardTheme.color,
    border:
        Border.all(color: Theme.of(context).backgroundColor.withOpacity(0.3)),
    borderRadius: BorderRadius.circular(10),
  );
}

OutlineInputBorder searchInputbrStyle(BuildContext context) =>
    OutlineInputBorder(
      borderSide: BorderSide(
          color: Theme.of(context).backgroundColor.withOpacity(0.3),
          width: 1.0),
      borderRadius: BorderRadius.circular(10),
    );
