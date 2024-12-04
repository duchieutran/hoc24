import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:hoc24/app/config/app_colors.dart';
import 'package:hoc24/app/routes/app_pages.dart';
import 'package:timelines/timelines.dart';

class TimeLine extends StatelessWidget {
  final List<String> lessonList;
  final List<int> idLessonList;
  const TimeLine({
    super.key,
    required this.lessonList,
    required this.idLessonList,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: lessonList.length,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => CustomTimeLineWidget(
        index: index,
        lessonsList: lessonList,
        idLessonList: idLessonList,
      ),
    );
  }
}

class CustomTimeLineWidget extends StatelessWidget {
  final int index;
  final List<String> lessonsList;
  final List<int> idLessonList;

  const CustomTimeLineWidget({
    super.key,
    required this.index,
    required this.lessonsList,
    required this.idLessonList,
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
    return GestureDetector(
      onTap: () => Get.toNamed(
        Routes.lessonDetail,
        arguments: {
          'title': lessonsList[index],
          'id': idLessonList[index],
        },
      ),
      child: TimelineTile(
        node: TimelineNode(
          indicatorPosition: 0.25,
          startConnector: index == 0 ? null : dashedLine,
          endConnector: index == lessonsList.length - 1 ? null : dashedLine,
          indicator: outLinedIndicator,
        ),
        contents: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 40,
                child: Text(
                  lessonsList[index],
                  style: theme.textTheme.bodyMedium,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ).animate(delay: 200.ms).fadeIn(delay: (30 * index).ms).slideY(begin: 0.3, end: 0),
        ),
        nodePosition: 0,
      ),
    );
  }
}
