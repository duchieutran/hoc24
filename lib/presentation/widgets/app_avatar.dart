import 'package:flutter/material.dart';
import 'package:hoc24/app/config/app_colors.dart';
import 'package:hoc24/presentation/widgets/app_image.dart';

class AppAvatar extends StatelessWidget {
  final String name;
  final String url;
  final double radius;
  final IconData? icons;
  final Color color;

  const AppAvatar({
    super.key,
    required this.name,
    required this.url,
    this.radius = 26,
    this.icons,
    this.color = Colors.blueGrey,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        url.isNotEmpty ? _buildAvatar(url) : _buildAvatarDefault(),
        if (icons != null)
          Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                width: 24,
                height: 24,
                decoration: const BoxDecoration(
                  color: AppColors.lightPrimary,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icons,
                  color: AppColors.light,
                  size: 16,
                ),
              )),
      ],
    );
  }

  Widget _buildAvatar(String url) {
    String images = '';
    if (url.contains('http')) {
      images = url;
    } else {
      images = 'https://hoc24.vn/images/avt/$url';
    }

    return AppImage(
      images,
      radius * 2,
      radius * 2,
      circular: radius,
    );
  }

  CircleAvatar _buildAvatarDefault() {
    // Lấy chữ cái đầu tiên của hai từ cuối cùng
    String initials = '';

    if (name.isEmpty) {
      initials = 'Hoc24';
    } else {
      final RegExp regExp = RegExp(
          r'[\u2700-\u27bf]|(?:\ud83c[\udde6-\uddff]){2}|[\ud800-\udbff][\udc00-\udfff]|[\u0023-\u0039]\ufe0f?\u20e3|\u3299|\u3297|\u303d|\u3030|\u24c2|\ud83c[\udd70-\udd71]|\ud83c[\udd7e-\udd7f]|\ud83c\udd8e|\ud83c[\udd91-\udd9a]|\ud83c[\udde6-\uddff]|\ud83c[\ude01-\ude02]|\ud83c\ude1a|\ud83c\ude2f|\ud83c[\ude32-\ude3a]|\ud83c[\ude50-\ude51]|\u203c|\u2049|[\u25aa-\u25ab]|\u25b6|\u25c0|[\u25fb-\u25fe]|\u00a9|\u00ae|\u2122|\u2139|\ud83c\udc04|[\u2600-\u26FF]|\u2b05|\u2b06|\u2b07|\u2b1b|\u2b1c|\u2b50|\u2b55|\u231a|\u231b|\u2328|\u23cf|[\u23e9-\u23f3]|[\u23f8-\u23fa]|\ud83c\udccf|\u2934|\u2935|[\u2190-\u21ff]');
      // Tách tên thành các từ
      List<String> nameParts = name.replaceAll(regExp, '').trim().split(RegExp(r'\s+'));

      try {
        if (nameParts.length >= 2) {
          initials =
              nameParts[nameParts.length - 2][0].toUpperCase() + nameParts[nameParts.length - 1][0].toUpperCase();
        } else if (nameParts.length == 1) {
          initials = nameParts[0][0].toUpperCase();
        }
      } catch (_) {
        initials = 'Hoc24';
      }
    }

    return CircleAvatar(
      backgroundColor: initials == 'Hoc24' ? AppColors.nature20 : color,
      radius: radius,
      child: Text(
        initials,
        style: initials == 'Hoc24'
            ? TextStyle(
                color: AppColors.lightPrimary,
                fontSize: radius / 2,
                fontWeight: FontWeight.bold,
              )
            : TextStyle(
                color: AppColors.light,
                fontSize: radius,
              ),
      ),
    );
  }
}
