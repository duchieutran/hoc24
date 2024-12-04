import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hoc24/app/config/app_text.dart';
import 'package:hoc24/domain/models/response/user/user_entity.dart';
import 'package:hoc24/presentation/widgets/app_avatar.dart';

class ConversationCard extends StatelessWidget {
  final UserEntity user;
  final bool isLastMessage;
  final bool isNewMessage;
  final String lastmess;
  final String timeAgo;
  final Function(String, String, String) onTap;
  final Function(String) onTapAvatar;

  const ConversationCard({
    super.key,
    required this.user,
    required this.isLastMessage,
    required this.isNewMessage,
    required this.lastmess,
    required this.timeAgo,
    required this.onTap,
    required this.onTapAvatar,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Stack(
      children: [
        InkWell(
          onTap: () => onTap(user.name ?? '', user.id ?? '', user.images ?? ''),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () => onTapAvatar(user.id ?? ''),
                  child: AppAvatar(
                    name: user.name ?? '',
                    url: user.images ?? '',
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 1),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(user.name ?? '',
                            style: isNewMessage ? theme.textTheme.titleLarge : theme.textTheme.bodyLarge),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                isLastMessage ? 'Bạn: $lastmess' : lastmess,
                                style: isNewMessage ? theme.textTheme.titleMedium : text16.textGreyColor,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Text(timeAgo, style: isNewMessage ? theme.textTheme.titleMedium : text16.textGreyColor),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ).animate(delay: 0.ms).fadeIn(delay: 1.ms).slideY(begin: 0.3, end: 0);
  }
}
