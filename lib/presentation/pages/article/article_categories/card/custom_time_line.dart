import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hoc24/app/config/app_colors.dart';
import 'package:timelines/timelines.dart';

class CustomTimeLineWidget extends StatelessWidget {
  final int index;
  final List<String> lessons;
  final VoidCallback onTap;
  const CustomTimeLineWidget({
    super.key,
    required this.index,
    required this.lessons,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const dashedLine = DashedLineConnector(
      gap: 3,
      dash: 6,
      color: AppColors.lightPrimary,
    );
    const outLinedIndicator = OutlinedDotIndicator(
      size: 25,
      color: AppColors.lightPrimary,
    );
    return SizedBox(
      child: TimelineTile(
        node: TimelineNode(
          indicatorPosition: 0.25,
          startConnector: index == 0 ? null : dashedLine,
          endConnector: index == lessons.length - 1 ? null : dashedLine,
          indicator: outLinedIndicator,
        ),
        contents: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 40,
                  child: Text(
                    lessons[index],
                    style: theme.textTheme.bodyMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ).animate(delay: 300.ms).fadeIn(delay: (100 * index).ms).slideY(begin: 0.3, end: 0),
          ),
        ),
        nodePosition: 0,
      ),
    );
  }
}
