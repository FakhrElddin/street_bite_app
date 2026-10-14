import 'package:flutter/material.dart';

class NavBarItemModel {
  final IconData icon;
  final IconData activeIcon;
  final String label;

  const NavBarItemModel({
    required this.icon,
    required this.activeIcon,
    required this.label,
  });
}
