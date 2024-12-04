import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hoc24/app/config/app_colors.dart';
import 'package:hoc24/presentation/controllers/profile/change_password/change_password_controller.dart';
import 'package:hoc24/presentation/pages/base/base_scaffold.dart';
import 'package:hoc24/presentation/widgets/app_button.dart';
import 'package:hoc24/presentation/widgets/app_text_field.dart';

class ChangePasswordPage extends GetView<ChangePasswordController> {
  const ChangePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => BaseScaffold(
        isLoading: controller.pageLoading,
        backgroundColor:
            controller.appController.isDarkMode.value ? AppColors.darkBackground : AppColors.lightBackground,
        appBar: AppBar(
          title: const Text('Đổi mật khẩu'),
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Form(
              key: controller.formKeySignUp,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildForm(),
                  const SizedBox(height: 16),
                  AppButton(
                      text: 'Xác nhận',
                      onPressed: () async {
                        FocusManager.instance.primaryFocus?.unfocus();
                        if (controller.formKeySignUp.currentState!.validate()) {
                          await controller.changePassword(context);
                        }
                      }),
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
              title: 'Mật khẩu cũ*',
              hintText: 'Mật khẩu cũ',
              controller: controller.oldPasswordController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Vui lòng nhập mật khẩu cũ';
                }
                return null;
              },
            ),
            const SizedBox(height: 24),
            AppTextField(
              title: 'Mật khẩu mới*',
              hintText: 'Mật khẩu mới',
              controller: controller.passwordController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Vui lòng nhập mật khẩu mới';
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
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Vui lòng nhập xác thực mật khẩu';
                } else if (value != controller.passwordController.text) {
                  return 'Xác thực mật khẩu không khớp';
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }
}
