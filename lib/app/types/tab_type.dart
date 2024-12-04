import 'package:flutter/cupertino.dart';
import 'package:hoc24/app/config/app_colors.dart';

enum TabType { dashboard, questions, profile }

extension TabItem on TabType {
  Icon get icon0 {
    switch (this) {
      case TabType.dashboard:
        return const Icon(CupertinoIcons.home, size: 24);
      case TabType.questions:
        return const Icon(CupertinoIcons.question, size: 24);
      case TabType.profile:
        return const Icon(CupertinoIcons.person, size: 24);
    }
  }

  Icon get icon1 {
    switch (this) {
      case TabType.dashboard:
        return const Icon(CupertinoIcons.home, size: 24, color: AppColors.lightPrimary);
      case TabType.questions:
        return const Icon(CupertinoIcons.question, size: 24, color: AppColors.lightPrimary);
      case TabType.profile:
        return const Icon(CupertinoIcons.person, size: 24, color: AppColors.lightPrimary);
    }
  }

  String get title {
    switch (this) {
      case TabType.dashboard:
        return "Trang chủ";
      case TabType.questions:
        return "Hỏi đáp";
      case TabType.profile:
        return "Tôi";
    }
  }
}
