import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:hoc24/app/config/app_colors.dart';
import 'package:hoc24/app/config/app_text.dart';
import 'package:hoc24/presentation/controllers/dashboard/dashboard_controller.dart';
import 'package:hoc24/presentation/pages/article/article_categories/card/custom_time_line.dart';
import 'package:hoc24/presentation/pages/base/base_scaffold.dart';
import 'package:hoc24/presentation/pages/dashboard/card/feature_card.dart';
import 'package:hoc24/presentation/pages/dashboard/card/subject_card.dart';
import 'package:hoc24/presentation/widgets/app_carousel_slider_image.dart';
import 'package:hoc24/presentation/widgets/app_loading.dart';

class DashboardPage extends GetView<DashboardController> {
  final VoidCallback? jumpToProfile;
  const DashboardPage({super.key, this.jumpToProfile});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BaseScaffold(
      isPaddingDefault: false,
      isShowAppBarCustom: true,
      onTapChanged: jumpToProfile,
      body: Obx(
        () => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // const SizedBox(height: 16),
                // controller.banner == null
                //     ? Container()
                //     : Center(
                //         child: SizedBox(
                //           width: controller.banner?.size.width.toDouble(),
                //           height: controller.banner?.size.height.toDouble(),
                //           child: AdWidget(ad: controller.banner!),
                //         ),
                //       ),
                const SizedBox(height: 16),
                controller.pageLoading || controller.bannerList.isEmpty
                    ? AppLoading(count: 1, height: Get.size.width * 0.35)
                    : AppCarouselSliderImage(
                        bannerList: controller.bannerList,
                      ),
                const SizedBox(height: 32),
                _buildSelectSubject(theme),
                const SizedBox(height: 56),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FeatureCard(
                      name: 'Xếp hạng',
                      path: 'charts',
                      onTap: () => controller.goToUserBoardsPage(),
                    ),
                    const SizedBox(width: 16),
                    FeatureCard(
                      name: 'Đề thi',
                      path: 'exam',
                      onTap: () => controller.goToExaminationPage(),
                    ),
                    const SizedBox(width: 16),
                    FeatureCard(
                      name: 'Tin tức',
                      path: 'news',
                      onTap: () => controller.goToArticleCategoriesPage(),
                    ),
                  ],
                ),
                // const SizedBox(height: 16),
                // Row(
                //   children: [
                //     FeatureCard(
                //       name: 'Cuộc thi vui',
                //       path: 'contest',
                //       onTap: () => controller.goToContestPage(),
                //     ),
                //     const SizedBox(width: 16),
                //     FeatureCard(
                //       name: 'Khen thưởng',
                //       path: 'bonus',
                //       onTap: () => controller.goToContestPage(),
                //     ),
                //     const SizedBox(width: 16),
                //     Expanded(
                //       child: Container(),
                //     ),
                //   ],
                // ),
                const SizedBox(height: 56),
                _buildArticles(theme),
                const SafeArea(
                  child: SizedBox(height: 16),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSelectSubject(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Chọn môn học', style: theme.textTheme.titleMedium?.copyWith(fontSize: 24)),
        const SizedBox(height: 16),
        controller.pageLoading
            ? const AppLoading(
                count: 3,
                crossAxisCount: 3,
                isGridView: true,
                childAspectRatio: 0.7,
              )
            : SizedBox(
                height: 180,
                width: Get.width,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Transform.translate(
                      offset: const Offset(0, 22),
                      child: Container(
                        height: 6,
                        width: 38,
                        decoration: BoxDecoration(color: AppColors.nature30, borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                    RawScrollbar(
                      thumbColor: AppColors.lightPrimary,
                      crossAxisMargin: -114,
                      mainAxisMargin: Get.width / 2 - 35,
                      thumbVisibility: true,
                      controller: controller.scrollController,
                      radius: const Radius.circular(8.0),
                      thickness: 6.0,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        controller: controller.scrollController,
                        itemCount: controller.subjectsList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return SubjectCard(
                            subjectEntity: controller.subjectsList[index],
                            onTap: controller.onTap,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
      ],
    );
  }

  Widget _buildArticles(ThemeData theme) {
    return Card(
      color: controller.appController.isDarkMode.value ? AppColors.darkSecondary : AppColors.lightBlue10,
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
                        'Tin tức và sự kiện',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.titleLarge,
                      ),
                    ),
                    TextButton(
                      onPressed: () => controller.goToArticleCategoriesPage(),
                      child: Text(
                        'Xem thêm',
                        style: text18.bold.textPrimaryColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            _buildListArticles(),
          ],
        ),
      ),
    );
  }

  Column _buildListArticles() {
    return Column(
      children: [
        const Divider(color: AppColors.lightGrey),
        const SizedBox(height: 16),
        SizedBox(
          height: controller.articleList.length * 55.2,
          child: ListView.builder(
            itemCount: controller.articleList.length,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => CustomTimeLineWidget(
              index: index,
              lessons: controller.articleList.map((item) => item.title ?? '').toList(),
              onTap: () => controller.goToArticlesDetailPage(controller.articleList[index].id.toString()),
            ),
          ).animate(delay: 0.ms).slideY(begin: 0.2, end: -0.01),
        ),
      ],
    );
  }
}
