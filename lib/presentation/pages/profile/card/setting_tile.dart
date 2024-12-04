import 'package:flutter/material.dart';
import 'package:hoc24/app/config/app_colors.dart';

class SettingTile extends StatelessWidget {
  final IconData? icon1;
  final String? name1;
  final VoidCallback? onTap1;
  final IconData? icon2;
  final String? name2;
  final VoidCallback? onTap2;
  final IconData? icon3;
  final String? name3;
  final VoidCallback? onTap3;

  const SettingTile({
    super.key,
    this.icon1,
    this.name1,
    this.onTap1,
    this.icon2,
    this.name2,
    this.onTap2,
    this.icon3,
    this.name3,
    this.onTap3,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 2,
        child: Column(
          children: [
            if (name1 != null)
              InkWell(
                onTap: onTap1,
                customBorder: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                  child: Row(
                    children: [
                      Icon(
                        icon1 ?? Icons.adb,
                        color: theme.colorScheme.primary,
                      ),
                      const SizedBox(width: 16),
                      Text(name1 ?? '', style: theme.textTheme.bodyLarge),
                      const Spacer(),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: theme.colorScheme.onSurface,
                        size: 18,
                      ),
                    ],
                  ),
                ),
              ),
            if (name2 != null)
              InkWell(
                onTap: onTap2,
                customBorder: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                  child: Row(
                    children: [
                      Icon(
                        icon2 ?? Icons.adb,
                        color: theme.colorScheme.primary,
                      ),
                      const SizedBox(width: 16),
                      Text(name2 ?? '', style: theme.textTheme.bodyLarge),
                      const Spacer(),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: theme.colorScheme.onSurface,
                        size: 18,
                      ),
                    ],
                  ),
                ),
              ),
            if (name3 != null)
              InkWell(
                onTap: onTap3,
                customBorder: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                  child: Row(
                    children: [
                      Icon(
                        icon3 ?? Icons.adb,
                        color: theme.colorScheme.primary,
                      ),
                      const SizedBox(width: 16),
                      Text(name3 ?? '', style: theme.textTheme.bodyLarge),
                      const Spacer(),
                      const Icon(
                        Icons.arrow_forward_ios,
                        color: AppColors.nature50,
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
