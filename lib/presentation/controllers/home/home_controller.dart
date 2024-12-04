import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:hoc24/presentation/controllers/base_controller.dart';

class HomeController extends BaseController {
  final pageController = PageController(initialPage: 0);
  final NotchBottomBarController bottomBarController = NotchBottomBarController(index: 0);

  onTapChanged(int index) {
    pageController.jumpToPage(index);
    appController.isNextPage.value = true;
  }

  jumpToProfile() {
    pageController.jumpToPage(2);
    bottomBarController.jumpTo(2);
  }

  @override
  Future<void> onInit() async {
    super.onInit();
  }
}
