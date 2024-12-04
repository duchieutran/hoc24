import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hoc24/app/config/app_colors.dart';
import 'package:hoc24/app/config/app_text.dart';
import 'package:hoc24/presentation/controllers/subject/lesson_detail/lesson_detail_controller.dart';
import 'package:hoc24/presentation/pages/base/base_scaffold.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LessonDetailPage extends GetView<LessonDetailController> {
  final VoidCallback? jumpToProfile;
  const LessonDetailPage({super.key, this.jumpToProfile});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => BaseScaffold(
        isLoading: controller.pageLoading,
        isPaddingDefault: false,
        appBar: AppBar(
          title: Text(controller.title.value),
          leading: GestureDetector(
            onTap: () =>
                controller.isHome() ? Get.back() : controller.webViewControllerList[controller.tabIndex.value].goBack(),
            child: GetPlatform.isAndroid ? const Icon(Icons.arrow_back) : const Icon(Icons.arrow_back_ios_sharp),
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.home),
              onPressed: () {
                if (!controller.isHome()) {
                  controller.gotoHome();
                }
              },
            ),
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () {
                controller.webViewControllerList[controller.tabIndex.value].reload();
              },
            ),
          ],
        ),
        body: SafeArea(
          child: Column(
            children: [
              TabBar(
                isScrollable: true,
                dividerColor: AppColors.lightGrey,
                dividerHeight: 0.5,
                indicatorSize: TabBarIndicatorSize.label,
                // indicatorColor: AppColors.lightPrimary,
                // labelColor: AppColors.dark,
                tabAlignment: TabAlignment.start,
                unselectedLabelColor: AppColors.lightGrey,
                controller: controller.tabController,
                tabs: [
                  AutoSizeText(
                    'Lý thuyết',
                    textAlign: TextAlign.center,
                    style: text18.bold.height22Per,
                    minFontSize: 12,
                  ),
                  AutoSizeText(
                    'Trắc nghiệm',
                    textAlign: TextAlign.center,
                    style: text18.bold.height22Per,
                    minFontSize: 12,
                  ),
                  AutoSizeText(
                    'Bài tập SGK',
                    textAlign: TextAlign.center,
                    style: text18.bold.height22Per,
                    minFontSize: 12,
                  ),
                  AutoSizeText(
                    'Hỏi đáp',
                    textAlign: TextAlign.center,
                    style: text18.bold.height22Per,
                    minFontSize: 12,
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(
                  controller: controller.tabController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    WebViewWidget(controller: controller.webViewControllerList[0]),
                    WebViewWidget(controller: controller.webViewControllerList[1]),
                    WebViewWidget(controller: controller.webViewControllerList[2]),
                    WebViewWidget(controller: controller.webViewControllerList[3]),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
