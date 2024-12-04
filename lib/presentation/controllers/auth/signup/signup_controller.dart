import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hoc24/app/helpers/handle_exception_helper.dart';
import 'package:hoc24/app/helpers/snack_bar_helper.dart';
import 'package:hoc24/app/routes/app_pages.dart';
import 'package:hoc24/domain/models/request/user/login_request.dart';
import 'package:hoc24/domain/models/request/user/register_request.dart';
import 'package:hoc24/domain/repositories/user_repository.dart';
import 'package:hoc24/presentation/controllers/base_controller.dart';

class SignupController extends BaseController {
  final userRepository = Get.find<UserRepository>();

  final formKeySignUp = GlobalKey<FormState>();
  RxBool isPasswordVisible = false.obs;
  RxBool isPasswordConfirmVisible = false.obs;
  RxBool isAgreedToPrivacyPolicy = false.obs;

  late TextEditingController fullNameController;
  late TextEditingController usernameController;
  late TextEditingController phoneNumberController;
  late TextEditingController passwordController;
  late TextEditingController confirmPassController;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fullNameController = TextEditingController();
    usernameController = TextEditingController();
    phoneNumberController = TextEditingController();
    passwordController = TextEditingController();
    confirmPassController = TextEditingController();
  }

  @override
  void onClose() {
    fullNameController.dispose();
    usernameController.dispose();
    phoneNumberController.dispose();
    passwordController.dispose();
    confirmPassController.dispose();
    super.onClose();
  }

  Future<void> registerUser() async {
    try {
      pageLoadingOn();
      RegisterRequest data = RegisterRequest(
        name: fullNameController.text,
        email: usernameController.text,
        tel: phoneNumberController.text,
        password: passwordController.text,
      );
      await graphQLService.registerUser(registerRequest: data);
      SnackBarHelper.successSnackBar('Đã tạo tài khoản thành công');
      await onLogin();
    } catch (error) {
      HandleExceptionHelper.graphql(error);
    } finally {
      pageLoadingOff();
    }
  }

  Future<void> onLogin() async {
    try {
      LoginRequest data = LoginRequest(username: usernameController.text, password: passwordController.text);
      await userRepository.login(data);
      Get.offNamed(Routes.home);
    } catch (e, s) {
      HandleExceptionHelper.rest(e, s);
    }
  }
}
