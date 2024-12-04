import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:hoc24/app/config/app_colors.dart';
import 'package:hoc24/app/helpers/android_picker_helper.dart';
import 'package:hoc24/app/helpers/snack_bar_helper.dart';
import 'package:hoc24/data/providers/network/apis/api_constants.dart';
import 'package:hoc24/presentation/controllers/base_controller.dart';
import 'package:webview_flutter/webview_flutter.dart';

class QuestionsController extends BaseController {
  final WebViewController webViewController = WebViewController();
  String baseUrl = '';
  RxString currentUrl = ''.obs;
  RxString title = ''.obs;

  // final KeyboardVisibilityController keyboardVisibilityController = KeyboardVisibilityController();
  // RxBool isKeyboardVisible = false.obs;

  @override
  void onInit() {
    // keyboardVisibilityController.onChange.listen((bool visible) {
    //   isKeyboardVisible.value = visible;
    // });

    baseUrl = '$BASE_URL/posts?access_token=${appController.accessToken}';
    if (appController.isDarkMode.value) {
      baseUrl += DARK_MODE;
    }
    setUpWebView();
    super.onInit();
  }

  void setUpWebView() {
    webViewController
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(appController.isDarkMode.value ? AppColors.darkBackground : AppColors.light)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            pageLoadingOn();
          },
          onProgress: (int progress) {},
          onPageFinished: (String url) async {
            if (kDebugMode) {
              print('Page finished loading: $url');
            }
            currentUrl.value = url;
            await getPageTitle();
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
      ..loadRequest(Uri.parse(baseUrl));

    AndroidPickerHelper.addFileSelectionListener(webViewController);
  }

  bool isHome() {
    if (currentUrl.value == baseUrl) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> getPageTitle() async {
    title.value = await webViewController.getTitle() ?? 'Hoc24';
  }
}
