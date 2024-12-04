import 'package:flutter/material.dart';

class IconMapper {
  // Map để ánh xạ tên icon tới IconData
  static final Map<String, IconData> _iconMapping = {
    'edit-3': Icons.edit_note,
    'message-circle': Icons.comment,
    'thumbs-up': Icons.thumb_up,
    'bookmark': Icons.bookmark,
    'eye': Icons.remove_red_eye,
    'twitch': Icons.message,
    'help-circle': Icons.help,
    'award': Icons.card_giftcard,
    'edit': Icons.edit,
    'list': Icons.list,
  };

  // Hàm để lấy IconData từ tên icon
  static IconData? getIconFromString(String iconName) {
    return _iconMapping[iconName] ?? Icons.info;
  }
}
