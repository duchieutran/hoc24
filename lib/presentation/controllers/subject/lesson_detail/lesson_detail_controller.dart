import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hoc24/app/config/app_colors.dart';
import 'package:hoc24/app/helpers/android_picker_helper.dart';
import 'package:hoc24/app/helpers/snack_bar_helper.dart';
import 'package:hoc24/data/providers/network/apis/api_constants.dart';
import 'package:hoc24/presentation/controllers/base_controller.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LessonDetailController extends BaseController with GetSingleTickerProviderStateMixin {
  final List<WebViewController> webViewControllerList =
      List<WebViewController>.generate(4, (index) => WebViewController());
  late TabController tabController;
  RxInt tabIndex = 0.obs;

  List<String> baseUrl = List<String>.generate(4, (index) => '');
  List<String> currentUrl = List<String>.generate(4, (index) => '');
  RxString title = ''.obs;
  RxInt id = 0.obs;

  @override
  void onInit() {
    final args = Get.arguments as Map<String, dynamic>;
    title.value = args['title'] ?? '';
    id.value = args['id'] ?? 0;

    tabController = TabController(length: 4, vsync: this);
    tabController.addListener(updateTabIndex);

    baseUrl[0] = '$BASE_URL/category/$id?access_token=${appController.accessToken}';
    baseUrl[1] = '$BASE_URL/practice/$id?access_token=${appController.accessToken}';
    baseUrl[2] = '$BASE_URL/posts?access_token=${appController.accessToken}&id_category=$id&ft=sgk';
    baseUrl[3] = '$BASE_URL/posts?access_token=${appController.accessToken}&id_category=$id';
    if (appController.isDarkMode.value) {
      baseUrl[0] += DARK_MODE;
      baseUrl[1] += DARK_MODE;
      baseUrl[2] += DARK_MODE;
      baseUrl[3] += DARK_MODE;
    }
    setUpWebView();

    super.onInit();
  }

  Future<void> setUpWebView() async {
    for (int i = 0; i < 4; i++) {
      webViewControllerList[i]
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setBackgroundColor(appController.isDarkMode.value ? AppColors.darkBackground : AppColors.light)
        ..setNavigationDelegate(
          NavigationDelegate(
            onPageStarted: (String url) {
              currentUrl[i] = url;
              pageLoadingOn();
            },
            onProgress: (int progress) {},
            onPageFinished: (String url) async {
              if (kDebugMode) {
                print('Page finished loading: $url');
              }
              pageLoadingOff();
            },
            onHttpError: (HttpResponseError error) {
              if (kDebugMode) {
                print('Http error code: ${error.response?.statusCode}');
              }
              if (error.response?.statusCode == 401) {
                appController.onLogout();
                SnackBarHelper.errorSnackBar('Phiên đăng nhập của bạn đã hết hạn');
              }
            },
            onWebResourceError: (WebResourceError error) {
              if (kDebugMode) {
                print('Webview resource error ${error.errorCode}');
              }
              gotoHome();
            },
            onNavigationRequest: (NavigationRequest request) {
              if (request.url.contains("hoc24://")) {
                Get.toNamed(request.url.replaceAll("hoc24://", "").trim());
                return NavigationDecision.prevent;
              }
              return NavigationDecision.navigate;
            },
          ),
        )
        ..loadRequest(Uri.parse(baseUrl[i]));

      AndroidPickerHelper.addFileSelectionListener(webViewControllerList[i]);
    }
  }

  bool isHome() {
    if (currentUrl[tabIndex.value] == baseUrl[tabIndex.value]) {
      return true;
    } else {
      return false;
    }
  }

  void gotoHome() {
    webViewControllerList[tabIndex.value].loadRequest(Uri.parse(baseUrl[tabIndex.value]));
  }

  void updateTabIndex() {
    tabIndex.value = tabController.index;
  }
}
