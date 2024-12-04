import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../app/config/app_colors.dart';

class AppLoading extends StatelessWidget {
  const AppLoading({
    super.key,
    this.isGridView = false,
    this.count = 4,
    this.crossAxisCount = 2,
    this.childAspectRatio = 0.88,
    this.gap = 16,
    this.borderRadius = const BorderRadius.all(Radius.circular(16)),
    this.height = 200,
  });

  final bool isGridView;
  final int count;
  final int crossAxisCount;
  final double childAspectRatio;
  final double gap;
  final BorderRadiusGeometry? borderRadius;
  final double height;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return isGridView
        ? Shimmer.fromColors(
            baseColor: Get.isDarkMode ? theme.colorScheme.secondary : AppColors.nature30,
            highlightColor: Get.isDarkMode ? AppColors.darkBackground : AppColors.nature20,
            enabled: true,
            child: GridView.count(
              padding: EdgeInsets.zero,
              crossAxisCount: crossAxisCount,
              mainAxisSpacing: gap,
              crossAxisSpacing: gap,
              childAspectRatio: childAspectRatio,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: List.generate(count, (index) {
                // Replace 'Container()' with the widget you want to display for each item.
                return Container(
                  decoration: BoxDecoration(borderRadius: borderRadius, color: AppColors.lightGrey),
                );
              }),
            ))
        : Shimmer.fromColors(
            baseColor: Get.isDarkMode ? theme.colorScheme.secondary : AppColors.nature30,
            highlightColor: Get.isDarkMode ? AppColors.darkBackground : AppColors.nature20,
            enabled: true,
            child: Column(
              children: List.generate(count, (index) {
                // Replace 'Container()' with the widget you want to display for each item.
                return Padding(
                  padding: EdgeInsets.only(bottom: gap),
                  child: Container(
                    height: height,
                    decoration: BoxDecoration(borderRadius: borderRadius, color: AppColors.lightGrey),
                  ),
                );
              }),
            ),
          );
  }
}
