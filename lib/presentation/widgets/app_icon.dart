import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:hoc24/app/config/app_text.dart';

class AppIcon extends StatelessWidget {
  final Color? color;
  final double size;
  final IconData icon;
  final bool isVisible;
  final int countBadges;

  const AppIcon({
    super.key,
    this.color = Colors.black,
    this.size = 24,
    required this.icon,
    this.isVisible = true,
    this.countBadges = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
        visible: isVisible,
        child: badges.Badge(
          position: badges.BadgePosition.topEnd(top: -10, end: -12),
          showBadge: countBadges != 0,
          badgeContent: Text(
            countBadges > 99 ? '99+' : countBadges.toString(),
            style: text12.bold.textLightColor,
          ),
          // badgeStyle: badges.BadgeStyle(color),
          child: Icon(
            icon,
            color: color,
            size: size,
          ),
        ));
  }
}
