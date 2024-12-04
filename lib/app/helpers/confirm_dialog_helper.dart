import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hoc24/app/config/app_colors.dart';
import 'package:hoc24/app/config/app_text.dart';

class ConfirmDialogHelper extends StatelessWidget {
  const ConfirmDialogHelper({super.key, required this.title, this.onPress, this.widget});

  final String title;
  final void Function()? onPress;
  final Widget? widget;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AlertDialog(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(30))),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/images/logohoc24.png',
            height: 120,
            width: Get.width,
          ),
          Text(title, style: theme.textTheme.bodyLarge, textAlign: TextAlign.center),
          if (widget != null)
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: widget!,
            ),
        ],
      ),
      actions: [
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.light,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: const BorderSide(color: AppColors.lightPrimary),
                    ),
                  ),
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text('Huỷ', style: TextStyle(fontSize: 16, color: AppColors.lightPrimary)),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.lightPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: onPress,
                  child: Text('Đồng ý', style: text16.textLightColor),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
