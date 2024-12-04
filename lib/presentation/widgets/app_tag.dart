import 'package:flutter/material.dart';
import 'package:hoc24/app/config/app_colors.dart';
import 'package:hoc24/app/config/app_text.dart';

class AppTag extends StatelessWidget {
  const AppTag({
    super.key,
    required this.label,
    this.color = AppColors.lightPrimary,
    this.isShowIcon = false,
    this.isVisible = true,
  });
  final String? label;
  final Color? color;
  final bool isShowIcon;
  final bool isVisible;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isVisible,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(38),
          color: color,
        ),
        child: Row(
          children: [
            Text(label ?? '', textAlign: TextAlign.center, style: text12.bold.textDarkColor),
            if (isShowIcon)
              Transform.translate(
                offset: const Offset(8, 0),
                child: const Icon(
                  Icons.keyboard_arrow_down_outlined,
                  color: AppColors.dark,
                ),
              )
          ],
        ),
      ),
    );
  }
}
