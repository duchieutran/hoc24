import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hoc24/app/routes/app_pages.dart';
import 'package:hoc24/presentation/controllers/app_controller.dart';

class RedirectMiddleware extends GetMiddleware {
  RedirectMiddleware() : super(priority: 1);

  @override
  RouteSettings? redirect(String? route) {
    final appController = Get.find<AppController>();
    if (!appController.isLoggedIn && route != Routes.login) {
      return RouteSettings(name: Routes.login);
    }
    if (appController.grade.value == -1) {
      return RouteSettings(name: Routes.fillInformation);
    }
    if (route != Routes.home) {
      return RouteSettings(name: Routes.home);
    }
    return null;
  }
}
