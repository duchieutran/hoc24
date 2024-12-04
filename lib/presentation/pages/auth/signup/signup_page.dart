import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hoc24/app/config/app_colors.dart';
import 'package:hoc24/app/config/app_text.dart';
import 'package:hoc24/app/helpers/snack_bar_helper.dart';
import 'package:hoc24/app/routes/app_pages.dart';
import 'package:hoc24/presentation/controllers/auth/signup/signup_controller.dart';
import 'package:hoc24/presentation/widgets/app_button.dart';
import 'package:hoc24/presentation/widgets/app_text_field.dart';
import 'package:url_launcher/url_launcher.dart';

class SignupPage extends GetView<SignupController> {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Obx(
      () => Scaffold(
        backgroundColor:
            controller.appController.isDarkMode.value ? AppColors.darkBackground : AppColors.lightBackground,
        appBar: AppBar(
          title: const Text('Đăng ký'),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: controller.formKeySignUp,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildForm(theme),
                  const SizedBox(height: 16),
                  AppButton(
                    text: 'Đăng ký',
                    onPressed: () async {
                      FocusManager.instance.primaryFocus?.unfocus();
                      if (controller.formKeySignUp.currentState!.validate()) {
                        if (controller.isAgreedToPrivacyPolicy.value) {
                          await controller.registerUser();
                        } else {
                          if (Get.isSnackbarOpen) {
                            return;
                          }
                          SnackBarHelper.errorSnackBar(
                            'Vui lòng đồng ý với chính sách và điều khoản',
                            duration: const Duration(seconds: 2),
                          );
                        }
                      }
                    },
                    isLoading: controller.pageLoading,
                  ),
                  // if (GetPlatform.isIOS) const NameDivider(text: 'Hoặc tiếp tục với'),
                  // if (GetPlatform.isIOS)
                  //   Row(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: [
                  //       // SocialIcon(iconSrc: 'assets/images/facebook.png', onPressed: () {}),
                  //       SocialIcon(
                  //           iconSrc: 'assets/images/google.png',
                  //           onPressed: () {
                  //             // login.signInWithGoogle(context: context);
                  //           }),
                  //       // SocialIcon(iconSrc: 'assets/images/apple.png', onPressed: () {})
                  //     ],
                  //   ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Đã có tài khoản? ",
                        style: theme.textTheme.bodyMedium,
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.offNamed(Routes.login);
                        },
                        child: Text('Đăng nhập', style: text16.textPrimaryColor),
                      ),
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

  Card _buildForm(ThemeData theme) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            AppTextField(
              title: 'Họ và tên*',
              hintText: 'Nguyễn Văn A',
              controller: controller.fullNameController,
              onChanged: (value) {},
              obscureText: false,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Vui lòng nhập họ tên';
                } else if (value.length > 32) {
                  return 'Họ và tên không vượt quá 32 ký tự';
                }
                return null;
              },
            ),
            const SizedBox(height: 24),
            AppTextField(
              title: 'Email*',
              hintText: 'example@gmail.com',
              controller: controller.usernameController,
              onChanged: (value) {},
              obscureText: false,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Vui lòng nhập email';
                }
                String pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
                RegExp regex = RegExp(pattern);
                if (!regex.hasMatch(value)) {
                  return 'Vui lòng nhập đúng định dạng email';
                }
                return null;
              },
            ),
            const SizedBox(height: 24),
            AppTextField(
              title: 'Số điện thoại',
              hintText: 'Vui lòng nhập số điện thoại',
              controller: controller.phoneNumberController,
              onChanged: (value) {},
              obscureText: false,
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 24),
            AppTextField(
              title: 'Mật khẩu*',
              hintText: 'Mật khẩu',
              controller: controller.passwordController,
              onChanged: (value) {},
              icon: controller.isPasswordVisible.value ? Icons.visibility : Icons.visibility_off,
              iconColor: AppColors.lightPrimary,
              obscureText: !controller.isPasswordVisible.value,
              onClickIcon: () {
                controller.isPasswordVisible.value = !controller.isPasswordVisible.value;
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Vui lòng nhập mật khẩu';
                }
                if (value.length < 4) {
                  return 'Mật khẩu phải có ít nhất 4 ký tự';
                }
                return null;
              },
            ),
            const SizedBox(height: 24),
            AppTextField(
              title: 'Xác nhận mật khẩu*',
              hintText: 'Xác nhận mật khẩu',
              controller: controller.confirmPassController,
              onChanged: (value) {},
              icon: controller.isPasswordConfirmVisible.value ? Icons.visibility : Icons.visibility_off,
              iconColor: AppColors.lightPrimary,
              obscureText: !controller.isPasswordConfirmVisible.value,
              onClickIcon: () {
                controller.isPasswordConfirmVisible.value = !controller.isPasswordConfirmVisible.value;
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Vui lòng nhập xác thực mật khẩu';
                } else if (value != controller.passwordController.text) {
                  return 'Xác thực mật khẩu không khớp';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextButton(
              clipBehavior: Clip.none,
              style: ButtonStyle(
                padding: WidgetStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.all(0)),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              onPressed: () {
                controller.isAgreedToPrivacyPolicy.value = !controller.isAgreedToPrivacyPolicy.value;
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 18,
                    width: 18,
                    child: Checkbox(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                      value: controller.isAgreedToPrivacyPolicy.value,
                      activeColor: AppColors.lightPrimary,
                      onChanged: (value) {
                        controller.isAgreedToPrivacyPolicy.value = value!;
                      },
                    ),
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: RichText(
                        text: TextSpan(
                          style: const TextStyle(fontSize: 16, color: Colors.black, height: 1.5),
                          children: [
                            TextSpan(text: 'Tôi đồng ý với ', style: theme.textTheme.bodyMedium),
                            TextSpan(
                              text: 'Chính sách riêng tư',
                              style: const TextStyle(
                                color: AppColors.lightPrimary,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () async {
                                  // Xử lý khi người dùng bấm vào "Chính sách quyền riêng tư"
                                  if (!await launchUrl(
                                      Uri.parse('https://hoc24.vn/tin-tuc/Chinh-sach-rieng-tu,-bao-mat.html'))) {
                                    throw Exception('Could not launch url}');
                                  }
                                },
                            ),
                            TextSpan(text: ' và ', style: theme.textTheme.bodyMedium),
                            TextSpan(
                              text: 'Điều khoản sử dụng ứng dụng và dịch vụ',
                              style: const TextStyle(
                                color: AppColors.lightPrimary,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () async {
                                  // Xử lý khi người dùng bấm vào "Chính sách quyền riêng tư"
                                  if (!await launchUrl(
                                      Uri.parse('https://hoc24.vn/tin-tuc/Dieu-khoan-su-dung-hoc24-vn.html'))) {
                                    throw Exception('Could not launch url}');
                                  }
                                },
                            ),
                          ],
                        ),
                      ),
                    ),
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
