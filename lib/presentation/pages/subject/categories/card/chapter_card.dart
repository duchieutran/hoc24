import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hoc24/app/config/app_colors.dart';
import 'package:hoc24/domain/models/response/dashboard/categories_entity.dart';

import 'lessons.dart';

class ChapterCard extends StatelessWidget {
  final CategoriesEntity categoriesEntity;
  final bool isSelectedIndex;
  final int index;
  final void Function(int) onTap;
  const ChapterCard({
    super.key,
    required this.categoriesEntity,
    required this.isSelectedIndex,
    required this.index,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () => onTap(index),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 60,
                width: Get.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${categoriesEntity.title}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleLarge?.copyWith(height: 1.6),
                    ),
                  ],
                ),
              ),
              if (isSelectedIndex && categoriesEntity.children != null && categoriesEntity.children!.isNotEmpty)
                Column(
                  children: [
                    const SizedBox(height: 8),
                    const Divider(color: AppColors.lightGrey),
                    Transform.translate(
                      offset: const Offset(0, -18),
                      child: GestureDetector(
                        onTap: () => onTap(index),
                        child: SvgPicture.asset(
                          'assets/svg/icon_collapse.svg',
                        ),
                      ),
                    ),
                    SizedBox(
                      height: categoriesEntity.children!.length * 56,
                      child: TimeLine(
                        lessonList: categoriesEntity.children?.map((item) => item.title ?? '').toList() ?? [],
                        idLessonList: categoriesEntity.children?.map((item) => item.id ?? 0).toList() ?? [],
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
