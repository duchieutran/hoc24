import 'package:flutter/material.dart';
import 'package:hoc24/app/config/app_colors.dart';

class SocialIcon extends StatelessWidget {
  final String iconSrc;
  final void Function()? onPressed;

  const SocialIcon({super.key, required this.iconSrc, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
          decoration: BoxDecoration(
              border: Border.all(width: 1, color: AppColors.lightGrey),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(30)),
          child: ClipOval(child: Image.asset(iconSrc, width: 25, height: 25))),
    );
  }
}
