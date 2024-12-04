import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hoc24/app/config/app_colors.dart';
import 'package:hoc24/app/types/tab_type.dart';
import 'package:hoc24/presentation/controllers/home/home_controller.dart';
import 'package:hoc24/presentation/pages/dashboard/dashboard_page.dart';
import 'package:hoc24/presentation/pages/profile/profile_page.dart';
import 'package:hoc24/presentation/pages/questions/questions_page.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      print('object');
      controller.appController.setDarkMode(controller.appController.selectedDarkMode.value, context: context);
    });

    final List<Widget> bottomBarPages = [
      DashboardPage(
        jumpToProfile: controller.jumpToProfile,
      ),
      QuestionsPage(
        jumpToProfile: controller.jumpToProfile,
      ),
      const ProfilePage(),
    ];

    return Obx(
      () => Scaffold(
        body: PageView(
          controller: controller.pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: List.generate(bottomBarPages.length, (index) => bottomBarPages[index]),
        ),
        extendBody: true,
        bottomNavigationBar: AnimatedNotchBottomBar(
          /// Provide NotchBottomBarController
          notchBottomBarController: controller.bottomBarController,
          color: controller.appController.isDarkMode.value ? AppColors.darkTertiary : AppColors.lightBlue20,
          showLabel: true,
          textOverflow: TextOverflow.visible,
          maxLine: 1,
          shadowElevation: 2,
          kBottomRadius: 28.0,

          // notchShader: const SweepGradient(
          //   startAngle: 0,
          //   endAngle: pi / 2,
          //   colors: [Colors.red, Colors.green, Colors.orange],
          //   tileMode: TileMode.mirror,
          // ).createShader(Rect.fromCircle(center: Offset.zero, radius: 8.0)),
          notchColor: AppColors.lightBlue40,

          /// restart app if you change removeMargins
          removeMargins: false,
          bottomBarWidth: Get.width,
          showShadow: controller.appController.isDarkMode.value ? false : true,
          durationInMilliSeconds: 200,
          itemLabelStyle: const TextStyle(fontSize: 10),
          elevation: 1,
          bottomBarHeight: 56,
          bottomBarItems: buildWidgetBottomBarItem(),
          onTap: (index) {
            controller.onTapChanged(index);
          },
          kIconSize: 24.0,
        ),
      ),
    );
  }

  buildWidgetBottomBarItem() => [
        BottomBarItem(
          inActiveItem: TabType.dashboard.icon0,
          activeItem: TabType.dashboard.icon1,
          itemLabel: TabType.dashboard.title,
        ),
        BottomBarItem(
          inActiveItem: TabType.questions.icon0,
          activeItem: TabType.questions.icon1,
          itemLabel: TabType.questions.title,
        ),
        BottomBarItem(
          inActiveItem: TabType.profile.icon0,
          activeItem: TabType.profile.icon1,
          itemLabel: TabType.profile.title,
        ),
      ];
}
