import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hoc24/app/config/app_colors.dart';
import 'package:hoc24/app/helpers/confirm_dialog_helper.dart';
import 'package:hoc24/domain/models/response/user/user_entity.dart';
import 'package:hoc24/presentation/widgets/app_avatar.dart';
import 'package:hoc24/presentation/widgets/app_button.dart';

class FollowerCard extends StatelessWidget {
  final UserEntity? user;
  final VoidCallback onFollow;
  final VoidCallback onTap;

  const FollowerCard({
    super.key,
    required this.user,
    required this.onFollow,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        height: 70,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppAvatar(
              name: user?.name ?? '',
              url: user?.images ?? '',
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                user?.name ?? '',
                style: theme.textTheme.bodyMedium,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            AppButton(
              text: user?.userInfo?.isFollow ?? false ? 'Đang theo dõi' : 'Theo dõi',
              fontSize: 14,
              height: 10,
              width: 100,
              elevation: 0,
              backgroundColor:
                  user?.userInfo?.isFollow ?? false ? AppColors.lightGrey.withOpacity(0.2) : AppColors.lightPrimary,
              textColor: user?.userInfo?.isFollow ?? false ? theme.colorScheme.onSurface : AppColors.light,
              onPressed: () => user?.userInfo?.isFollow ?? false
                  ? Get.dialog(
                      ConfirmDialogHelper(
                        title: "Bạn muốn huỷ theo dõi ${user?.name}",
                        onPress: () {
                          onFollow();
                          Get.back();
                        },
                      ),
                    )
                  : onFollow(),
            ),
          ],
        ),
      ),
    );
  }
}
