import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hoc24/app/config/app_colors.dart';

class FeatureCard extends StatelessWidget {
  final String? name;
  final String? path;
  final VoidCallback? onTap;
  const FeatureCard({super.key, this.name, this.path, this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    double size = 120;
    if (Get.width < 430) {
      size = Get.width / 3 - 22;
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Get.isDarkMode ? AppColors.darkSecondary : AppColors.lightBlue10,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/data/$path.png',
              width: 40,
              errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                return Image.asset("assets/subjects/exam.png", width: 40);
              },
            ),
            const SizedBox(height: 12),
            FittedBox(fit: BoxFit.scaleDown, child: Text(name ?? 'Tin tức', style: theme.textTheme.bodyMedium)),
          ],
        ),
      ),
    );
  }
}
