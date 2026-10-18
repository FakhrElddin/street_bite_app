import 'package:flutter/material.dart';
import 'package:street_bite_app/generated/l10n.dart';

enum NavBarTab { home, orders, favorites, cart, profile }

class NavBarItemModel {
  final IconData icon;
  final IconData activeIcon;
  final NavBarTab tab;

  const NavBarItemModel({
    required this.icon,
    required this.activeIcon,
    required this.tab,
  });

  String getLabel(BuildContext context) {
    switch (tab) {
      case NavBarTab.home:
        return S.of(context).navHome;
      case NavBarTab.orders:
        return S.of(context).navOrders;
      case NavBarTab.favorites:
        return S.of(context).navFavorites;
      case NavBarTab.cart:
        return S.of(context).navCart;
      case NavBarTab.profile:
        return S.of(context).navProfile;
    }
  }
}
