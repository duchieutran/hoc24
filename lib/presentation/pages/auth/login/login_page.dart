import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hoc24/app/config/app_colors.dart';
import 'package:hoc24/app/config/app_text.dart';
import 'package:hoc24/app/helpers/confirm_dialog_helper.dart';
import 'package:hoc24/app/routes/app_pages.dart';
import 'package:hoc24/presentation/controllers/auth/login/login_controller.dart';
import 'package:hoc24/presentation/widgets/app_button.dart';
import 'package:hoc24/presentation/widgets/app_text_field.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Obx(
      () => Scaffold(
        backgroundColor:
            controller.appController.isDarkMode.value ? AppColors.darkBackground : AppColors.lightBackground,
        appBar: AppBar(
          title: const Text('Đăng nhập'),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: controller.formKeySignIn,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildForm(),
                  const SizedBox(height: 16),
                  AppButton(
                    text: 'Đăng nhập',
                    onPressed: () async {
                      if (controller.formKeySignIn.currentState!.validate()) {
                        await controller.loginWithEmail();
                      }
                    },
                    isLoading: controller.pageLoading,
                  ),
                  // if (GetPlatform.isIOS) const SizedBox(height: 24),
                  // if (GetPlatform.isIOS) const NameDivider(text: 'Hoặc tiếp tục với'),
                  // if (GetPlatform.isIOS)
                  //   Row(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: [
                  //       // SocialIcon(iconSrc: 'assets/images/facebook.png', onPressed: () {}),
                  //       SocialIcon(iconSrc: 'assets/images/google.png', onPressed: () => controller.loginWithGoogle()),
                  //       // SocialIcon(iconSrc: 'assets/images/apple.png', onPressed: () {})
                  //     ],
                  //   ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Chưa có tài khoản ? ", style: theme.textTheme.bodyMedium),
                      GestureDetector(
                        onTap: () {
                          Get.offNamed(Routes.signup);
                        },
                        child: Text('Đăng ký', style: text16.textPrimaryColor),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Card _buildForm() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Image.asset(
              'assets/images/logohoc24.png',
              height: 120,
            ),
            const SizedBox(height: 16),
            AppTextField(
              title: 'Tên đăng nhập/Email',
              hintText: 'example@gmail.com',
              controller: controller.emailController,
              onChanged: (value) {},
              icon: Icons.circle,
              iconColor: Colors.transparent,
              obscureText: false,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Vui lòng nhập tên đăng nhập hoặc email';
                }
                return null;
              },
            ),
            const SizedBox(height: 24),
            AppTextField(
              title: 'Mật khẩu',
              hintText: 'Mật khẩu',
              controller: controller.passwordController,
              onChanged: (value) {},
              icon: controller.passwordVisible.value ? Icons.visibility : Icons.visibility_off,
              iconColor: AppColors.lightPrimary,
              obscureText: !controller.passwordVisible.value,
              onClickIcon: () {
                controller.passwordVisible.value = !controller.passwordVisible.value;
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Vui lòng nhập mật khẩu';
                }
                return null;
              },
            ),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () {
                controller.isRememberLogin.value = !controller.isRememberLogin.value;
              },
              child: Row(
                children: [
                  Container(
                    width: 18,
                    height: 18,
                    margin: const EdgeInsets.only(right: 10),
                    child: Checkbox(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                      value: controller.isRememberLogin.value,
                      activeColor: AppColors.lightPrimary,
                      onChanged: (bool? value) {
                        controller.isRememberLogin.value = value!;
                      },
                    ),
                  ),
                  Text('Ghi nhớ', style: text16),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      Get.dialog(
                        ConfirmDialogHelper(
                          title: "Bạn muốn đặt lại mật khẩu\nVui lòng nhập email",
                          widget: Form(
                            key: controller.formKeyForgetPassword,
                            child: AppTextField(
                              title: 'Email',
                              hintText: "example@gmail.com",
                              onChanged: (value) {},
                              controller: controller.emailController,
                              // prefixIcon: Icons.email_outlined,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Vui lòng nhập email';
                                }
                                return null;
                              },
                            ),
                          ),
                          onPress: () {
                            if (controller.formKeyForgetPassword.currentState!.validate()) {
                              controller.sendMailForgetPassword();
                            }
                          },
                        ),
                      );
                    },
                    child: Text('Quên mật khẩu?', style: text16.textPrimaryColor),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
