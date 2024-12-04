import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hoc24/app/config/app_colors.dart';
import 'package:hoc24/presentation/controllers/subject/categories/categories_controller.dart';
import 'package:hoc24/presentation/pages/base/base_scaffold.dart';
import 'package:hoc24/presentation/widgets/app_loading.dart';

import 'card/chapter_card.dart';

class CategoriesPage extends GetView<CategoriesController> {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Obx(
      () => BaseScaffold(
        backgroundColor:
            controller.appController.isDarkMode.value ? AppColors.darkBackground : AppColors.lightBackground,
        appBar: AppBar(
          title: getAppBarTitle(),
        ),
        isPaddingDefault: true,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Chương trình học', style: theme.textTheme.titleLarge?.copyWith(fontSize: 22)),
            const SizedBox(height: 16),
            Expanded(child: _buildBooksList(theme)),
          ],
        ),
      ),
    );
  }

  Text getAppBarTitle() {
    String nameBook = controller.nameBook.replaceFirst('Hỗ trợ học sinh học sách', 'Sách');
    return Text('${controller.nameSubject} lớp ${controller.appController.grade} ($nameBook)');
  }

  Widget _buildBooksList(ThemeData theme) {
    return controller.pageLoading
        ? AppLoading(count: 4, height: Get.height / 5 - 20)
        : controller.categoriesList.isEmpty
            ? Center(child: Text('Nội dung đang được biên soạn', style: theme.textTheme.titleLarge))
            : ListView.separated(
                itemCount: controller.categoriesList.length,
                controller: controller.scrollController,
                itemBuilder: (BuildContext context, int index) {
                  return Obx(
                    () => ChapterCard(
                      categoriesEntity: controller.categoriesList[index],
                      isSelectedIndex: controller.selectedIndex.value == index,
                      index: index,
                      onTap: (_) => controller.onTap(index),
                    ),
                  );
                },
                separatorBuilder: (_, __) => const SizedBox(
                  height: 16,
                ),
              );
  }
}
