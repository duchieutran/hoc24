import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hoc24/presentation/controllers/article/articles_detail/articles_detail_controller.dart';
import 'package:hoc24/presentation/pages/base/base_scaffold.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticlesDetailPage extends GetView<ArticlesDetailController> {
  const ArticlesDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => BaseScaffold(
        isLoading: controller.pageLoading,
        isPaddingDefault: false,
        appBar: AppBar(
          title: Text(
            controller.title.value,
          ),
          leading: GestureDetector(
            onTap: () => controller.isHome() ? Get.back() : controller.webViewController.goBack(),
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
      ),
    );
  }
}
