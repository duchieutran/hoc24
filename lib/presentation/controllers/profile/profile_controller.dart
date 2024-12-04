import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:get/get.dart';
import 'package:hoc24/app/helpers/handle_exception_helper.dart';
import 'package:hoc24/app/helpers/snack_bar_helper.dart';
import 'package:hoc24/app/routes/app_pages.dart';
import 'package:hoc24/domain/models/request/get/get_data_request.dart';
import 'package:hoc24/presentation/controllers/base_controller.dart';

class ProfileController extends BaseController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  void goToPersonalInformationPage() {
    Get.toNamed('${Routes.personalInformation}?id=${appController.user?.id ?? ''}');
  }

  void goToDarkModePage() {
    Get.toNamed(Routes.darkMode);
  }

  void goToChangePasswordPage() {
    Get.toNamed(Routes.changePassword);
  }

  Future<void> deleteAccount() async {
    try {
      pageLoadingOn();
      GetDataRequest data = GetDataRequest(
        token: md5.convert(utf8.encode('ios-delete-user-olm${appController.accessToken}')).toString(),
        accessToken: appController.accessToken ?? '',
      );
      bool result = await graphQLService.deleteAccount(getDataRequest: data);

      if (result) {
        appController.onLogout();
        await storage.deleteMemo();
        SnackBarHelper.successSnackBar('Xoá tài khoản thành công', duration: const Duration(seconds: 2));
      }
    } catch (error) {
      HandleExceptionHelper.graphql(error);
    } finally {
      pageLoadingOff();
    }
  }
}
