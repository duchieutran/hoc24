import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hoc24/app/config/app_colors.dart';
import 'package:hoc24/presentation/controllers/profile/personal_information/edit_personal_information/edit_personal_information_controller.dart';
import 'package:hoc24/presentation/pages/base/base_scaffold.dart';
import 'package:hoc24/presentation/widgets/app_avatar.dart';
import 'package:hoc24/presentation/widgets/app_button.dart';
import 'package:hoc24/presentation/widgets/app_text_field.dart';

class EditPersonalInformationPage extends GetView<EditPersonalInformationController> {
  const EditPersonalInformationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Obx(
      () => BaseScaffold(
        backgroundColor:
            controller.appController.isDarkMode.value ? AppColors.darkBackground : AppColors.lightBackground,
        appBar: AppBar(
          title: const Text('Chỉnh sửa thông tin cá nhân'),
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildForm(theme),
                  const SizedBox(height: 16),
                  AppButton(
                    text: 'Lưu thông tin',
                    onPressed: () async {
                      FocusManager.instance.primaryFocus?.unfocus();
                      if (controller.formKey.currentState!.validate()) {
                        await controller.onUpdate(context);
                      }
                    },
                    isLoading: controller.pageLoading,
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
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AppAvatar(
                  name: controller.appController.user?.name ?? '',
                  url: controller.appController.user?.images ?? '',
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(controller.appController.user?.name ?? 'Name', style: theme.textTheme.titleMedium),
                    const SizedBox(height: 4),
                    Text(controller.appController.user?.email ?? 'Name', style: theme.textTheme.bodyMedium),
                  ],
                ),
              ],
            ),
            const Divider(color: AppColors.lightGrey, height: 32),
            const SizedBox(height: 8),
            AppTextField(
              title: 'Họ và tên',
              hintText: 'Họ và tên',
              controller: controller.usernameController,
              enabled: false,
            ),
            const SizedBox(height: 24),
            AppTextField(
              title: 'Email',
              hintText: 'Email',
              controller: controller.emailController,
              enabled: false,
            ),
            const SizedBox(height: 24),
            AppTextField(
              title: 'Số điện thoại',
              hintText: 'Số điện thoại',
              controller: controller.phoneController,
              keyboardType: TextInputType.phone,
            ),
          ],
        ),
      ),
    );
  }
}
