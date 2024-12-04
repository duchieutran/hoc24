import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hoc24/app/config/app_colors.dart';
import 'package:hoc24/app/config/app_text.dart';
import 'package:hoc24/domain/models/response/dashboard/article_categories_entity.dart';
import 'package:hoc24/domain/models/response/dashboard/article_entity.dart';

import 'custom_time_line.dart';

class ArticleCategoriesCard extends StatelessWidget {
  final ArticleCategoriesEntity articleCategories;
  final Function(int, String) onTapDetail;
  final Function(String) onTap;

  const ArticleCategoriesCard({
    super.key,
    required this.articleCategories,
    required this.onTapDetail,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        '${articleCategories.title}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.titleLarge,
                      ),
                    ),
                    TextButton(
                      onPressed: () => onTapDetail(articleCategories.id ?? 0, articleCategories.title ?? ''),
                      child: Text(
                        'Xem thêm',
                        style: text18.bold.textPrimaryColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            if (articleCategories.featureArticle != null && articleCategories.featureArticle!.isNotEmpty)
              _buildListArticles(),
          ],
        ),
      ),
    );
  }

  Column _buildListArticles() {
    List<ArticleNode> articleList = articleCategories.featureArticle ?? [];

    return Column(
      children: [
        const Divider(color: AppColors.lightGrey),
        const SizedBox(height: 16),
        SizedBox(
          height: articleCategories.featureArticle!.length * 55.2,
          child: ListView.builder(
            itemCount: articleList.length,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => CustomTimeLineWidget(
              index: index,
              lessons: articleList.map((item) => item.title ?? '').toList(),
              onTap: () => onTap(articleList[index].id.toString()),
            ),
          ).animate(delay: 0.ms).slideY(begin: 0.2, end: -0.01),
        ),
      ],
    );
  }
}
