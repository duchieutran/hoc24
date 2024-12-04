import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hoc24/app/config/app_colors.dart';
import 'package:hoc24/app/helpers/confirm_dialog_helper.dart';
import 'package:hoc24/presentation/controllers/profile/profile_controller.dart';
import 'package:hoc24/presentation/pages/base/base_scaffold.dart';
import 'package:hoc24/presentation/widgets/app_avatar.dart';
import 'package:hoc24/presentation/widgets/app_button.dart';

import 'card/setting_tile.dart';

class ProfilePage extends GetView<ProfileController> {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Obx(
      () => BaseScaffold(
        backgroundColor:
            controller.appController.isDarkMode.value ? AppColors.darkBackground : AppColors.lightBackground,
        isPaddingDefault: true,
        appBar: appBar(theme),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SettingTile(
                  icon1: Icons.person_outline,
                  name1: 'Thông tin cá nhân',
                  onTap1: () => controller.goToPersonalInformationPage(),
                ),
                SettingTile(
                  icon1: Icons.dark_mode,
                  name1: 'Chế độ tối',
                  onTap1: () => controller.goToDarkModePage(),
                ),
                // SettingTile(
                //   icon1: Icons.help_outline,
                //   name1: 'Trợ giúp',
                //   onTap1: () => controller.goToPersonalInformationPage(),
                //   icon2: Icons.security,
                //   name2: 'Chính sách bảo mật',
                //   onTap2: () => controller.goToPersonalInformationPage(),
                // ),
                SettingTile(
                    icon1: Icons.lock,
                    name1: 'Đổi mật khẩu',
                    onTap1: () => controller.goToChangePasswordPage(),
                    icon2: Icons.delete,
                    name2: 'Xoá tài khoản',
                    onTap2: () => Get.dialog(
                          ConfirmDialogHelper(
                            title: "Bạn muốn xoá tài khoản\nTài khoản sau khi xoá không thể khôi phục",
                            onPress: () {
                              controller.deleteAccount();
                              Get.back();
                            },
                          ),
                        )),
                const SizedBox(height: 8),
                Center(
                  child: AppButton(
                    text: 'Đăng xuất',
                    textColor: Colors.red,
                    isLoading: controller.pageLoading,
                    onPressed: () => Get.dialog(
                      ConfirmDialogHelper(
                          title: "Đăng xuất khỏi tài khoản của bạn",
                          onPress: () async {
                            Get.back();
                            controller.pageLoadingOn();
                            await controller.appController.onLogout();
                            controller.pageLoadingOff();
                          }),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  PreferredSize appBar(ThemeData theme) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(80.0),
      child: Container(
        padding: const EdgeInsets.only(top: 8, left: 12, right: 12),
        decoration: BoxDecoration(
          color: controller.appController.isDarkMode.value ? AppColors.darkSecondary : AppColors.lightBlue30,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(32.0),
            bottomRight: Radius.circular(32.0),
          ),
        ),
        child: SafeArea(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppAvatar(
                name: controller.appController.user?.name ?? '',
                url: controller.appController.user?.images ?? '',
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  Text(
                    'Xin chào, ${controller.appController.user?.name ?? 'Name'}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.titleMedium,
                  ),
                  Text(controller.appController.user?.email ?? 'Name', style: theme.textTheme.bodyMedium),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
