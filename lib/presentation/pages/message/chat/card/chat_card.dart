import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:hoc24/app/config/app_colors.dart';
import 'package:hoc24/app/config/app_text.dart';
import 'package:hoc24/presentation/widgets/app_avatar.dart';

class ChatCard extends StatelessWidget {
  final String name;
  final String images;
  final bool isUser;
  final String text;
  final String timeAgo;
  final bool isShowTimeAgo;
  final int index;
  final void Function(int) onTapMessage;

  const ChatCard({
    super.key,
    required this.name,
    required this.images,
    required this.isUser,
    required this.text,
    required this.timeAgo,
    required this.isShowTimeAgo,
    required this.index,
    required this.onTapMessage,
  });

  @override
  Widget build(BuildContext context) {
    if (isUser) {
      return GestureDetector(
        onTap: () => onTapMessage(index),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            color: AppColors.lightPrimary,
          ),
          constraints: BoxConstraints(maxWidth: Get.width * 0.6),
          child: RichText(
            textAlign: TextAlign.left,
            text: TextSpan(
              children: [
                TextSpan(
                  text: text,
                  style: text16.textLightColor,
                ),
                if (isShowTimeAgo)
                  TextSpan(
                    text: '\n$timeAgo',
                    style: text14.textNature30Color,
                  ),
              ],
            ),
          ),
        ),
      ).animate(delay: 0.ms).fadeIn(delay: 0.ms).slideY(begin: 0.1, end: 0);
    } else {
      return GestureDetector(
        onTap: () => onTapMessage(index),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            AppAvatar(name: name, radius: 22, url: images),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.all(10),
              constraints: BoxConstraints(maxWidth: Get.width * 0.6),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                color: AppColors.nature20,
              ),
              child: RichText(
                textAlign: TextAlign.left,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: text,
                      style: text16.textDarkColor,
                    ),
                    if (isShowTimeAgo)
                      TextSpan(
                        text: '\n$timeAgo',
                        style: text14.textGreyColor,
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ).animate(delay: 0.ms).fadeIn(delay: 0.ms).slideY(begin: 0.1, end: 0);
    }
  }
}
