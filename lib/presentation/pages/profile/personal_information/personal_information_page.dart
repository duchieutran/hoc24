import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hoc24/app/config/app_colors.dart';
import 'package:hoc24/app/config/app_text.dart';
import 'package:hoc24/app/helpers/confirm_dialog_helper.dart';
import 'package:hoc24/presentation/controllers/profile/personal_information/personal_information_controller.dart';
import 'package:hoc24/presentation/pages/base/base_scaffold.dart';
import 'package:hoc24/presentation/widgets/app_avatar.dart';
import 'package:hoc24/presentation/widgets/app_button.dart';

class PersonalInformationPage extends StatelessWidget {
  const PersonalInformationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final PersonalInformationController controller = Get.find(tag: Get.parameters['id']);
    return Obx(
      () => BaseScaffold(
        isPaddingDefault: true,
        isLoading: controller.pageLoading,
        appBar: AppBar(
          title: Text(controller.user.value.name ?? 'Name'),
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildHeader(controller, theme),
                const SizedBox(height: 8),
                Text(controller.user.value.name ?? '', style: theme.textTheme.titleLarge),
                const SizedBox(height: 8),
                _buildInformationField(
                  icon: Icons.question_mark,
                  iconSize: 20,
                  color: AppColors.lightPrimary,
                  title: '${controller.userInfo?.countAnswer ?? 0} câu trả lời',
                  fontSizeSmall: true,
                  paddingTop: 4,
                  theme: theme,
                ),
                _buildInformationField(
                  icon: Icons.score,
                  iconSize: 20,
                  color: AppColors.lightBlue30,
                  title: '${controller.userInfo?.scoreGp ?? 0} GP',
                  fontSizeSmall: true,
                  paddingTop: 4,
                  theme: theme,
                ),
                _buildInformationField(
                  icon: Icons.star_border,
                  iconSize: 20,
                  color: Colors.orangeAccent,
                  title: '${controller.userInfo?.scoreSp ?? 0} SP',
                  fontSizeSmall: true,
                  paddingTop: 4,
                  theme: theme,
                ),
                _buildInformationField(
                  icon: CupertinoIcons.gift,
                  iconSize: 20,
                  color: Colors.red,
                  title: '${controller.userInfo?.countAward ?? 0} giải thưởng',
                  fontSizeSmall: true,
                  paddingTop: 4,
                  theme: theme,
                ),
                const SizedBox(height: 16),
                controller.isMe
                    ? _buildEditButton(() => controller.goToPersonalInformationPage(), theme)
                    : _buildButton(
                        isFollow: controller.userInfo?.isFollow ?? false,
                        name: controller.user.value.name ?? '',
                        onFollow: () => controller.onFollow(controller.id),
                        onChat: () => controller.goToChatPage(controller.user.value.name ?? '', controller.id),
                        theme: theme,
                      ),
                const Divider(height: 24, color: AppColors.lightGrey),
                _buildDetail(controller, theme),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column _buildHeader(PersonalInformationController controller, ThemeData theme) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppAvatar(
              name: controller.user.value.name ?? '',
              radius: 32,
              url: controller.user.value.images ?? '',
            ),
            _buildInformationBox(
              controller.userInfo?.countQuestion ?? 0,
              'Câu hỏi',
              theme,
              onTap: () => controller.goToPersonalQuestionPage(),
            ),
            const SizedBox(width: 6),
            _buildInformationBox(
              controller.userInfo?.countFollowing ?? 0,
              'Người theo dõi',
              theme,
              onTap: () => controller.goToFollowersPage(0),
            ),
            const SizedBox(width: 6),
            _buildInformationBox(
              controller.userInfo?.countFollower ?? 0,
              'Đang theo dõi',
              theme,
              onTap: () => controller.goToFollowersPage(1),
            ),
          ],
        ),
      ],
    );
  }

  Row _buildButton(
      {required bool isFollow,
      required String name,
      required VoidCallback onFollow,
      required VoidCallback onChat,
      required ThemeData theme}) {
    return Row(
      children: [
        Expanded(
          child: AppButton(
            text: isFollow ? 'Đang theo dõi' : 'Theo dõi',
            fontSize: 14,
            height: 12,
            elevation: 0,
            backgroundColor: isFollow ? AppColors.lightGrey.withOpacity(0.2) : AppColors.lightPrimary,
            textColor: isFollow ? theme.colorScheme.onSurface : AppColors.light,
            onPressed: () => isFollow
                ? Get.dialog(
                    ConfirmDialogHelper(
                      title: "Bạn muốn huỷ theo dõi $name",
                      onPress: () {
                        onFollow();
                        Get.back();
                      },
                    ),
                  )
                : onFollow(),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: AppButton(
            text: 'Nhắn tin',
            fontSize: 14,
            height: 12,
            elevation: 0,
            backgroundColor: AppColors.lightGrey.withOpacity(0.2),
            textColor: theme.colorScheme.onSurface,
            onPressed: onChat,
          ),
        )
      ],
    );
  }

  Row _buildEditButton(VoidCallback onTap, ThemeData theme) {
    return Row(
      children: [
        Expanded(
          child: AppButton(
            text: 'Chỉnh sửa thông tin cá nhân',
            fontSize: 14,
            height: 16,
            elevation: 0,
            backgroundColor: AppColors.lightGrey.withOpacity(0.2),
            textColor: theme.colorScheme.onSurface,
            onPressed: onTap,
          ),
        )
      ],
    );
  }

  Column _buildDetail(PersonalInformationController controller, ThemeData theme) {
    String address = controller.getAddress(controller.userInfo?.city ?? '');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Chi tiết', style: text18.bold),
        _buildInformationField(
          icon: Icons.school_outlined,
          title: 'Học tại ${controller.userInfo?.school}',
          theme: theme,
        ),
        if (address.isNotEmpty)
          _buildInformationField(
            icon: Icons.home_outlined,
            title: 'Sống tại $address',
            theme: theme,
          ),
      ],
    );
  }

  Expanded _buildInformationBox(int count, String title, ThemeData theme, {VoidCallback? onTap}) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(count.toString(), style: theme.textTheme.titleMedium),
            Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }

  Padding _buildInformationField({
    required IconData icon,
    double iconSize = 28,
    Color? color,
    required String title,
    bool fontSizeSmall = false,
    double paddingTop = 16,
    required ThemeData theme,
  }) {
    return Padding(
      padding: EdgeInsets.only(top: paddingTop),
      child: Row(
        children: [
          Icon(icon, size: iconSize, color: color),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: fontSizeSmall ? theme.textTheme.bodyMedium : theme.textTheme.bodyLarge,
            ),
          ),
        ],
      ),
    );
  }
}
