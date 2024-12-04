import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hoc24/app/config/app_colors.dart';
import 'package:hoc24/domain/models/response/dashboard/article_entity.dart';
import 'package:hoc24/presentation/controllers/article/articles/articles_controller.dart';
import 'package:hoc24/presentation/pages/base/base_scaffold.dart';
import 'package:hoc24/presentation/widgets/app_loading.dart';

import 'card/articles_card.dart';

class ArticlesPage extends GetView<ArticlesController> {
  const ArticlesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => BaseScaffold(
        backgroundColor:
            controller.appController.isDarkMode.value ? AppColors.darkBackground : AppColors.lightBackground,
        appBar: AppBar(title: Text(controller.title)),
        isPaddingDefault: false,
        body: SafeArea(
          child: CustomScrollView(
            controller: controller.scrollController,
            slivers: [
              controller.pageLoading && controller.articleNodeList.isEmpty
                  ? SliverPadding(
                      padding: const EdgeInsets.all(16),
                      sliver: SliverToBoxAdapter(child: AppLoading(count: 4, height: Get.height / 5 - 10)),
                    )
                  : SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            ArticleNode articles = controller.articleNodeList[index];
                            return ArticlesCard(
                              articleNode: articles,
                              onTap: () => controller.goToArticlesDetailPage(articles.id.toString()),
                            );
                          },
                          childCount: controller.articleNodeList.length,
                        ),
                      ),
                    ),
              if (controller.pageLoading && controller.hasNextPage.value)
                const SliverPadding(
                  padding: EdgeInsets.only(bottom: 32),
                  sliver: SliverToBoxAdapter(child: CupertinoActivityIndicator()),
                )
            ],
          ),
        ),
      ),
    );
  }
}
