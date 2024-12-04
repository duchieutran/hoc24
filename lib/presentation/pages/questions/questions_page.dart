import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hoc24/presentation/controllers/questions/questions_controller.dart';
import 'package:hoc24/presentation/pages/base/base_scaffold.dart';
import 'package:webview_flutter/webview_flutter.dart';

class QuestionsPage extends GetView<QuestionsController> {
  final VoidCallback? jumpToProfile;
  const QuestionsPage({super.key, this.jumpToProfile});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (controller.appController.isNextPage.value) {
          controller.onInit();
          controller.appController.isNextPage.value = false;
        }
        return BaseScaffold(
          isLoading: controller.pageLoading,
          isPaddingDefault: false,
          // backgroundColor: AppColors.light,
          appBar: AppBar(
            title: Text(controller.title.value),
            leading: GestureDetector(
              onTap: () => controller.webViewController.goBack(),
              child: controller.isHome()
                  ? null
                  : GetPlatform.isAndroid
                      ? const Icon(Icons.arrow_back)
                      : const Icon(Icons.arrow_back_ios_sharp),
            ),
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.home),
                onPressed: () {
                  if (!controller.isHome()) controller.webViewController.loadRequest(Uri.parse(controller.baseUrl));
                },
              ),
              IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: () {
                  controller.webViewController.reload();
                },
              ),
            ],
          ),
          body: SafeArea(
            child: WebViewWidget(
              controller: controller.webViewController,
            ),
          ),
        );
      },
    );
  }
}
