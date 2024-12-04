import 'package:flutter/material.dart';
import 'package:hoc24/app/helpers/handle_exception_helper.dart';
import 'package:hoc24/app/helpers/snack_bar_helper.dart';
import 'package:hoc24/domain/models/request/user/update_user_request.dart';
import 'package:hoc24/presentation/controllers/base_controller.dart';

class EditPersonalInformationController extends BaseController {
  final formKey = GlobalKey<FormState>();

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  void onInit() {
    usernameController.text = appController.user?.name ?? '';
    emailController.text = appController.user?.email ?? '';
    phoneController.text = appController.user?.tel ?? '';

    super.onInit();
  }

  @override
  void onClose() {
    usernameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.onClose();
  }

  Future<void> onUpdate(BuildContext context) async {
    try {
      pageLoadingOn();
      UpdateUserRequest data = UpdateUserRequest(
        formUpdateUser: FormUpdateUser(
          tel: phoneController.text,
        ),
        accessToken: appController.accessToken ?? '',
      );
      bool result = await graphQLService.updateUser(updateUserRequest: data);
      await Future.delayed(const Duration(seconds: 5));
      if (result) {
        SnackBarHelper.successSnackBar('Cập nhật thông tin thành công', duration: const Duration(seconds: 2));
      }
    } catch (error) {
      HandleExceptionHelper.graphql(error);
    } finally {
      pageLoadingOff();
    }
  }
}
