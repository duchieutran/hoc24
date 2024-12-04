import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hoc24/app/config/app_colors.dart';
import 'package:hoc24/presentation/controllers/article/article_categories/article_categories_controller.dart';
import 'package:hoc24/presentation/pages/base/base_scaffold.dart';
import 'package:hoc24/presentation/widgets/app_loading.dart';

import 'card/article_categories_card.dart';

class ArticleCategoriesPage extends GetView<ArticleCategoriesController> {
  const ArticleCategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => BaseScaffold(
        backgroundColor:
            controller.appController.isDarkMode.value ? AppColors.darkBackground : AppColors.lightBackground,
        appBar: AppBar(
          title: const Text('Tin tức'),
        ),
        isPaddingDefault: true,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _buildBooksList()),
          ],
        ),
      ),
    );
  }

  Widget _buildBooksList() {
    return controller.pageLoading
        ? AppLoading(count: 4, height: Get.height / 5 - 16)
        : ListView.separated(
            itemCount: controller.articleCategoriesList.length,
            itemBuilder: (BuildContext context, int index) {
              return Obx(
                () => ArticleCategoriesCard(
                  articleCategories: controller.articleCategoriesList[index],
                  onTapDetail: controller.onTapDetail,
                  onTap: controller.goToArticlesDetailPage,
                ),
              );
            },
            separatorBuilder: (_, __) => const SizedBox(
              height: 16,
            ),
          );
  }
}
