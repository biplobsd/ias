import 'package:flutter/material.dart';

class MenuData {
  final String name;
  final IconData? icon;
  final String path;
  final bool isActive;
  final bool isHover;

  MenuData(
      {required this.name,
      this.icon,
      required this.path,
      this.isActive = false,
      this.isHover = false});

  MenuData copyWith({
    String? name,
    IconData? icon,
    String? path,
    bool? isActive,
    bool? isHover,
  }) {
    return MenuData(
      name: name ?? this.name,
      icon: icon ?? this.icon,
      path: path ?? this.path,
      isActive: isActive ?? this.isActive,
      isHover: isHover ?? this.isHover,
    );
  }
}
