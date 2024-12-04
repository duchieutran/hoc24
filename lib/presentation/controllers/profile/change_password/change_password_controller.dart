import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hoc24/app/helpers/handle_exception_helper.dart';
import 'package:hoc24/app/helpers/snack_bar_helper.dart';
import 'package:hoc24/domain/models/request/user/update_user_request.dart';
import 'package:hoc24/presentation/controllers/base_controller.dart';

class ChangePasswordController extends BaseController {
  final formKeySignUp = GlobalKey<FormState>();

  late TextEditingController oldPasswordController;
  late TextEditingController passwordController;
  late TextEditingController confirmPassController;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    oldPasswordController = TextEditingController();
    passwordController = TextEditingController();
    confirmPassController = TextEditingController();
  }

  @override
  void onClose() {
    oldPasswordController.dispose();
    passwordController.dispose();
    confirmPassController.dispose();
    super.onClose();
  }

  Future<void> changePassword(BuildContext context) async {
    try {
      pageLoadingOn();
      UpdateUserRequest data = UpdateUserRequest(
        formUpdateUser: FormUpdateUser(
          password: passwordController.text,
          oldPassword: oldPasswordController.text,
        ),
        accessToken: appController.accessToken ?? '',
      );
      bool result = await graphQLService.updateUser(updateUserRequest: data);

      if (result) {
        Navigator.pop(Get.context!);
        SnackBarHelper.successSnackBar('Đổi mật khẩu thành công', duration: const Duration(seconds: 2));
      }
    } catch (error) {
      HandleExceptionHelper.graphql(error);
    } finally {
      pageLoadingOff();
    }
  }
}
