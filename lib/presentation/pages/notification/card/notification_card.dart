import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hoc24/app/config/app_text.dart';
import 'package:hoc24/app/extensions/icon_mapper.dart';
import 'package:hoc24/domain/models/response/app_bar/notification_entity.dart';
import 'package:hoc24/presentation/widgets/app_avatar.dart';

class NotificationCard extends StatelessWidget {
  final NotificationNode notification;
  final String timeAgo;
  final VoidCallback onTap;
  final VoidCallback onTapAvatar;

  const NotificationCard({
    super.key,
    required this.notification,
    required this.timeAgo,
    required this.onTap,
    required this.onTapAvatar,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    String getTitle() {
      if (notification.infoNoti?.message == 'đã nhận được danh hiệu') {
        return 'Bạn đã nhận được danh hiệu';
      }
      return '${notification.infoFromUser?.name} ${notification.infoNoti?.message} bạn';
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: (notification.viewed ?? 0) != 0 ? theme.colorScheme.surface : Colors.blue.withOpacity(0.1),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        height: 85,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: onTapAvatar,
              child: AppAvatar(
                name: notification.infoFromUser?.name ?? '',
                icons: IconMapper.getIconFromString(notification.infoNoti?.icon ?? ''),
                url: notification.infoFromUser?.images ?? '',
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    getTitle(),
                    style: theme.textTheme.bodyMedium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(timeAgo, style: text15.textGreyColor),
                ],
              ),
            ),
          ],
        ),
      ).animate(delay: 0.ms).fadeIn(delay: 1.ms).slideY(begin: 0.3, end: 0),
    );
  }
}
